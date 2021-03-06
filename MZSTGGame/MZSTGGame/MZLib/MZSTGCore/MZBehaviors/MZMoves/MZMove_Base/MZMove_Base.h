#import "MZControl_Base.h"
#import "MZTypeBaseClassFunctionsHeader.h"
#import "MZTypeDefine.h"
#import "Math.h"

typedef enum
{
    kMZMoveClass_Linear,
    
}MZMoveClassType;

@class MZCharacter;
@class MZRemoveControl;

@protocol MZMoveDelegate <NSObject, MZControlDelegate>
@property (nonatomic, readwrite) CGPoint position;
@property (nonatomic, readonly) CGPoint spawnPosition;
@end

@interface MZMove_Base : MZControl_Base

MZTypeBaseClassFunctionsHeader( MZMove_Base, move, MZMoveClassType )

#pragma mark - settings
@property (nonatomic, readwrite) float velocity;
@property (nonatomic, readwrite) float acceleration;
@property (nonatomic, readwrite) float maxAcceleration;
@property (nonatomic, readwrite) CGPoint movingVector;
@property (nonatomic, readwrite, assign) id<MZMoveDelegate> moveDelegate;

#pragma mark - states
@property (nonatomic, readonly) float currentVelocity;
@property (nonatomic, readonly) CGPoint currentMovingVector;
@property (nonatomic, readonly) CGPoint lastMovingVector;

@end

@interface MZMove_Base (Protected)

-(void)_checkActiveCondition;
-(void)_firstUpdate;
-(void)_updateMove;

@end