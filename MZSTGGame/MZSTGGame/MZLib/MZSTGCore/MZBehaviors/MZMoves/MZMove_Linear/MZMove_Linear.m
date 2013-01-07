#import "MZMove_Linear.h"
#import "MZMotionSetting.h"
#import "MZCharacter.h"
#import "MZTime.h"
#import "MZUtilitiesHeader.h"


@interface MZMove_Linear (Private)
@end

#pragma mark

@implementation MZMove_Linear
@end

@implementation MZMove_Linear (Protected)

#pragma mark - override

-(void)_firstUpdate
{
    
}

-(void)_updateMove
{
    [super _updateMove];

    float movement = self.currentVelocity*[MZTime sharedInstance].deltaTime;
    CGPoint deltaMove = mzp( movement*self.currentMovingVector.x, movement*self.currentMovingVector.y );

    self.moveDelegate.position = mzpAdd( self.moveDelegate.position, deltaMove );
}

@end

#pragma mark

@implementation MZMove_Linear (Private)
#pragma mark - methods
@end
