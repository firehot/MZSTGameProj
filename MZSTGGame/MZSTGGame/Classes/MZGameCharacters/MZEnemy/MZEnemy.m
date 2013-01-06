#import "MZEnemy.h"
#import "MZGameCoreHeader.h"
#import "MZUtilitiesHeader.h"

#import "MZMove_Base.h"

@implementation MZEnemy

@synthesize modeControlUpdate;

#pragma mark - init and dealloc

+(MZEnemy *)enemy
{
    return [[self alloc] init];
}

-(void)dealloc
{
    [modeControlUpdate release];
    [super dealloc];
}

#pragma mark - methods

-(MZMode *)addModeWithName:(NSString *)name
{
    if( modeControlUpdate == nil )
        modeControlUpdate = [[MZControlUpdate alloc] init];

    MZMode *mode = [MZMode mode];
    mode.modeDelegate = self;

    [modeControlUpdate add: mode key: name];

    return mode;
}

@end

#pragma mark

@implementation MZEnemy (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];

    MZMode *mode = [self addModeWithName: @"M"];

    MZMove_Base *testMove = [mode addMoveWithName: @"A" moveType: kMZMoveClass_Linear];
    testMove.velocity = 50;
    testMove.movingVector = mzp( -0.5, -1 );
    testMove.duration = 1;

    MZMove_Base *testMove2 = [mode addMoveWithName: @"B" moveType: kMZMoveClass_Linear];
    testMove2.moveDelegate = self;
    testMove2.velocity = 50;
    testMove2.movingVector = mzp( 0.5, 1 );
    testMove2.duration = 1;

    [mode enable];
}

-(void)_update
{
    [super _update];
    [modeControlUpdate update];
}

@end