#import "MZMotion_Linear.h"
#import "MZMotionSetting.h"
#import "MZCharacter.h"
#import "MZTime.h"
#import "MZLogMacro.h"

@interface MZMotion_Linear (Private)
@end

#pragma mark

@implementation MZMotion_Linear
@end

@implementation MZMotion_Linear (Protected)

#pragma mark - override

-(void)_firstUpdate
{

}

-(void)_updateMotion
{    
    if( setting.isReferenceLeader )
    {
        currentMovingVector = [self _getLeaderMovingVector];
    }
    
    CGPoint movement = CGPointMake( currentVelocity*[MZTime sharedInstance].deltaTime*currentMovingVector.x,
                                    currentVelocity*[MZTime sharedInstance].deltaTime*currentMovingVector.y );
    
    [self _setControlTargetWithMovement: movement];
}

@end

#pragma mark

@implementation MZMotion_Linear (Private)
#pragma mark - methods
@end
