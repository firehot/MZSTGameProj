#import "MZAttack_Base.h"
#import "MZLevelComponents.h"
#import "MZGameCharactersHeader.h"
#import "MZCharactersActionManager.h"
#import "MZAttackSetting.h"
#import "MZUtilitiesHeader.h"
#import "MZMotionSetting.h"
#import "MZAttackTargetHelpKit.h"
#import "MZCharacterDynamicSetting.h"
#import "MZSTGGameHelper.h"
#import "MZTime.h"

@interface MZAttack_Base(Private)
-(bool)_checkColddown;
@end

@implementation MZAttack_Base

#pragma mark - init and dealloc

+(MZAttack_Base*)attackWithDelegate:(id<MZAttackDelegate>)aControlDelegate setting:(MZAttackSetting *)aSetting
{
    return [[[self alloc] initWithDelegate: aControlDelegate setting: aSetting] autorelease];
}

-(id)initWithDelegate:(id<MZAttackDelegate>)aControlDelegate setting:(MZAttackSetting *)aSetting
{
    setting = ( aSetting != nil )? [aSetting retain] : nil;

    self = [super initWithDelegate: aControlDelegate];
    attackDelegate = aControlDelegate;
    return self;
}

-(void)dealloc
{
    [setting release];
    [attackTargetHelpKit release];
    [super dealloc];
}

@end

#pragma mark

@implementation MZAttack_Base(Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    
    launchCount = 0;
    colddownCount = 0;
    currentAdditionalVelocity = 0;

    // need re-design
    attackTargetHelpKit = [[MZAttackTargetHelpKit alloc] initWithAttackSetting: setting controlTarget: controlDelegate];
}

-(void)_checkActiveCondition
{
    [super _checkActiveCondition];
    
    if( !setting.isRepeatForever && self.lifeTimeCount >= setting.duration )
        [self disable];
}

-(void)_update
{
    if( [self _checkColddown] )
        [self _launchBullets];
}

#pragma mark - methods

-(void)_launchBullets
{
    launchCount++;
}

-(void)_addMotionSettingToBullet:(MZEventControlCharacter *)bullet
{
    if( setting.motionSettingNsDictionariesArray != nil )
    {
        for( NSDictionary *nsDictionary in setting.motionSettingNsDictionariesArray )
        {
            MZMotionSetting *motionSetting = [MZMotionSetting motionSettingWithNSDictionary: nsDictionary];
            NSString *modeName = [NSString stringWithFormat: @"Mode_Created_By_%@", self];
            [bullet addMotionSetting: motionSetting modeName: modeName];
        }
    }
}

-(void)_updateAdditionalVelocity
{
    if( setting.additionalVelocity == 0 ) return;
    
    currentAdditionalVelocity += setting.additionalVelocity;
    
    if( setting.additionalVelocityLimited != -1 )
    {
        if( ( setting.additionalVelocityLimited < 0 && currentAdditionalVelocity < setting.additionalVelocityLimited ) ||
           ( setting.additionalVelocityLimited > 0 && currentAdditionalVelocity > setting.additionalVelocityLimited ) )
            currentAdditionalVelocity = setting.additionalVelocityLimited;
    }
}

-(void)_enableBulletAndAddToActionManager:(MZEventControlCharacter *)bullet
{
    [bullet enable];
    [[MZLevelComponents sharedInstance].charactersActionManager addCharacterWithType: [self _getBulletType] character: bullet];
}

-(void)_setBulletLeader:(MZEnemy *)bulletLeader
{
    bulletLeader.isLeader = true;
    currentBulletLeaderRef = bulletLeader;
}

-(MZEventControlCharacter *)_getCurrentBulletLeader
{
    MZAssert( currentBulletLeaderRef, @"currentBulletLeaderRef is nil" );
    return currentBulletLeaderRef;
}

-(MZCharacterType)_getBulletType
{
    MZCharacterType characterType = [attackDelegate characterType];

    switch( characterType )
    {
        case kMZCharacterType_Player:
            return kMZCharacterType_PlayerBullet;
            
        case kMZCharacterType_Enemy:
            return kMZCharacterType_EnemyBullet;
            
        default:
            break;
    }
    
    MZAssert( false, @"Unknow controlCharacterType to set bullet type" );
    return kMZCharacterType_None;
}

-(NSMutableDictionary *)_getCommonValuesNSDictionary
{
    // 應該追加 name 設定
    NSDictionary *nsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInt: setting.strength], @"Strength",
                                  [NSNumber numberWithBool: true], @"IsRepeatForever",
                                  [NSNumber numberWithFloat: setting.colddownTime], @"Colddown",
                                  [NSNumber numberWithFloat: setting.additionalVelocity], @"AdditionalVelocity",
                                  [NSNumber numberWithFloat: setting.additionalVelocityLimited], @"AdditionalVelocityLimited",
                                  [MZSTGGameHelper getFaceToStringWithType: setting.faceTo] , @"FaceTo",
                                  setting.bulletSettingName, @"BulletName",
                                  setting.motionSettingNsDictionariesArray, @"Motions",
                                  nil];
    
    return [NSMutableDictionary dictionaryWithDictionary: nsDictionary];
}

-(MZEventControlCharacter *)_getBullet
{
    MZEnemyBullet *bullet = (MZEnemyBullet *)
    [[MZCharactersFactory sharedCharactersFactory] getCharacterByType: [self _getBulletType]
                                                          settingName: setting.bulletSettingName];
    
    MZAssert( bullet != nil, @"bullet is nil(name=%@)", setting.bulletSettingName );
    
    bullet.position = [attackDelegate standardPosition];

    // need fix: set bullet spawn info ...
    [bullet setSpawnWithaParentCharacterPart: (MZCharacterPart *)attackDelegate spawnPosition: [attackDelegate standardPosition]];
    
    [self _addMotionSettingToBullet: bullet];
    MZMotionSetting *firstMotionSetting = [bullet getMotionSettingWithIndex: 0];
    
    MZAssert( firstMotionSetting, @"firstMotionSetting is nil" );
    
    firstMotionSetting.initVelocity += currentAdditionalVelocity;
    if( firstMotionSetting.initVelocity < 0 ) firstMotionSetting.initVelocity = 0;
    
    bullet.characterDynamicSetting.strength = setting.strength;
    bullet.characterDynamicSetting.faceTo = setting.faceTo;
    [bullet applyDynamicSetting];
    
    if( launchCount == 1 )
        [self _setBulletLeader: bullet];
    else
        bullet.leaderCharacterRef = currentBulletLeaderRef;
    
    return bullet;
}

@end

#pragma mark

@implementation MZAttack_Base(Private)

#pragma mark - methods

-(bool)_checkColddown
{
    colddownCount -= [MZTime sharedInstance].deltaTime;
    
    if( colddownCount <= 0 )
    {
        colddownCount += setting.colddownTime;
        return true;
    }
    
    return false;
}

@end