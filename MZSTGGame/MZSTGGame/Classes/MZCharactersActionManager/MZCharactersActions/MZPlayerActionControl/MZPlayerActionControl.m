#import "MZPlayerActionControl.h"
#import "MZGameCharactersHeader.h"

@implementation MZPlayerActionControl

#pragma mark - override

-(void)drawCollision
{
    [self.player drawCollision];
}

-(void)update
{
    [self.player update];
}

@end
