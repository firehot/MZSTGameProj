#import "MZUserControlPlayerStyleBase.h"
#import "MZPlayer.h"
#import "MZLogMacro.h"

@implementation MZUserControlPlayerStyleBase

#pragma mark - init and dealloc

-(id)initWithPlayerCharacter:(MZPlayer *)aPlayerControlCharacter
{
    MZAssert( aPlayerControlCharacter, @"aPlayerControlCharacter is nil" );
    self = [super init];
    
    if( self != nil )
    {            
        playerControlCharacterRef = aPlayerControlCharacter;
        [self _initValues];
    }
    
    return self;
}

-(void)dealloc
{
    playerControlCharacterRef = nil;
    [super dealloc];
}

#pragma mark - methods

-(void)touchBeganWithPosition:(CGPoint)touchPosition
{

}

-(void)touchMovedWithPosition:(CGPoint)touchPosition
{

}

-(void)touchEndedWithPosition:(CGPoint)touchPosition
{

}

-(void)updateMove
{
    MZAssert( false, @"override me" );
}

@end

#pragma mark

@implementation MZUserControlPlayerStyleBase (Private)

-(void)_initValues
{

}

@end