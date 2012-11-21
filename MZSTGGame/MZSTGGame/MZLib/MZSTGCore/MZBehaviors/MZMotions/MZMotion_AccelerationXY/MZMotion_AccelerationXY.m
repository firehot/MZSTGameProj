#import "MZMotion_AccelerationXY.h"
#import "MZCharacter.h"
#import "MZMotionSetting.h"
#import "MZUtilitiesHeader.h"

@implementation MZMotion_AccelerationXY

@end

#pragma mark

@implementation MZMotion_AccelerationXY (Protected)

#pragma mark - override

-(void)_firstUpdate
{
    beginPosition = controlTargetRef.position;
}

-(void)_updateMotion
{    
    // deltaX = V0*t + 1/2*acc*(t^2)
    
    float lifeTimePow2Div2 = self.lifeTimeCount*self.lifeTimeCount/2.0;
    CGPoint velocityXY = CGPointMake( setting.initVelocity*setting.movingVector.x, setting.initVelocity*setting.movingVector.y );
    
    float deltaX = velocityXY.x*self.lifeTimeCount + setting.accelerationXY.x*lifeTimePow2Div2;
    float deltaY = velocityXY.y*self.lifeTimeCount + setting.accelerationXY.y*lifeTimePow2Div2;
    
    controlTargetRef.position = mzpAdd( beginPosition, mzp( deltaX, deltaY ) );
}

@end
