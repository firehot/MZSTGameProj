#import "MZUserControlPlayerStyle_RelativeMove.h"
#import "MZPlayerControlCharacter.h"
#import "MZGameSettingsHeader.h"
#import "MZCCDisplayHelper.h"
#import "MZCGPointMacro.h"

@implementation MZUserControlPlayerStyle_RelativeMove

#pragma mark - override

-(void)touchBeganWithPosition:(CGPoint)touchPosition
{
    CGPoint standardTouchPosition = [[MZCCDisplayHelper sharedInstance] standardPositionFromReal: touchPosition];

    touchPositionAtBegin = standardTouchPosition;
    touchPositionAtMove = standardTouchPosition;
    characterPositionAtBeginTouch = playerControlCharacterRef.position;
    updateMove = true;
}

-(void)touchMovedWithPosition:(CGPoint)touchPosition
{
    CGPoint standardTouchPosition = [[MZCCDisplayHelper sharedInstance] standardPositionFromReal: touchPosition];
    touchPositionAtMove = standardTouchPosition;
}

-(void)touchEndedWithPosition:(CGPoint)touchPosition
{
    updateMove = false;
}

-(void)updateMove
{
    if( !updateMove )
        return;
    
    CGPoint moveDistance = mzpSub( touchPositionAtMove, touchPositionAtBegin );
    CGPoint nextPosition = mzpAdd( characterPositionAtBeginTouch, moveDistance );
    nextPosition = [self _checkAndGetNextPositionWithBoundary: nextPosition];

    playerControlCharacterRef.position = nextPosition;
}

@end

#pragma mark

@implementation MZUserControlPlayerStyle_RelativeMove (Private)

#pragma mark - override

-(void)_initValues
{
    updateMove = false;
}

-(CGPoint)_checkAndGetNextPositionWithBoundary:(CGPoint)nextPosition
{
    CGRect boundary = [MZGameSetting sharedInstance].gamePlay.playerBoundary;
    bool isChange = false;
    
    if( nextPosition.x < boundary.origin.x ) 
    {
        nextPosition = CGPointMake( boundary.origin.x, nextPosition.y );
        isChange = true;
    }
    
    if( nextPosition.x > boundary .origin.x + boundary.size.width )
    {
        nextPosition = CGPointMake( boundary.origin.x + boundary.size.width, nextPosition.y );
        isChange = true;
    }
    
    if( nextPosition.y < boundary.origin.y )
    {
        nextPosition = CGPointMake( nextPosition.x, boundary.origin.y );
        isChange = true;
    }
    
    if( nextPosition.y > boundary.origin.y + boundary.size.height )
    {
        nextPosition = CGPointMake( nextPosition.x, boundary.origin.y + boundary.size.height );
        isChange = true;
    }
       
    if( isChange == true )
    {
        characterPositionAtBeginTouch = nextPosition;
        touchPositionAtBegin = touchPositionAtMove;
    }
    
    return nextPosition;
}

@end