#import "MZAttack_Base.h"
#import "MZLevelComponentsHeader.h"
#import "MZGameCharactersHeader.h"
#import "MZUtilitiesHeader.h"
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
@synthesize target;

@synthesize launchCount;
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
    [target release];
    [super dealloc];
}

#pragma mark - properties

-(float)currentVelocity
{
    return initVelocity + currentAdditionalVelocity;
}

-(void)setTarget:(MZTarget_Base *)aTarget
{
    if( target == aTarget ) return;
    if( target != nil ) [target release];

    target = aTarget;
    target.targetDelegate = self;

    [target retain];
}

-(MZTarget_Base *)target
{
    MZAssert( target != nil, @"target is nil, must set first" );
    return target;
}

#pragma mark - MZTargetDelegate

-(CGPoint)position
{
    return attackDelegate.standardPosition;
}

-(MZCharacterType)characterType
{
    return attackDelegate.characterType;
}

#pragma mark - methods (override)

-(void)reset
{
    [super reset];

    launchCount = 0;
    currentAdditionalVelocity = 0;

    if( target != nil ) [target reset];
}

#pragma mark - methods

+(NSString *)classStringFromType:(MZAttackClassType)moveClassType
{
    NSString *typeString = nil;

    switch( moveClassType )
    {
        case kMZAttack_OddWay: typeString = @"OddWay"; break;
        case kMZAttack_EvenWay: typeString = @"EvenWay"; break;

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
}

-(void)_update
{
    MZAssert( target != nil, @"target is nil" );

    if( [self _checkColddown] )
    {
        [target beginOneTime];

        [self _launchBullets];

        [target endOneTime];
    }
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

-(void)_addFirstMoveToBullet:(MZBullet *)bullet
{
    MZMove_Base *move = [bullet addMoveWithName: @"first" moveType: kMZMoveClass_Linear];
    move.velocity = self.currentVelocity;
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