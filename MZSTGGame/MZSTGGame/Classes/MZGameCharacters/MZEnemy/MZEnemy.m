#import "MZEnemy.h"
#import "MZGameCoreHeader.h"
#import "MZUtilitiesHeader.h"

@implementation MZEnemy

#pragma mark - init and dealloc

+(MZEnemy *)enemy
{
    return [[self alloc] init];
}

-(void)dealloc
{
    [moveControlUpdate release];
    [super dealloc];
}

@end

#pragma mark

@implementation MZEnemy (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];

    MZMove_Base *testMove = [MZMove_Base createWithClassType: kMZMoveClass_Linear];
    testMove.moveDelegate = self;
    testMove.velocity = 100;
    testMove.movingVector = mzp( -0.5, -1 );
    testMove.duration = 2;
//    testMove.isRunOnce = true;

    MZMove_Base *testMove2= [MZMove_Base createWithClassType: kMZMoveClass_Linear];
    testMove2.moveDelegate = self;
    testMove2.velocity = 100;
    testMove2.movingVector = mzp( 0.5, 1 );
    testMove2.duration = 2;
//    testMove2.isRunOnce = true;

    moveControlUpdate = [[MZControlUpdate alloc] init];
//    moveControlUpdate.disableUpdate = true;
    [moveControlUpdate add: testMove key: @"1"];
    [moveControlUpdate add: testMove2 key: @"2"];
}

-(void)_update
{
    [super _update];
    [moveControlUpdate update];
}

@end