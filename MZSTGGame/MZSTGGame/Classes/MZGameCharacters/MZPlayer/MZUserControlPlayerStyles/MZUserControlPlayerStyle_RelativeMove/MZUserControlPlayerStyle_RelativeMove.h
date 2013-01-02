#import "MZUserControlPlayerStyleBase.h"

@interface MZUserControlPlayerStyle_RelativeMove : MZUserControlPlayerStyleBase
{
    bool updateMove;
    CGPoint touchPositionAtBegin;
    CGPoint touchPositionAtMove;
    CGPoint characterPositionAtBeginTouch;
}

@end

@interface MZUserControlPlayerStyle_RelativeMove (Private)
-(CGPoint)_checkAndGetNextPositionWithBoundary:(CGPoint)nextPosition;
@end
