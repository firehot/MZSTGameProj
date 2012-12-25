#import "MZCharactersFactory.h"
#import "MZSTGCharactersHeader.h"
#import "MZLevelComponentsHeader.h"
#import "MZGameSettingsHeader.h"
#import "MZSTGSettingsHeader.h"
#import "MZCharacterTypeStrings.h"
#import "MZUtilitiesHeader.h"
#import "MZCharacterCollisionColor.h"
#import "MZColor.h"
#import "MZObjectHelper.h"

@interface MZCharactersFactory (Private)
-(int)_getZOrderByType:(MZCharacterType)type;
-(NSMutableDictionary *)_getCharactersSettingDictionaryByCharacterType:(MZCharacterType)charType;
@end

#pragma mark

@implementation MZCharactersFactory

static MZCharactersFactory *sharedCharactersFactory_ = nil;

#pragma mark - init and dealloc

+(MZCharactersFactory *)sharedCharactersFactory
{
    if( sharedCharactersFactory_ == nil )
        sharedCharactersFactory_ = [[MZCharactersFactory alloc] init];
    
    return sharedCharactersFactory_;
}

-(id)init
{    
    MZAssert( sharedCharactersFactory_ == nil, @"signleton class, can not be init twice" );
    self = [super init];
    return self;
}

-(void)dealloc
{    
    [sharedCharactersFactory_ release];
    sharedCharactersFactory_ = nil;
    
    [super dealloc];
}

#pragma mark - methods

-(void)removeFromLevel
{
    [MZObjectHelper releaseAndSetNilToObject: &playerControlCharactersSettingDictionary];
    [MZObjectHelper releaseAndSetNilToObject: &enemiesSettingDictionary];
    [MZObjectHelper releaseAndSetNilToObject: &bulletsSettingDictionary];
}

-(void)addSettingWithCharacterType:(MZCharacterType)characterType settingDictionary:(NSDictionary *)settingDictionary
{
    MZAssert( settingDictionary != nil, 
             @"setting is nil (Type=%@)",
             [[MZCharacterTypeStrings sharedCharacterTypeStrings] getCharacterTypeDescByType: characterType] );
    
    NSString *characterSettingClassName = [[MZCharacterTypeStrings sharedCharacterTypeStrings] getCharacterSettingClassNameByType: characterType];
        
    MZCharacterSetting *targetSetting = [NSClassFromString( characterSettingClassName ) settingWithDictionary: settingDictionary];
    MZAssert( targetSetting != nil, @"Can not create target setting" );
    
    NSMutableDictionary *targetDictionary = [self _getCharactersSettingDictionaryByCharacterType: characterType];
    
    [targetDictionary setObject: targetSetting forKey: targetSetting.name];    
}

-(void)addSettingWithCharacterType:(MZCharacterType)characterType fromPlistFile:(NSString *)plistFileName
{
    NSDictionary *settingDictionary = [MZFileHelper plistContentFromBundleWithName: plistFileName];
    MZAssert( settingDictionary != nil, @"setting is nil (Type=%@)", 
             [[MZCharacterTypeStrings sharedCharacterTypeStrings] getCharacterTypeDescByType: characterType] );
    
    [self addSettingWithCharacterType: characterType settingDictionary: settingDictionary];
}

-(MZCharacter *)getCharacterByType:(MZCharacterType)characterType settingName:(NSString *)settingName
{    
    NSMutableDictionary *targetSettingDictionary = [self _getCharactersSettingDictionaryByCharacterType: characterType];
    MZColor *collisionColor = [[MZCharacterCollisionColor sharedCharacterCollisionColor] getCollisionColorByType: characterType];
    
    MZAssert( targetSettingDictionary != nil && collisionColor != nil, 
             @"targetSettingDictionary or collisionColor is nil(Type=%@)",
             [[MZCharacterTypeStrings sharedCharacterTypeStrings] getCharacterTypeDescByType: characterType] );
    
    MZCharacterSetting *targetSetting = [targetSettingDictionary objectForKey: settingName];
    
    MZAssert( targetSetting != nil, @"Setting(%@) is nil", settingName );
    
    NSString *className = [[MZCharacterTypeStrings sharedCharacterTypeStrings] getCharacterClassNameByType: characterType];
    
    MZCharacter *targetCharacter = [NSClassFromString( className ) character];
    
    targetCharacter.collisionColor = collisionColor;
    
    [targetCharacter setSetting: targetSetting characterType: characterType];
    
    if( [MZGameSetting sharedInstance].debug.showCharacterSpawnInfo )
        MZLog( @"create character(%@)", targetSetting.name );
    
    targetCharacter.visible = true;
    
    return targetCharacter;
}

@end

@implementation MZCharactersFactory (Private)

#pragma  mark - methods

-(int)_getZOrderByType:(MZCharacterType)type
{
    MZGameSetting_GamePlay *play = [MZGameSetting sharedInstance].gamePlay;
    
    switch( type ) 
    {
        case kMZCharacterType_Player:
            return play.zIndexOfPlayer;
            
        case kMZCharacterType_Enemy:
            return play.zIndexOfEnemies;
            
        case kMZCharacterType_PlayerBullet:
            return play.zIndexOfPlayerBullets;
            
        case kMZCharacterType_EnemyBullet:
            return play.zIndexOfEnemyBullets;
            
        default:
            break;
    }
    
    MZAssert( false, @"unknow type to set z-order" );
    return -999;
}

-(NSMutableDictionary *)_getCharactersSettingDictionaryByCharacterType:(MZCharacterType)charType
{
    switch( charType )
    {
        case kMZCharacterType_Player:
            if( playerControlCharactersSettingDictionary == nil )
                playerControlCharactersSettingDictionary = [[NSMutableDictionary alloc] initWithCapacity: 1];
            return playerControlCharactersSettingDictionary;
            
        case kMZCharacterType_Enemy:
            if( enemiesSettingDictionary == nil )
                enemiesSettingDictionary = [[NSMutableDictionary alloc] initWithCapacity: 1];
            return enemiesSettingDictionary;
            
        case kMZCharacterType_PlayerBullet:
        case kMZCharacterType_EnemyBullet:
            if( bulletsSettingDictionary == nil )
                bulletsSettingDictionary = [[NSMutableDictionary alloc] initWithCapacity: 1];
            return bulletsSettingDictionary;
            
        default:
            break;
    }
    
    MZAssert( false, @"Can not fount Dictionary for Char Type(%@)",
             [[MZCharacterTypeStrings sharedCharacterTypeStrings] getCharacterTypeDescByType: charType] );
    
    return nil;
}

@end