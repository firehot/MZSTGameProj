#import "MZMotion_LinearToTarget.h"
#import "MZMotionSetting.h"
#import "MZCharacter.h"
#import "MZMath.h"
#import "MZCharacterDynamicSetting.h"
#import "MZSTGGameHelper.h"
#import "MZLevelComponentsHeader.h"
#import "MZTime.h"
#import "MZLogMacro.h"

@interface MZMotion_LinearToTarget (Private)
-(CGPoint)_getNewMovingVector;
-(CGPoint)_getTargetPosition;
-(CGPoint)_getAssignPositionAddParentPosition;
-(CGPoint)_getAssignPositionAddSpawnPosition;
@end

#pragma mark

@implementation MZMotion_LinearToTarget
@end

#pragma mark

@implementation MZMotion_LinearToTarget (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    hasInitMovingVector = false;
}

-(void)_firstUpdate
{

}

-(void)_updateMotion
{
    currentMovingVector = [self _getNewMovingVector];
    CGPoint linearMovement = CGPointMake( currentVelocity*[MZTime sharedInstance].deltaTime*currentMovingVector.x,
                                          currentVelocity*[MZTime sharedInstance].deltaTime*currentMovingVector.y );
    
    [self _setControlTargetWithMovement: linearMovement];
}

@end

@implementation MZMotion_LinearToTarget (Private)

#pragma mark - methods

-(CGPoint)_getNewMovingVector
{
    if( !hasInitMovingVector )
    {
        hasInitMovingVector = true;
        initMovingVector = [MZMath unitVectorFromPoint1: controlTargetRef.position toPoint2: [self _getTargetPosition]];
        return initMovingVector;
    }
    
    return ( setting.isAlwaysToTarget )? 
    initMovingVector = [MZMath unitVectorFromPoint1: controlTargetRef.position toPoint2: [self _getTargetPosition]] :
    initMovingVector;
}

// 移動到 helpKit 中 ... 
-(CGPoint)_getTargetPosition
{
    MZTargetType targetType = setting.targetType;

    switch( targetType )
    {
        case kMZTargetType_Player:
            return levelComponentsRef.player.position;
            
        case kMZTargetType_ReferenceTarget:
            return referenceTargetRef.position;
            
        case kMZTargetType_AbsolutePosition:
            return ( ((MZCharacter *)controlTargetRef).isUsingDynamicSetting )?
            ((MZCharacter *)controlTargetRef).characterDynamicSetting.absolutePosition : setting.assignPosition;
            
        case kMZTargetType_AssignPositionAddParentPosition:
            return [self _getAssignPositionAddParentPosition];
            
        case kMZTargetType_AssignPositionAddSpawnPosition:
            return [self _getAssignPositionAddSpawnPosition];
            
        case kMZTargetType_None:
        default:
            break;
    }
    
    MZAssert( false, @"targetType is invaild(%d)", targetType );
    return CGPointZero;
}

-(CGPoint)_getAssignPositionAddParentPosition
{    
    return CGPointMake( controlTargetRef.position.x + setting.assignPosition.x, controlTargetRef.position.y + setting.assignPosition.y );
}

-(CGPoint)_getAssignPositionAddSpawnPosition
{        
    return CGPointMake( controlTargetRef.spawnPosition.x + setting.assignPosition.x, controlTargetRef.spawnPosition.y + setting.assignPosition.y );
}

@end
