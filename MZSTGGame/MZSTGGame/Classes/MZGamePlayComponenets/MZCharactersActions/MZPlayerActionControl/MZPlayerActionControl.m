#import "MZPlayerActionControl.h"
#import "MZGameCharactersHeader.h"

@implementation MZPlayerActionControl

#pragma mark - override

-(void)drawCollision
{
    [playerRef drawCollision];
}

-(void)update
{
    [playerRef update];
}

@end
