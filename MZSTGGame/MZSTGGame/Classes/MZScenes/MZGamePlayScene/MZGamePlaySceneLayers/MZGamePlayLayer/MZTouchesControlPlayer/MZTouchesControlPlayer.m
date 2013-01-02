#import "MZTouchesControlPlayer.h"
#import "MZPlayer.h"
#import "MZGamePlayLayer.h"
#import "MZLogMacro.h"

@implementation MZTouchesControlPlayer

@synthesize touchesCount;

#pragma mark - init and dealloc

-(id)initWithPlayerTouch:(id<MZPlayerTouchDelegate>)aPlayerTouch touchSpace:(id<MZTouchSpaceDelegate>)aTouchSpace
{
    MZAssert( aPlayerTouch != nil, @"aPlayerTouchDelegate is nil" );
    MZAssert( aTouchSpace != nil, @"aTouchSpaceDelegate is nil" );
    
    self = [super init];
    
    playerTouchDelegate = aPlayerTouch;
    touchSpaceDelegate = aTouchSpace;
    
    touchesCount = 0;
    
    return self;
}

-(void)dealloc
{
    playerTouchDelegate = nil;
    touchSpaceDelegate = nil;
    [super dealloc];
}

#pragma mark - methods

-(void)touchesBegan:(NSSet *)touches event:(UIEvent *)event
{
    touchesCount = [[event allTouches] count];

    if( touchesCount > 1 )
        return;
    
    UITouch *touch = [touches anyObject];
    
    CGPoint convertedLocation = [touchSpaceDelegate convertTouchToNodeSpace: touch];
    [playerTouchDelegate touchBeganWithPosition: convertedLocation];    
}

-(void)touchesMoved:(NSSet *)touches event:(UIEvent *)event
{    
    if( touchesCount > 1 )
        return;
    
    UITouch *touch = [touches anyObject];
    
    CGPoint convertedLocation = [touchSpaceDelegate convertTouchToNodeSpace: touch];
    [playerTouchDelegate touchMovedWithPosition: convertedLocation];
}

-(void)touchesEnded:(NSSet *)touches event:(UIEvent *)event
{    
    touchesCount = [[event allTouches] count];
    
    if( touchesCount > 2 ) return;
    
    [self _doValidTouchesEnded: touches event: event];
}

@end

#pragma mark

@implementation MZTouchesControlPlayer (Private)

-(void)_doValidTouchesEnded:(NSSet *)touches event:(UIEvent *)event
{
    ( touchesCount == 1 )?
    [self _doPlayerTouchesAllEnded: touches event: event] :
    [self _doPlayerTouchesNotAllEnded: touches event: event];
}

-(void)_doPlayerTouchesAllEnded:(NSSet *)touches event:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint convertedLocation = [touchSpaceDelegate convertTouchToNodeSpace: touch];
    [playerTouchDelegate touchEndedWithPosition: convertedLocation];
    
    touchesCount = 0;
}

-(void)_doPlayerTouchesNotAllEnded:(NSSet *)touches event:(UIEvent *)event
{
    UITouch *activeTouch = [self _getActiveTouchWhenTouchesEnded: touches event: event];
    
    if( activeTouch == nil )
        return;
        
    CGPoint convertedLocation = [touchSpaceDelegate convertTouchToNodeSpace: activeTouch];
    [playerTouchDelegate touchBeganWithPosition: convertedLocation];
    
    touchesCount = 1;
}

-(UITouch *)_getActiveTouchWhenTouchesEnded:(NSSet *)touches event:(UIEvent *)event
{
    for( UITouch *eventTouch in [event allTouches] )
        for( UITouch *leaveTouch in touches )
            if( eventTouch != leaveTouch )
                return eventTouch;
    
    return nil;
}

@end
