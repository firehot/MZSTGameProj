#import "MZMotion_Base.h"
#import "MZSTGCharactersHeader.h"
#import "MZMotionSetting.h"
#import "MZUtilitiesHeader.h"
#import "MZRemoveControlsHeader.h"
#import "MZObjectHelper.h"
#import "MZTime.h"
#import "MZCharacterSetting.h"

#define TIME_TO_CHECK_REMOVE 1.0

@interface MZMotion_Base (Private)
-(void)_initFakeCenterCharacter;
-(MZCharacterSetting *)_getFakeCenterCharacterSetting;

-(void)_updateVelocity;
@end

@implementation MZMotion_Base

@synthesize isUsingPreviousMovingVector;
@synthesize currentMovingVector;
@synthesize lastMovingVector;
@synthesize setting;
@synthesize targetCharacterRef;

#pragma mark - init and dealloc

+(MZMotion_Base *)motionWithControlTarget:(MZGameObject *)aControlTarget motionSetting:(MZMotionSetting *)aMotionSetting
{
    return [[[self alloc] initWithControlTarget: aControlTarget motionSetting: aMotionSetting] autorelease];
}

-(id)initWithControlTarget:(MZGameObject *)aControlTarget motionSetting:(MZMotionSetting *)aMotionSetting
{
    MZAssert( aMotionSetting != nil, @"MotionSetting is nil" );
    setting = [aMotionSetting retain];
    
    self = [super initWithTarget: aControlTarget];
    
    removeControl = [[MZRemoveOutOfScreen alloc] initWithControlCharacter: (MZCharacter *)aControlTarget];
    [self _initFakeCenterCharacter];

    return self;
}

-(void)dealloc
{
    [fakeCenterCharacter releaseSprite]; [fakeCenterCharacter release];
    [removeControl release];
    [setting release];
    [super dealloc];
}

#pragma mark - properties

-(bool)isUsingPreviousMovingVector
{
    return setting.isUsingPreviousMovingVector;
}

-(CGPoint)lastMovingVector
{
    return currentMovingVector;
}

@end

@implementation MZMotion_Base (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    
    currentVelocity = setting.initVelocity;
    currentMovingVector = setting.movingVector;
}

-(void)_checkActiveCondition
{
    [super _checkActiveCondition];
    
    if( self.lifeTimeCount > TIME_TO_CHECK_REMOVE )
    {
        if( !setting.isRepeatForever && self.lifeTimeCount > setting.duration )
            [self disable];
        
        [removeControl checkAndSetToRemove];
    }
}

-(void)_update
{
    [self _updateVelocity];
    [self _updateMotion];
}

#pragma mark - methods 

-(void)_setControlTargetWithMovement:(CGPoint)movement
{
    controlTargetRef.position = CGPointMake( controlTargetRef.position.x + movement.x, controlTargetRef.position.y + movement.y );

    MZAssert( [NSStringFromCGPoint( controlTargetRef.position ) isEqualToString: @"{nan, nan}"] == false,
             @"new position is {nan}" );
}

-(void)_firstUpdate
{
    fakeCenterCharacter.position = controlTargetRef.spawnPosition;
    [fakeCenterCharacter enable];
}

-(void)_updateMotion
{
    [fakeCenterCharacter update];
}

-(CGPoint)_center
{
    switch( setting.rotatedCenterType )
    {
        case kMZRotatedCenterType_None:
            return CGPointZero;
            
        case kMZRotatedCenterType_Spawn:
            return controlTargetRef.spawnPosition;
            
        case kMZRotatedCenterType_Self:
            return controlTargetRef.position;
            
        case kMZRotatedCenterType_Motion:
            return fakeCenterCharacter.position;
            
        default:
            break;
    }
    
    return CGPointZero;
}

-(CGPoint)_getLeaderMovingVector
{
    MZAssert( [controlTargetRef isKindOfClass: [MZCharacter class]], @"control target is not MZCharacter" );
    MZCharacter *controlCharacter = (MZCharacter *)controlTargetRef;
    
    return ( controlCharacter.leaderCharacterRef != nil )? controlCharacter.leaderCharacterRef.currentMovingVector : currentMovingVector;
}

@end

@implementation MZMotion_Base (Private)

#pragma mark - methods

-(void)_initFakeCenterCharacter
{
    fakeCenterCharacter = [MZCharacter character];
    [fakeCenterCharacter retain];
    fakeCenterCharacter.position = setting.assignPosition;
    
    [fakeCenterCharacter setSetting: [self _getFakeCenterCharacterSetting] characterType: kMZCharacterType_None];
}

-(MZCharacterSetting *)_getFakeCenterCharacterSetting
{
    NSMutableDictionary *modeNSDictionary = [NSMutableDictionary dictionaryWithCapacity: 1];
    [modeNSDictionary setValue: [NSString stringWithFormat: @"FakeMode_Created_by_%@", [self class]] forKey: @"Name"];
    [modeNSDictionary setValue: setting.rotatedCenterMotions forKey: @"motions"];
    [modeNSDictionary setValue: [NSNumber numberWithBool: true] forKey: @"isRepeatForever"];
    
    NSArray *modesNSArray = [NSArray arrayWithObjects: modeNSDictionary, nil];
    
    NSDictionary *fakeCenterCharacterSettingNSDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                                            @"FakeCharacter", @"name",
                                                            modesNSArray, @"modes",
                                                            nil];
    
    MZCharacterSetting *characterSetting = [MZCharacterSetting settingWithDictionary: fakeCenterCharacterSettingNSDictionary];
    
    return characterSetting;
}

-(void)_updateVelocity
{
    if( setting.acceleration == 0 ) return;
    
    currentVelocity = setting.initVelocity + setting.acceleration*self.lifeTimeCount;
    
    if( setting.maxAcceleration != -1 )
    {
        if( setting.acceleration > 0 && currentVelocity > setting.maxAcceleration )
            currentVelocity = setting.maxAcceleration;
        
        if( setting.acceleration < 0 && currentVelocity < setting.maxAcceleration )
            currentVelocity = setting.maxAcceleration;
    }    
}

@end
