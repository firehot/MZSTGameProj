#import "MZCharacter.h"
#import "MZLevelComponentsHeader.h"
#import "MZSTGSettingsHeader.h"
#import "MZBehaviorsHeader.h"
#import "MZColor.h"
#import "MZUtilitiesHeader.h"
#import "MZCharacterDynamicSetting.h"
#import "MZSTGGameHelper.h"
#import "MZQueue.h"

@interface MZCharacter (Private)
-(void)_setValuesBySetting;
-(void)_setDynamicSetting;
-(void)_setCharacterPartsByDictionary:(NSDictionary *)settingDictionary;
-(void)_setModesWithSettingsArray:(NSArray *)settingsArray;
-(void)_switchCurrentMode;
-(void)_checkAndAddDefaultSingleModeSettingToModeSettingsArray;
-(void)_updateMode;
@end

@implementation MZCharacter

@synthesize isUsingDynamicSetting;
@synthesize isLeader;
@synthesize disableAttack;
@synthesize currentHealthPoint;
@synthesize spawnPosition;
@synthesize characterType;
@synthesize currentMovingVector;
@synthesize characterDynamicSetting;
@synthesize spawnParentCharacterRef;
@synthesize leaderCharacterRef;
@synthesize spawnParentCharacterPartRef;

#pragma mark - init and dealloc

+(MZCharacter *)characterWithLevelComponenets:(MZLevelComponents *)aLevelComponents
{
    return [[[self alloc] initWithLevelComponenets: aLevelComponents] autorelease];
}

-(void)dealloc
{    
    [currentMode release];
    [modeSettingsQueue release];
    [setting release];
    [characterDynamicSetting release];
    
    spawnParentCharacterRef = nil;
    spawnParentCharacterPartRef = nil;
    leaderCharacterRef = nil;

    [super dealloc];
}

#pragma mark - properties

-(void)setDisableAttack:(bool)aDisableAttack
{
    disableAttack = aDisableAttack;
    currentMode.disableAttack = disableAttack;
}

-(void)setCharacterType:(MZCharacterType)aCharacterType
{
    characterType = aCharacterType;
    
    // 當設定為 none 時, 則歸還( not yet, 目前開發中, 所以使用 Assert )    
    MZAssert( characterType != kMZCharacterType_Unknow, @"characterType can not be kMZCharacterType_None" );
    MZAssert( levelComponentsRef.spritesPool, @"levelComponentsRef.spritesPool is nil" );
        
    for( MZCharacter *child in [childrenDictionary allValues] )
        child.characterType = characterType;
}

-(MZCharacterType)characterType
{
    return characterType;
}

-(CGPoint)currentMovingVector
{
    return currentMode.currentMotion.currentMovingVector;
}

#pragma mark - methods

-(void)setSetting:(MZCharacterSetting *)aSetting characterType:(MZCharacterType)aCharacterType
{
    setting = [aSetting retain];
    self.characterType = aCharacterType;
    
    [self _setValuesBySetting];
    [self _setDynamicSetting];
    [self _setCharacterPartsByDictionary: setting.characterPartSettingsDictionary];
    [self _setModesWithSettingsArray: setting.modeSettings];
}

-(void)applyDynamicSetting
{
    isUsingDynamicSetting = true;
    
//    MZAssert( modeSettingsArray != nil, @"modeSettingsArray is nil" );
//    MZAssert( [modeSettingsArray count] == 1, @"modeSettingsArray count is not ONE" );
//    
//    MZModeSetting *firstModeSetting = [modeSettingsArray objectAtIndex: 0];
    
    MZAssert( modeSettingsQueue != nil, @"modeSettingsArray is nil" );
    MZAssert( [modeSettingsQueue count] == 1, @"modeSettingsArray count is not ONE" );
    
    MZModeSetting *firstModeSetting = [modeSettingsQueue objectAtIndex: 0];

//    NSMutableArray *characterPartControlSettings = [[firstModeSetting.characterPartControlSettingsDictionary allValues] mutableCopy]; // <--retain, 會 leak ... 
    NSArray *characterPartControlSettings = [firstModeSetting.characterPartControlSettingsDictionary allValues];
    MZAssert( characterPartControlSettings != nil, @"characterPartControlSettings is nil" );
    MZAssert( [characterPartControlSettings count] == 1, @"characterPartControlSettings count is not ONE" );
    
    MZCharacterPartControlSetting *firstCharacterPartControlSetting = [characterPartControlSettings objectAtIndex: 0];
    firstCharacterPartControlSetting.faceTo = characterDynamicSetting.faceTo;
}

-(void)setSpawnWithParentCharacter:(MZCharacter *)aParentCharacter spawnPosition:(CGPoint)aSpawnPosition
{
    spawnParentCharacterRef = aParentCharacter;
    spawnPosition = aSpawnPosition;    
}

-(void)setSpawnWithaParentCharacterPart:(MZCharacterPart *)aParentCharacterPart spawnPosition:(CGPoint)aSpawnPosition
{
    [self setSpawnWithParentCharacter: (MZCharacter *)aParentCharacterPart.parentRef spawnPosition: aSpawnPosition];
    spawnParentCharacterPartRef = aParentCharacterPart;
}

-(void)enable
{
    [super enable];    
    [self _switchCurrentMode];
}

-(bool)isCollisionWithOtherCharacter:(MZCharacter *)otherCharacter
{   
    return [self isCollisionWithOtherGameObject: otherCharacter];
}

-(void)addMotionSetting:(MZMotionSetting *)motionSetting modeName:(NSString *)modeName
{   
    [self _checkAndAddDefaultSingleModeSettingToModeSettingsArray];
    
    MZModeSetting *firstModeSetting = [modeSettingsQueue objectAtIndex: 0];
    firstModeSetting.name = modeName;
    [firstModeSetting addMotionSetting: motionSetting];
}

-(MZMotionSetting *)getMotionSettingWithIndex:(int)index
{
    MZAssert( modeSettingsQueue != nil, @"\"mode\"SettingsArray(not motionSettingsArray) is nil" );
    MZAssert( [modeSettingsQueue count] > 0, @"modeSettingsArray length = 0" );

    MZModeSetting *firstModeSetting = [modeSettingsQueue objectAtIndex: 0];
    NSMutableArray *motionSettings = firstModeSetting.motionSettings;
    
    MZAssert( motionSettings, @"firstModeSetting does not have any motionSettings" );
    MZAssert( ( index >= 0 && index < [motionSettings count] ), @"index illegal(motionSettingsQueue count=%d)", [motionSettings count] );
        
    return [motionSettings objectAtIndex: index];
}

@end

#pragma mark

@implementation MZCharacter (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    
    currentHealthPoint = 1;
    isLeader = false;
    isUsingDynamicSetting = false;
    disableAttack = false;
}

-(void)_checkActiveCondition
{
    [super _checkActiveCondition];
    
    if( setting.healthPoint != 0 && currentHealthPoint <= 0 )
        [self disable];
}

-(void)_update
{
    [super _update];
    [self _updateMode];
}

@end

#pragma mark

@implementation MZCharacter (Private)

#pragma mark - methods

-(void)_setValuesBySetting
{
    currentHealthPoint = setting.healthPoint;
}

-(void)_setDynamicSetting
{
    [MZObjectHelper releaseAndSetNilToObject: &characterDynamicSetting];    
    characterDynamicSetting = [[MZCharacterDynamicSetting alloc] init];
}

-(void)_setCharacterPartsByDictionary:(NSDictionary *)settingDictionary
{
    if( settingDictionary == nil ) return;
    if( [settingDictionary isKindOfClass: [NSDictionary class]] == false ) return;
    
    for( NSString *partName in [settingDictionary allKeys] )

    {
        MZCharacterPartSetting *partSetting = [settingDictionary objectForKey: partName];
        
        MZCharacterPart *characterPart = [MZCharacterPart characterPartWithLevelComponenets: levelComponentsRef
                                                                                    setting: partSetting
                                                                        parentCharacterType: self.characterType];
        [self addChild: characterPart name: partSetting.name];
    }
}

-(void)_setModesWithSettingsArray:(NSArray *)settingsArray
{
    if( settingsArray == nil ) return;
    if( [settingsArray count] == 0 ) return;
    
    if( modeSettingsQueue == nil )
        modeSettingsQueue = [[NSMutableArray alloc] initWithCapacity: 1];
    
    for( MZModeSetting *modesSetting in settingsArray )
        [modeSettingsQueue push: modesSetting];
}	

-(void)_switchCurrentMode
{
    [MZSTGGameHelper destoryGameBase: &currentMode];
    
    if( modeSettingsQueue == nil || [modeSettingsQueue count] == 0 )
        return;
    
    MZModeSetting *nextModeSetting = [modeSettingsQueue pop];
    if( !nextModeSetting.isRunOnce ) [modeSettingsQueue push: nextModeSetting];
    currentMode = [[MZMode alloc] initWithModeSetting: nextModeSetting levelComponenets: levelComponentsRef controlTarget: self];
    currentMode.disableAttack = disableAttack;
    [currentMode enable];
}

-(void)_checkAndAddDefaultSingleModeSettingToModeSettingsArray
{
    if( modeSettingsQueue == nil )
        modeSettingsQueue = [[NSMutableArray alloc] initWithCapacity: 1];
    
    if( [modeSettingsQueue  count] == 0 )
    {
        MZModeSetting *modeSetting = [MZModeSetting modeSettingWithNSDictionary: nil];
        [modeSettingsQueue push: modeSetting];
    }
}

-(void)_updateMode
{
    if( currentMode == nil ) return;
    
    [currentMode update];

    if( !currentMode.isActive )
        [self _switchCurrentMode];
}

@end