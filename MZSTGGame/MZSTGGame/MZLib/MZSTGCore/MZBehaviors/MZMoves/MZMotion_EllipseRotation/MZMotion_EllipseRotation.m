#import "MZMotion_EllipseRotation.h"
#import "MZMotionSetting.h"
#import "MZMath.h"
#import "MZCharacter.h"
#import "MZCharacterPart.h"
#import "MZCharacterSetting.h"
#import "MZUtilitiesHeader.h"
#import "MZCCUtilitiesHeader.h"
#import "MZGameCoreHeader.h"

@interface MZMotion_EllipseRotation (Private)
@end

#pragma mark

@implementation MZMotion_EllipseRotation
@end

#pragma mark

@implementation MZMotion_EllipseRotation (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    
//    MZAssert( setting.rotatedCenterType == kMZRotatedCenterType_None, @"rotatedCenterType not support" );
}

-(void)_firstUpdate
{
    [super _firstUpdate];
    
//    beginDegreeFromXAxis = [MZMath degreesFromXAxisToVector: moveDelegate.position];

    
    
}

-(void)_updateMotion
{
    [super _updateMotion];
    
//    float currentDegreeFromXAxis = beginDegreeFromXAxis + setting.angularVelocity*self.lifeTimeCount;
//    float currentRadiansFromXAxis = [MZMath degreesToRadians: currentDegreeFromXAxis];
//    
//    float nextX = [self _center].x + setting.ellipseRadiansX*cos( currentRadiansFromXAxis );
//    float nextY = [self _center].y + setting.ellipseRadiansY*sin( currentRadiansFromXAxis );
//    
//    moveDelegate.position = mzp( nextX, nextY );
}

@end

#pragma mark

@implementation MZMotion_EllipseRotation (Private)

@end