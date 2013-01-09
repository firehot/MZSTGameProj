#import "MZTarget_Base.h"
#import "MZUtilitiesHeader.h"

// tmep
#import "MZLevelComponentsHeader.h"

@implementation MZTarget_Base

@synthesize targetDelegate;
@synthesize calcuteEveryTime;
@synthesize currentMovingVector;

#pragma mark - init and dealloc

+(MZTarget_Base *)createWithClassType:(MZTargetClassType)classType
{
    MZTarget_Base *target = [NSClassFromString( [MZTarget_Base classStringFromType: classType] ) target];
    MZAssert( target != nil, @"Can not create target(%@)", [MZTarget_Base classStringFromType: classType] );
    return target;
}

+(MZTarget_Base *)target
{ return [[[self alloc] init] autorelease]; }

-(id)init
{
    self = [super init];

    targetDelegate = nil;
    calcuteEveryTime = false;
    needCalcute = true;
    movingVectorResult = mzpZero;

    return self;
}

-(void)dealloc
{
    targetDelegate = nil;
    [super dealloc];
}

#pragma mark - properties

-(CGPoint)currentMovingVector
{
    MZAssert( targetDelegate != nil, @"targetDelegate is null" );

    if( needCalcute == true )
        movingVectorResult = [self _calculateMovingVector];

    return movingVectorResult;
}

#pragma mark - methods

+(NSString *)classStringFromType:(MZTargetClassType)classType
{
    NSString *typeString = nil;

    switch( classType )
    {
        case kMZTarget_Target: typeString = @"Target"; break;

        default: MZAssertFasle( @"unknow type" ); return nil;
    }

    return [NSString stringWithFormat: @"MZTarget_%@", typeString];
}

-(void)reset
{
    needCalcute = true;
    movingVectorResult = mzpZero;
}

-(void)beginOneTime
{

}

-(void)endOneTime
{
    needCalcute = calcuteEveryTime;
}

@end

#pragma mark

@implementation MZTarget_Base (Protected)

-(CGPoint)_calculateMovingVector
{
    MZAssertFasle( @"override me" );
}

// temp, must integrate in delete's target
-(CGPoint)_playerPosition
{
    return [MZLevelComponents sharedInstance].player.position;
}

@end

