#import "MZRemoveControl.h"
#import "MZCharacter.h"
#import "MZLogMacro.h"

@implementation MZRemoveControl

#pragma mark - init and dealloc

+(MZRemoveControl *)removeControlWithControlCharacter:(MZCharacter *)aControlCharacter
{
    return [[[self alloc] initWithControlCharacter: aControlCharacter] autorelease];
}

-(id)initWithControlCharacter:(MZCharacter *)aControlCharacter
{
    if( ( self = [super init] ) )
    {
        controlCharacterRef = aControlCharacter;
    }
    
    return self;
}

-(void)dealloc
{
    controlCharacterRef = nil;
    [super dealloc];
}

#pragma mark - methods

-(bool)checkAndSetToRemove
{
    MZAssert( false, @"override me" );
    return false;
}

@end