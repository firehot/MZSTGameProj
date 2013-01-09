#import "MZAttack_Base.h"
#import "MZLevelComponents.h"
#import "MZGameCharactersHeader.h"
#import "MZCharactersActionManager.h"
#import "MZAttackSetting.h"
#import "MZUtilitiesHeader.h"
#import "MZMotionSetting.h"
#import "MZAttackTargetHelpKit.h"
#import "MZSTGGameHelper.h"
#import "MZTime.h"

@interface MZAttack_Base(Private)
-(bool)_checkColddown;
@end

@implementation MZAttack_Base

@synthesize attackDelegate;
@synthesize numberOfWays;
@synthesize additionalWaysPerLaunch;
@synthesize strength;
@synthesize colddown;
@synthesize intervalDegrees;
@synthesize initVelocity;
@synthesize additionalVelocityPerLaunch;
@synthesize additionalVelocityLimited;
@synthesize maxVelocity;
@synthesize bulletName;

@synthesize currentVelocity;
@synthesize currentAdditionalVelocityPerLaunch;

#pragma mark - init and dealloc

+(MZAttack_Base *)createWithClassType:(MZAttackClassType)classType
{
    MZAttack_Base *attack = [NSClassFromString( [MZAttack_Base classStringFromType: classType] ) attack];
    MZAssert( attack != nil, @"Can not create attack(%@)", [MZAttack_Base classStringFromType: classType] );
    return attack;
}

+(MZAttack_Base *)attack
{  return [[[self alloc] init] autorelease]; }

-(void)dealloc
{
    [attackTargetHelpKit release];
    [super dealloc];
}

#pragma marl - properties

-(float)currentVelocity
{
    return initVelocity + currentAdditionalVelocity;
}

#pragma mark - methods (override)

-(void)reset
{
    [super reset];
    launchCount = 0;
    currentAdditionalVelocity = 0;
}

#pragma mark - methods

+(NSString *)classStringFromType:(MZAttackClassType)moveClassType
{
    NSString *typeString = nil;

    switch( moveClassType )
    {
        case kMZAttack_OddWay:
            typeString = @"OddWay";
            break;
        default:
            MZAssert( false, @"Unkwno type" );
            break;
    }

    return [NSString stringWithFormat: @"MZAttack_%@",  typeString];
}

@end

#pragma mark

@implementation MZAttack_Base(Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    
//    launchCount = 0;
//    colddownCount = 0;
//    currentAdditionalVelocity = 0;
    [self reset];

	numberOfWays = 0;
    additionalWaysPerLaunch = 0;
    strength = 1;
    colddown = 99;
    intervalDegrees = 0;
    initVelocity = 0;
    additionalVelocityPerLaunch = 0;
    maxVelocity = -1;
    bulletName = nil;
    
//	public MZFaceTo.Type bulletFaceToType = MZFaceTo.Type.MovingVector;

    // need re-design
//    attackTargetHelpKit = [[MZAttackTargetHelpKit alloc] initWithAttackSetting: setting controlTarget: controlDelegate];
}

-(void)_checkActiveCondition
{
    [super _checkActiveCondition];
    
//    if( !setting.isRepeatForever && self.lifeTimeCount >= setting.duration )
//        [self disable];
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

-(void)_updateAdditionalVelocity
{
    if( self.additionalVelocityPerLaunch == 0 ) return;
    
    currentAdditionalVelocity += self.additionalVelocityPerLaunch;
    
    if( self.additionalVelocityLimited != -1 )
    {
        if( ( self.additionalVelocityLimited < 0 && currentAdditionalVelocity < self.additionalVelocityLimited ) ||
           ( self.additionalVelocityLimited > 0 && currentAdditionalVelocity > self.additionalVelocityLimited ) )
            currentAdditionalVelocity = self.additionalVelocityLimited;
    }
}

-(void)_addToActionManager:(MZBullet *)bullet
{
    [[MZLevelComponents sharedInstance].gamePlayLayer.charactersActionManager addWithType: [self _getBulletType] character: bullet];
}

-(void)_setBulletLeader:(MZEnemy *)bulletLeader
{
//    currentBulletLeaderRef = bulletLeader;
}

//-(MZEventControlCharacter *)_getCurrentBulletLeader
//{
//    MZAssert( currentBulletLeaderRef, @"currentBulletLeaderRef is nil" );
//    return currentBulletLeaderRef;
//    return nil;
//}

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

-(MZBullet *)_getBullet
{
    MZBullet *bullet = (MZBullet *)[[MZLevelComponents sharedInstance].gamePlayLayer.charactersFactory getByType: [self _getBulletType]
                                                                                                            name: bulletName];
    MZAssert( bullet != nil, @"bullet is nil(name=%@)", bulletName );
    
    bullet.position = [attackDelegate standardPosition];
    bullet.strength = self.strength;
    // faceto type set

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
        colddownCount += self.colddown;
        return true;
    }
    
    return false;
}

@end