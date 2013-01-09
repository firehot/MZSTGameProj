#import "MZTarget_Target.h"
#import "MZUtilitiesHeader.h"

@interface MZTarget_Target (Private)
-(CGPoint)_targetPosition;
@end

#pragma mark

@implementation MZTarget_Target
@end

#pragma mark

@implementation MZTarget_Target (Protected)

-(CGPoint)_calculateMovingVector
{
    return [MZMath unitVectorFromPoint1: self.targetDelegate.position toPoint2: [self _targetPosition]];
}

@end

#pragma mark

@implementation MZTarget_Target (Private)

-(CGPoint)_targetPosition
{
    switch( self.targetDelegate.characterType )
    {
        case kMZCharacterType_Enemy:
        case kMZCharacterType_EnemyBullet: // <-- LOL
            return [self _playerPosition];

        default:
            MZAssert( false, @"SORRY, not support this type(%@)", [MZTarget_Base classStringFromType: self.targetDelegate.characterType] );
            return CGPointZero;
    }

}

@end
