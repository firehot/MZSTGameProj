#import "MZAttackTargetHelpKit.h"
#import "MZAttackSetting.h"
#import "MZMotionSetting.h"
#import "MZGameObject.h"
#import "MZObjectHelper.h"
#import "MZLevelComponentsHeader.h"
#import "MZMath.h"
#import "MZLogMacro.h"

@interface MZAttackTargetHelpKit (Private)
-(bool)_isTargetNotReferecnceTarget;
-(float)_getDegreeDependOnSetting;
-(float)_getDegreeToTarget;
-(float)_getDegreeDependOnSetting_TypeIs_None;
-(float)_getDegreeDependOnSetting_TypeIs_AbsolutePosition;
-(float)_getDegreeDependOnSetting_TypeIs_FaceTo;
-(float)_getDegreeDependOnSetting_TypeIs_AssignPositionAddParentPosition;
-(CGPoint)_getMovingVectorDependOnSetting;
-(CGPoint)_getMovingVectorToTarget;
-(CGPoint)_getMovingVectorDependOnSetting_TypeIs_None;
-(CGPoint)_getMovingVectorDependOnSetting_TypeIs_AbsolutePosition;
-(CGPoint)_getMovingVectorDependOnSetting_TypeIs_FaceTo;
-(CGPoint)_getMovingVectorDependOnSetting_TypeIs_AssignPositionAddParentPosition;
-(CGPoint)_getVectorWithAdditionalDegree:(float)additionalDegree movingVector:(CGPoint)movingVector;
@end

@implementation MZAttackTargetHelpKit

#pragma mark - init and dealloc

-(id)initWithAttackSetting:(MZAttackSetting *)aSetting controlTarget:(MZGameObject *)aControlTarget
{
    MZAssert( aSetting, @"aSetting is nil" );
    MZAssert( aControlTarget, @"aControlTarget is nil" );

    if( ( self = [super init] ) )
    {
        settingRef = aSetting;
        controlTargetRef = aControlTarget;
        
        currentAdditionalDegree = 0;
        movingVectorToTarget = CGPointZero;
    }
    
    return self;
}

-(void)dealloc
{
    settingRef = nil;
    controlTargetRef = nil;
    
    [super dealloc];
}

#pragma mark - methods

-(float)getDegreeToTarget
{
    return ( [self _isTargetNotReferecnceTarget] )? [self _getDegreeDependOnSetting] : [self _getDegreeToTarget];
}

//-(float)getDegreeWithTargetCharacter:(MZCharacter *)targetCharacter
//{
//    return ( [self _isTargetNotReferecnceTarget] )?
//    [self getDegreeDependOnSetting] : 
//    [self getDegreeToTargetWithTargetCharacter: targetCharacter];
//}

-(CGPoint)getTargetPosition
{
    MZTargetType targetType = settingRef.targetType;
    
    switch( targetType )
    {
        case kMZTargetType_Player:
            return [MZLevelComponents sharedInstance].player.position;
            
//        case kMZTargetType_ReferenceTarget:
//            return referenceTarget.position;
            
        case kMZTargetType_AbsolutePosition:
            return ( ((MZCharacter *)controlTargetRef).isUsingDynamicSetting )?
            ((MZCharacter *)controlTargetRef).characterDynamicSetting.absolutePosition : settingRef.assignPosition;
            
//        case kMZTargetType_AssignPositionAddParentPosition:
//            return [self _getAssignPositionAddParentPosition];
//            
//        case kMZTargetType_AssignPositionAddSpawnPosition:
//            return [self _getAssignPositionAddSpawnPosition];
            
        case kMZTargetType_None:
            return CGPointZero;
        default:
            break;
    }
    
    MZAssert( false, @"error" );
    return CGPointZero;
}

-(CGPoint)getMovingVectorToTarget
{
    CGPoint resultVector = ( [self _isTargetNotReferecnceTarget] )? [self _getMovingVectorDependOnSetting] : [self _getMovingVectorToTarget];
    resultVector = [self _getVectorWithAdditionalDegree: settingRef.additionalDegreePerWaveForLinear movingVector: resultVector];
    
    return resultVector;
}

@end

@implementation MZAttackTargetHelpKit (Private)

-(bool)_isTargetNotReferecnceTarget
{
    return
    (settingRef.targetType == kMZTargetType_None ||
     settingRef.targetType == kMZTargetType_AbsolutePosition || 
     settingRef.targetType == kMZTargetType_AssignPositionAddParentPosition ||
     settingRef.targetType == kMZTargetType_AssignPositionAddSpawnPosition ||
     settingRef.targetType == kMZTargetType_FaceTo
     )?
    true : false; 
}

-(float)_getDegreeDependOnSetting
{
    MZAssert( settingRef.motionSettingNsDictionariesArray != nil, @"motionSettingNsDictionariesArray is nil" );
    MZAssert( [settingRef.motionSettingNsDictionariesArray count] > 0, @"motionSettingNsDictionariesArray is ZERO" );
    
    switch( settingRef.targetType )
    {
        case kMZTargetType_None:
            return [self _getDegreeDependOnSetting_TypeIs_None];
            
        case kMZTargetType_AbsolutePosition:
            return [self _getDegreeDependOnSetting_TypeIs_AbsolutePosition];
            
        case kMZTargetType_FaceTo:
            return [self _getDegreeDependOnSetting_TypeIs_FaceTo];
            
        case kMZTargetType_AssignPositionAddParentPosition:
            return [self _getDegreeDependOnSetting_TypeIs_AssignPositionAddParentPosition];
            
        case kMZTargetType_AssignPositionAddSpawnPosition:
            return [self _getDegreeDependOnSetting_TypeIs_AssignPositionAddParentPosition]; // 目前資源不足, 實現不能(必須讓 Attack 搭載 Spawn info)
            
        default:
            break;
    }
    
    MZAssert( false, @"setting type llegal" );
    return -1;
}

-(float)_getDegreeToTarget
{
    CGPoint targetPosition = [self getTargetPosition];
    CGPoint vectorFromSelfToReference = [MZMath unitVectorFromPoint1: controlTargetRef.standardPosition toPoint2: targetPosition];
    
    return [MZMath degreesFromXAxisToVector: vectorFromSelfToReference];
}

-(CGPoint)_getMovingVectorDependOnSetting
{
    MZAssert( settingRef.motionSettingNsDictionariesArray != nil, @"motionSettingNsDictionariesArray is nil" );
    MZAssert( [settingRef.motionSettingNsDictionariesArray count] > 0, @"motionSettingNsDictionariesArray is ZERO" );
    
    switch( settingRef.targetType )
    {
        case kMZTargetType_None:
            return [self _getMovingVectorDependOnSetting_TypeIs_None];
            
        case kMZTargetType_AbsolutePosition:
            return [self _getMovingVectorDependOnSetting_TypeIs_AbsolutePosition];
            
        case kMZTargetType_FaceTo:
            return [self _getMovingVectorDependOnSetting_TypeIs_FaceTo];
            
        case kMZTargetType_AssignPositionAddParentPosition:
            return [self _getMovingVectorDependOnSetting_TypeIs_AssignPositionAddParentPosition];
            
        case kMZTargetType_AssignPositionAddSpawnPosition:
            return [self _getMovingVectorDependOnSetting_TypeIs_AssignPositionAddParentPosition]; // 目前資源不足, 實現不能(必須讓 Attack 搭載 Spawn info)
            
        default:
            break;
    }
    
    MZAssert( false, @"setting type llegal" );
    return CGPointZero;
}

-(CGPoint)_getMovingVectorToTarget
{
    CGPoint targetPosition = [self getTargetPosition];
    
    if( CGPointEqualToPoint( movingVectorToTarget, CGPointZero ) )
        movingVectorToTarget = [MZMath unitVectorFromPoint1: controlTargetRef.standardPosition toPoint2: targetPosition];
    
    if( settingRef.isAimTargetEveryWave )
        movingVectorToTarget = [MZMath unitVectorFromPoint1: controlTargetRef.standardPosition toPoint2: targetPosition];
    
    return movingVectorToTarget;
}

-(float)_getDegreeDependOnSetting_TypeIs_None
{    
    MZAssert( false, @"Do't use me now" );
    return -1;
}

-(float)_getDegreeDependOnSetting_TypeIs_AbsolutePosition
{
    CGPoint targetPosition = settingRef.assignPosition;
    CGPoint unitVector = [MZMath unitVectorFromPoint1: controlTargetRef.standardPosition toPoint2: targetPosition];
    return [MZMath degreesFromXAxisToVector: unitVector];
}

-(float)_getDegreeDependOnSetting_TypeIs_FaceTo
{
    return -((MZCharacter *)controlTargetRef).rotation;
}

-(float)_getDegreeDependOnSetting_TypeIs_AssignPositionAddParentPosition
{
    CGPoint targetPosition = CGPointMake( settingRef.assignPosition.x + controlTargetRef.standardPosition.x,
                                         settingRef.assignPosition.y + controlTargetRef.standardPosition.y );
    CGPoint unitVector = [MZMath unitVectorFromPoint1: controlTargetRef.standardPosition toPoint2: targetPosition];
    return [MZMath degreesFromXAxisToVector: unitVector];
}

-(CGPoint)_getMovingVectorDependOnSetting_TypeIs_None
{
    NSDictionary *settingNSDictionary = [settingRef.motionSettingNsDictionariesArray objectAtIndex: 0];
    MZMotionSetting *firstMotionSetting = [MZMotionSetting motionSettingWithNSDictionary: settingNSDictionary];
    MZAssert( [MZMath isPointValid: firstMotionSetting.movingVector], @"firstMotionSetting.movingVector is invalid" );

    return [MZMath unitVectorFromVector: firstMotionSetting.movingVector];
}

-(CGPoint)_getMovingVectorDependOnSetting_TypeIs_AbsolutePosition
{
    return [MZMath unitVectorFromPoint1: controlTargetRef.standardPosition toPoint2: settingRef.assignPosition];
}

-(CGPoint)_getMovingVectorDependOnSetting_TypeIs_FaceTo
{
    float faceToDegrees = 360 - ((MZCharacter *)controlTargetRef).rotation;
    CGPoint faceToVector = [MZMath unitVectorFromDegrees: faceToDegrees];
    return CGPointMake( faceToVector.x, faceToVector.y );
}

-(CGPoint)_getMovingVectorDependOnSetting_TypeIs_AssignPositionAddParentPosition
{
    CGPoint targetPosition = CGPointMake( settingRef.assignPosition.x + controlTargetRef.standardPosition.x, 
                                         settingRef.assignPosition.y + controlTargetRef.standardPosition.y );
    return [MZMath unitVectorFromPoint1: controlTargetRef.standardPosition toPoint2: targetPosition];
}

-(CGPoint)_getVectorWithAdditionalDegree:(float)additionalDegree movingVector:(CGPoint)movingVector
{
    CGPoint resultVector = movingVector;
    
    if( currentAdditionalDegree != 0 )
        resultVector = [MZMath unitVectorFromVector1: resultVector mapToDegrees: currentAdditionalDegree];

    currentAdditionalDegree += settingRef.additionalDegreePerWaveForLinear;
    
    return [MZMath unitVectorFromVector: resultVector];
}

@end