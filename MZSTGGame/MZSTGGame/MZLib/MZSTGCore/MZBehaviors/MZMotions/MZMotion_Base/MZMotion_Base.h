#import "MZControl_Base.h"
#import "MZTypeDefine.h"
#import "Math.h"

/*
 有朝一日把你改成 move >//////<
*/

@class MZCharacter;
@class MZMotionSetting;
@class MZRemoveControl;

@protocol MZMoveDelegate <MZControlDelegate>
@property (nonatomic, readwrite) CGPoint position;
@property (nonatomic, readonly) CGPoint spawnPosition;
@end

@interface MZMotion_Base : MZControl_Base
{
@private
    MZCharacter *fakeCenterCharacter;
    MZRemoveControl *removeControl;
@protected
    id<MZMoveDelegate> moveDelegate;
    float currentVelocity;
    CGPoint currentMovingVector;
    MZMotionSetting *setting;
}

+(MZMotion_Base *)motionWithControlTarget:(MZGameObject *)aControlTarget motionSetting:(MZMotionSetting *)aMotionSetting;
-(id)initWithControlTarget:(MZGameObject *)aControlTarget motionSetting:(MZMotionSetting *)aMotionSetting;

+(MZMotion_Base *)moveWithDelegate:(id<MZMoveDelegate>)aDelegate setting:(MZMotionSetting *)setting;
+(id)initWithDelegate:(id<MZMoveDelegate>)aDelegate setting:(MZMotionSetting *)setting;


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