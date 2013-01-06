#import "MZEnemy.h"
#import "MZUtilitiesHeader.h"

@implementation MZEnemy

#pragma mark - init and dealloc

+(MZEnemy *)enemy
{
    return [[self alloc] init];
}

-(void)dealloc
{
    [testMove release];
    [super dealloc];
}

@end


@implementation MZEnemy (Protected)

-(void)_initValues
{
    [super _initValues];
    testMove = [MZMove_Base createWithClassType: kMZMoveClass_Linear];
    [testMove retain];
    testMove.moveDelegate = self;
    testMove.velocity = 100;
    testMove.movingVector = mzp( 0, -1 );
    [testMove enable]; // <-- need?
}

-(void)_update
{
    [super _update];
    [testMove update];
}

@end