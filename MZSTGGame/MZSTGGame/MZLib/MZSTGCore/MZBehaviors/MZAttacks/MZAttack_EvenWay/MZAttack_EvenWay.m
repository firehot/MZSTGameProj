#import "MZAttack_EvenWay.h"
#import "MZMath.h"
#import "MZBullet.h"

@interface MZAttack_EvenWay (Private)
//-(void)_setSideWayWithBullet:(MZEventControlCharacter *)bullet 
//                       index:(int)index
//          centerMovingVector:(CGPoint)centerMovingVector 
//               currentDegree:(float *)currentDegree;
//-(void)_setLeftSideWayWithBullet:(MZEventControlCharacter *)bullet 
//                           index:(int)index 
//              centerMovingVector:(CGPoint)centerMovingVector 
//                   currentDegree:(float *)currentDegree;
//-(void)_setRightSideWayWithBullet:(MZEventControlCharacter *)bullet 
//                            index:(int)index 
//               centerMovingVector:(CGPoint)centerMovingVector 
//                    currentDegree:(float *)currentDegree;
@end

#pragma mark

@implementation MZAttack_EvenWay
@end

#pragma mark

@implementation MZAttack_EvenWay (Protected)

#pragma mark - override

-(void)_launchBullets
{
    [super _launchBullets];
    
    CGPoint centerMovingVector = self.target.currentMovingVector;
    float currentDegrees = self.intervalDegrees/2;

    for( int i = 0; i < self.numberOfWays + ( self.launchCount - 1 )*self.additionalWaysPerLaunch; i++ )
    {
        MZBullet *bullet = [self _getBullet];
        [self _addFirstMoveToBullet: bullet];

        [bullet moveByName: @"first"].movingVector = [MZMath unitVectorFromVector1: centerMovingVector mapToDegrees: currentDegrees];

        currentDegrees = ( i % 2 == 0 )? -currentDegrees : -currentDegrees + self.intervalDegrees;





//        [self _setSideWayWithBullet: bullet
//                              index: i
//                 centerMovingVector: centerMovingVector
//                      currentDegree: &currentDegree];

        [self _addToActionManager: bullet];
    }
    
    [self _updateAdditionalVelocity];
}

@end

@implementation MZAttack_EvenWay (Private)

#pragma mark - methods

//-(void)_setSideWayWithBullet:(MZEventControlCharacter *)bullet 
//                       index:(int)index
//          centerMovingVector:(CGPoint)centerMovingVector 
//               currentDegree:(float *)currentDegree
//{
//    ( index % 2 == 0 )?
//    [self _setLeftSideWayWithBullet: bullet index: index centerMovingVector: centerMovingVector currentDegree: &(*currentDegree)] :
//    [self _setRightSideWayWithBullet: bullet index: index centerMovingVector: centerMovingVector currentDegree: &(*currentDegree)];
//}
//
//-(void)_setLeftSideWayWithBullet:(MZEventControlCharacter *)bullet 
//                           index:(int)index 
//              centerMovingVector:(CGPoint)centerMovingVector 
//                   currentDegree:(float *)currentDegree
//{
////    MZMotionSetting *firstMotionSetting = [bullet getMotionSettingWithIndex: 0];
////    CGPoint movingVector = [MZMath unitVectorFromVector1: centerMovingVector mapToDegrees: *currentDegree];
////    firstMotionSetting.movingVector = movingVector;
////    *currentDegree = -*currentDegree;
//}
//
//-(void)_setRightSideWayWithBullet:(MZEventControlCharacter *)bullet 
//                            index:(int)index 
//               centerMovingVector:(CGPoint)centerMovingVector 
//                    currentDegree:(float *)currentDegree
//{
////    MZMotionSetting *firstMotionSetting = [bullet getMotionSettingWithIndex: 0];
////    CGPoint movingVector = [MZMath unitVectorFromVector1: centerMovingVector mapToDegrees: *currentDegree];
////    firstMotionSetting.movingVector = movingVector;
//
////    *currentDegree = -*currentDegree + setting.intervalDegree;
//}

@end
