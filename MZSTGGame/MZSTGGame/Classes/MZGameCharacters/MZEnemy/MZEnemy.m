#import "MZEnemy.h"
#import "MZGameCoreHeader.h"
#import "MZUtilitiesHeader.h"
#import "MZCharacterPart.h"

#import "MZMove_Base.h"
#import "MZAttacksHeader.h"
#import "MZCharacterPartControl.h"

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

#pragma mark - MZModeDelegate

-(id<MZCharacterPartControlDelegate>)characterPartByName:(NSString *)partName
{
    return (MZCharacterPart *)[self getChildWithName: partName];
}

#pragma mark - properties

-(MZCharacterType)characterType
{
    return kMZCharacterType_Enemy;
}

#pragma mark - methods (override)

-(void)initDefaultMode
{
    [super initDefaultMode];
    
    MZMode *mode = [self addModeWithName: @"M"];

//    MZMove_Base *testMove = [mode addMoveWithName: @"A" moveType: kMZMoveClass_Linear];
//    testMove.velocity = 50;
//    testMove.movingVector = mzp( -0.5, -1 );
//    testMove.duration = 1;
//
//    MZMove_Base *testMove2 = [mode addMoveWithName: @"B" moveType: kMZMoveClass_Linear];
//    testMove2.moveDelegate = self;
//    testMove2.velocity = 50;
//    testMove2.movingVector = mzp( 0.5, 1 );
//    testMove2.duration = 1;

    // part control
    MZControlUpdate *pControlUpdate = [mode addPartControlUpdateWithName: @"puOneX"];
    
    MZCharacterPartControl *pControl1 = [MZCharacterPartControl characterPartControl];
    pControl1.characterPartDelegate = [self.partsDictionary objectForKey: @"p"];

    MZMove_Base *testPMove = [pControl1 addMoveWithName: @"A" moveType: kMZMoveClass_Linear];
    testPMove.velocity = 0;
    testPMove.movingVector = mzp( 0, -1 );
    testPMove.duration = -1;
    
    MZAttack_OddWay *attack = (MZAttack_OddWay *)[pControl1 addAttackWithName: @"A" attackType: kMZAttack_OddWay];
    attack.initVelocity = 10;
    attack.intervalDegrees = 10;
    attack.numberOfWays = 1;
    attack.bulletName = @"";
    attack.colddown = 0.3;
    attack.additionalVelocityPerLaunch = 50;
    attack.additionalVelocityLimited = 300;
    attack.additionalWaysPerLaunch = 2;
    attack.duration = 0.5f;

    [pControlUpdate add: pControl1 key: @"p1"];
}

#pragma mark - methods

-(MZMode *)addModeWithName:(NSString *)name
{
    if( modeControlUpdate == nil )
        modeControlUpdate = [[MZControlUpdate alloc] initWithBaseClass: [MZMode class]];

    // test new methods here
    MZMode *mode = [modeControlUpdate addWithKey: name];
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
}

-(void)_update
{
    [super _update];
    [modeControlUpdate update];
}

@end