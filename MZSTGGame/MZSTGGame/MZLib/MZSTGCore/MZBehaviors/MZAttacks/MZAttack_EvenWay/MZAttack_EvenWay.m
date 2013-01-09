#import "MZAttack_EvenWay.h"
#import "MZAttackSetting.h"
#import "MZCharactersFactory.h"
#import "MZEnemy.h"
#import "MZCharactersActionManager.h"
#import "MZMath.h"
#import "MZCharacterPart.h"

@interface MZAttack_EvenWay (Private)
-(void)_setSideWayWithBullet:(MZEventControlCharacter *)bullet 
                       index:(int)index
          centerMovingVector:(CGPoint)centerMovingVector 
               currentDegree:(float *)currentDegree;
-(void)_setLeftSideWayWithBullet:(MZEventControlCharacter *)bullet 
                           index:(int)index 
              centerMovingVector:(CGPoint)centerMovingVector 
                   currentDegree:(float *)currentDegree;
-(void)_setRightSideWayWithBullet:(MZEventControlCharacter *)bullet 
                            index:(int)index 
               centerMovingVector:(CGPoint)centerMovingVector 
                    currentDegree:(float *)currentDegree;
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
    
//    CGPoint centerMovingVector = [attackTargetHelpKit getMovingVectorToTarget];
//    float currentDegree = setting.intervalDegree/2;
//    
//    for( int i = 0; i < setting.numberOfWays + ( launchCount - 1 )*setting.additionalWaysPerLaunch; i++ )
//    {
//        MZEventControlCharacter *bullet = [self _getBullet];   
//        
//        [self _setSideWayWithBullet: bullet 
//                              index: i
//                 centerMovingVector: centerMovingVector
//                      currentDegree: &currentDegree];
//    
//        [self _enableBulletAndAddToActionManager: bullet];
//    }
//    
//    [self _updateAdditionalVelocity];
}

@end

@implementation MZAttack_EvenWay (Private)

#pragma mark - methods

-(void)_setSideWayWithBullet:(MZEventControlCharacter *)bullet 
                       index:(int)index
          centerMovingVector:(CGPoint)centerMovingVector 
               currentDegree:(float *)currentDegree
{
    ( index % 2 == 0 )?
    [self _setLeftSideWayWithBullet: bullet index: index centerMovingVector: centerMovingVector currentDegree: &(*currentDegree)] :
    [self _setRightSideWayWithBullet: bullet index: index centerMovingVector: centerMovingVector currentDegree: &(*currentDegree)];
}

-(void)_setLeftSideWayWithBullet:(MZEventControlCharacter *)bullet 
                           index:(int)index 
              centerMovingVector:(CGPoint)centerMovingVector 
                   currentDegree:(float *)currentDegree
{
//    MZMotionSetting *firstMotionSetting = [bullet getMotionSettingWithIndex: 0];
//    CGPoint movingVector = [MZMath unitVectorFromVector1: centerMovingVector mapToDegrees: *currentDegree];
//    firstMotionSetting.movingVector = movingVector;
//    *currentDegree = -*currentDegree;
}

-(void)_setRightSideWayWithBullet:(MZEventControlCharacter *)bullet 
                            index:(int)index 
               centerMovingVector:(CGPoint)centerMovingVector 
                    currentDegree:(float *)currentDegree
{
//    MZMotionSetting *firstMotionSetting = [bullet getMotionSettingWithIndex: 0];
//    CGPoint movingVector = [MZMath unitVectorFromVector1: centerMovingVector mapToDegrees: *currentDegree];
//    firstMotionSetting.movingVector = movingVector;

//    *currentDegree = -*currentDegree + setting.intervalDegree;
}

@end
