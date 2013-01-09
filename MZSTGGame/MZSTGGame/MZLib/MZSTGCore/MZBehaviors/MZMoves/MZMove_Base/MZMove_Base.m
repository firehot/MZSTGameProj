#import "MZMove_Base.h"
#import "MZSTGCharactersHeader.h"
#import "MZUtilitiesHeader.h"
#import "MZRemoveControlsHeader.h"
#import "MZObjectHelper.h"
#import "MZTime.h"
#import "MZUtilitiesHeader.h"

#define TIME_TO_CHECK_REMOVE 1.0

@interface MZMove_Base (Private)
-(void)_updateVelocity;
-(void)_updateMovingVector;
@end

@implementation MZMove_Base

@synthesize velocity;
@synthesize acceleration;
@synthesize maxAcceleration;
@synthesize movingVector;
@synthesize moveDelegate;

@synthesize currentVelocity;
@synthesize currentMovingVector;
@synthesize lastMovingVector;

#pragma mark - init and dealloc

+(MZMove_Base *)createWithClassType:(MZMoveClassType)classType
{
    MZMove_Base *move = [NSClassFromString( [MZMove_Base classStringFromType: classType] ) move];
    MZAssert( move != nil, @"Can not create move(%@)", [MZMove_Base classStringFromType: classType] );
    return move;
}

+(MZMove_Base *)move
{
    return [[[self alloc] init] autorelease];
}

-(void)dealloc
{
    moveDelegate = nil;

    [super dealloc];
}

#pragma mark - properties

-(CGPoint)lastMovingVector
{
    return currentMovingVector;
}

#pragma mark - methods

+(NSString *)classStringFromType:(MZMoveClassType)moveClassType
{
    NSString *typeString = nil;

    switch( moveClassType )
    {
        case kMZMoveClass_Linear:
            typeString =  @"Linear";
            break;

        default:
            MZAssert( false, @"Unkwno type" );
            break;
    }

    return [NSString stringWithFormat: @"MZMove_%@",  typeString];
}

@end

@implementation MZMove_Base (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    
    currentVelocity = velocity;
    currentMovingVector = movingVector;
}

-(void)_checkActiveCondition
{
    [super _checkActiveCondition];
}

-(void)_firstUpdate
{
    [super _firstUpdate];
}

-(void)_update
{
    [self _updateVelocity];
    [self _updateMovingVector];
    [self _updateMove];
}

#pragma mark - methods

-(void)_updateMove
{

}

@end

@implementation MZMove_Base (Private)

#pragma mark - methods

-(void)_updateVelocity
{
    // 是浮點數!!!! ... 能這樣判斷嗎?
    currentVelocity = velocity + ( ( acceleration != 0 )? acceleration*self.lifeTimeCount : 0 );

    if( maxAcceleration != -1 )
    {
        if( acceleration > 0 && currentVelocity > maxAcceleration )
            currentVelocity = maxAcceleration;
        
        if( acceleration < 0 && currentVelocity < maxAcceleration )
            currentVelocity = maxAcceleration;
    }    
}

-(void)_updateMovingVector
{
    currentMovingVector = movingVector;
}

@end
