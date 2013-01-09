#import "MZMotion_Rotation.h"
#import "MZMath.h"
#import "MZCharacter.h"
#import "MZCharacterPart.h"
#import "MZObjectHelper.h"
#import "MZTime.h"
#import "MZLogMacro.h"

@interface MZMotion_Rotation (Private)
@end

#pragma mark

@implementation MZMotion_Rotation

#pragma mark - override

#pragma mark - properties

-(CGPoint)lastMovingVector
{
//    currentMovingVector = [MZMath unitVectorFromDegrees: currentTheta - 90];
//    currentMovingVector = [MZMath unitVectorFromVector: currentMovingVector]; // 多餘的啦 ...
//    
//    return currentMovingVector;
}

@end

#pragma mark

@implementation MZMotion_Rotation (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    
//    currentRadians = setting.radians;
//    currentTheta = setting.theta;
}

-(void)_firstUpdate
{
    [super _firstUpdate];
    
//    spawnPosition = moveDelegate.spawnPosition;
//    lastCenter = spawnPosition;
//    
//    CGPoint vector = [MZMath unitVectorFromPoint1: [self _center] toPoint2: moveDelegate.position];
//    float degree = [MZMath degreesFromXAxisToVector: vector];
//    
//    currentTheta = degree;
//    currentRadians = [MZMath distanceFromP1: [self _center] toPoint2: moveDelegate.position];
}

-(void)_updateMotion
{
//    [super _updateMotion];
//    
//    currentTheta += setting.angularVelocity*[MZTime sharedInstance].deltaTime;
//    currentRadians += setting.additionalRadians*[MZTime sharedInstance].deltaTime; /* 參考名稱 variationOfRadians */
//    
//    float x = [self _center].x + currentRadians*cos( [MZMath degreesToRadians: currentTheta] );
//    float y = [self _center].y + currentRadians*sin( [MZMath degreesToRadians: currentTheta] );
//    
//    moveDelegate.position = CGPointMake( x, y );
}

@end

@implementation MZMotion_Rotation (Private)

#pragma mark - init

#pragma mark - methods

@end