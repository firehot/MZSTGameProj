#import "MZControl_Base.h"
#import "MZTypeDefine.h"
#import "Math.h"

@class MZCharacter;
@class MZMotionSetting;
@class MZRemoveControl;

@interface MZMotion_Base : MZControl_Base
{
@private
    MZCharacter *fakeCenterCharacter;
    MZRemoveControl *removeControl;
@protected
    float currentVelocity;
    CGPoint currentMovingVector;
    MZMotionSetting *setting;
}

+(MZMotion_Base *)motionWithControlTarget:(MZGameObject *)aControlTarget motionSetting:(MZMotionSetting *)aMotionSetting;
-(id)initWithControlTarget:(MZGameObject *)aControlTarget motionSetting:(MZMotionSetting *)aMotionSetting;

@property (nonatomic, readonly) bool isUsingPreviousMovingVector;
@property (nonatomic, readonly) CGPoint currentMovingVector;
@property (nonatomic, readonly) CGPoint lastMovingVector;
@property (nonatomic, readonly) MZMotionSetting *setting;
@property (nonatomic, readwrite, assign) MZCharacter *targetCharacterRef;
@end

@interface MZMotion_Base (Protected)

-(void)_setControlTargetWithMovement:(CGPoint)movement;
-(void)_updateMotion;
-(CGPoint)_getLeaderMovingVector;

// support rotation motion
-(CGPoint)_center;

@end