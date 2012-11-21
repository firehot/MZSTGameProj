#import "MZFaceToControl.h"
#import "MZGameObject.h"
#import "MZLevelComponentsHeader.h"
#import "MZMath.h"
#import "MZLogMacro.h"

@interface MZFaceToControl (Private)

-(bool)_getInitVisibleValue;

-(void)_doFaceToTarget;
-(void)_doFaceToDirection;
-(void)_doFaceToPreviousDirection;

//-(void)_doFaceToCurrentMovingVector;
@end

#pragma mark

@implementation MZFaceToControl

@synthesize hasVaildValue;
@synthesize lastDirection;

#pragma mark - init and dealloc

+(MZFaceToControl *)controlWithControlTarget:(NSObject<MZFaceToControlProtocol> *)aControlTarget
                             levelComponents:(MZLevelComponents *)aLevelComponents
                                      faceTo:(MZFaceToType)aFaceTo
                           previousDirection:(CGPoint)aPreviousDirection
{
    return [[[self alloc] initWithControlTarget: aControlTarget
                                levelComponents: aLevelComponents
                                         faceTo: aFaceTo
                              previousDirection: aPreviousDirection] autorelease];
}

-(id)initWithControlTarget:(NSObject<MZFaceToControlProtocol> *)aControlTarget
           levelComponents:(MZLevelComponents *)aLevelComponents
                    faceTo:(MZFaceToType)aFaceTo
         previousDirection:(CGPoint)aPreviousDirection
{
    MZAssert( aControlTarget, @"aControlGameObject is nil" );
    MZAssert( aLevelComponents, @"aLevelComponents is nil" );
    
    if( ( self = [super init] ) )
    {
        faceToType = aFaceTo;
        controlTargetRef = aControlTarget;
        levelComponentsRef = aLevelComponents;
        previousDirection = aPreviousDirection;
        
        previousPosition = MZ_INVAILD_POINT;
        hasVaildValue = ( faceToType == kMZFaceToType_Direction )? false: true;
    }
    
    return self;
}

-(void)dealloc
{
    levelComponentsRef = nil;
    controlTargetRef = nil;
    
    [super dealloc];
}

#pragma mark - methods

-(void)update
{
    switch( faceToType )
    {
        case kMZFaceToType_None:
            lastDirection = MZ_INVAILD_POINT;
            break;
            
        case kMZFaceToType_Target:
            [self _doFaceToTarget];
            break;
            
        case kMZFaceToType_Direction:
            [self _doFaceToDirection];
            break;
            
        case kMZFaceToType_PreviousDirection:
            [self _doFaceToPreviousDirection];
            
//        case kMZFaceToType_CurrentMovingVector:
//            [self _doFaceToCurrentMovingVector];
//            break;
            
        default:
            break;
    }
}

@end

#pragma mark

@implementation MZFaceToControl (Private)

#pragma mark - init 

-(bool)_getInitVisibleValue
{
    return ( faceToType == kMZFaceToType_Direction )? false: true;
}

#pragma mark - methods

-(void)_doFaceToTarget
{
    CGPoint currentPosition = controlTargetRef.standardPosition;
    CGPoint targetPosition = controlTargetRef.targetPosition;
    
    CGPoint unitVector = [MZMath unitVectorFromPoint1: currentPosition toPoint2: targetPosition];
    float rotation = [MZMath degreesFromXAxisToVector: unitVector];
    controlTargetRef.rotation = -rotation;
    
    lastDirection = unitVector;
}

-(void)_doFaceToDirection
{
    if( CGPointEqualToPoint( MZ_INVAILD_POINT, previousPosition ) )
    {
        previousPosition = controlTargetRef.standardPosition;
        return;
    }
    
    CGPoint currentPosition = controlTargetRef.standardPosition;
    CGPoint unitVector = [MZMath unitVectorFromPoint1: previousPosition toPoint2: currentPosition];
    
    float rotation = [MZMath degreesFromXAxisToVector: unitVector];
    controlTargetRef.rotation = -rotation;
    
    previousPosition = currentPosition;
    
    lastDirection = unitVector;
    
    hasVaildValue = true;
}

-(void)_doFaceToPreviousDirection
{
    float rotation = [MZMath degreesFromXAxisToVector: previousDirection];
    controlTargetRef.rotation = -rotation;
}

//-(void)_doFaceToCurrentMovingVector
//{
//    float rotation = [MZMath getDegreesFromOriginToVector: controlTargetRef.currentMovingVector];
//    controlTargetRef.rotation = -rotation;
//}

@end