#import "MZTouchesControlPlayer.h"
#import "MZPlayerControlCharacter.h"
#import "MZGamePlayLayer.h"

@implementation MZTouchesControlPlayer

@synthesize touchesCount;

#pragma mark - init and dealloc

-(id)initWithPlayerControlCharacter:(MZPlayerControlCharacter *)aPlayerControlCharacter gamePlayLayerRef:(MZGamePlayLayer *)aGamePlayLayer
{
    if( ( self = [super init] ) )
    {
        playerControlCharacterRef = aPlayerControlCharacter;
        gamePlayLayerRef = aGamePlayLayer;
        
        touchesCount = 0;
    }
    
    return self;
}

-(void)dealloc
{
    playerControlCharacterRef = nil;
    gamePlayLayerRef = nil;
    [super dealloc];
}

#pragma mark - methods

-(void)touchesBegan:(NSSet *)touches event:(UIEvent *)event
{
    touchesCount = [[event allTouches] count];

    if( touchesCount > 1 )
        return;
    
    UITouch *touch = [touches anyObject];
    
    CGPoint convertedLocation = [gamePlayLayerRef convertTouchToNodeSpace: touch];
    [playerControlCharacterRef touchBeganWithPosition: convertedLocation];    
}

-(void)touchesMoved:(NSSet *)touches event:(UIEvent *)event
{    
    if( touchesCount > 1 )
        return;
    
    UITouch *touch = [touches anyObject];
    
    CGPoint convertedLocation = [gamePlayLayerRef convertTouchToNodeSpace: touch];
    [playerControlCharacterRef touchMovedWithPosition: convertedLocation];
}

-(void)touchesEnded:(NSSet *)touches event:(UIEvent *)event
{    
    touchesCount = [[event allTouches] count];
    
    if( touchesCount > 2 )
        return;
    
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
    CGPoint convertedLocation = [gamePlayLayerRef convertTouchToNodeSpace: touch];
    [playerControlCharacterRef touchEndedWithPosition: convertedLocation];
    
    touchesCount = 0;
}

-(void)_doPlayerTouchesNotAllEnded:(NSSet *)touches event:(UIEvent *)event
{
    UITouch *activeTouch = [self _getActiveTouchWhenTouchesEnded: touches event: event];
    
    if( activeTouch == nil )
        return;
        
    CGPoint convertedLocation = [gamePlayLayerRef convertTouchToNodeSpace: activeTouch];
    [playerControlCharacterRef touchBeganWithPosition: convertedLocation];
    
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
