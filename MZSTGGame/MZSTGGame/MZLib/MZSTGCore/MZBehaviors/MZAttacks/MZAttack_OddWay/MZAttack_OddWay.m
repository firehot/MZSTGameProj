#import "MZAttack_OddWay.h"
#import "MZAttackSetting.h"
#import "MZMath.h"
#import "MZMotionSetting.h"
#import "MZAttackTargetHelpKit.h"
#import "MZLevelComponentsHeader.h"

@interface MZAttack_OddWay (Private)
-(void)_setCenterWayWithBullet:(MZEventControlCharacter *)bullet
            centerMovingVector:(CGPoint)centerMovingVector 
                 currentDegree:(float *)currentDegree;
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

@implementation MZAttack_OddWay
@end

#pragma mark

@implementation MZAttack_OddWay (Protected)

#pragma mark - override

-(void)_launchBullets
{
    [super _launchBullets];
    
    CGPoint centerMovingVector = [attackTargetHelpKit getMovingVectorToTarget];
    float currentDegree = 0;
    
    for( int i = 0; i < setting.numberOfWays + ( launchCount - 1 )*setting.additionalWaysPerLaunch; i++ )
    {
        MZEventControlCharacter *bullet = [self _getBullet];        
        
        if( i == 0 )
        {
            [self _setCenterWayWithBullet: bullet centerMovingVector: centerMovingVector currentDegree: &currentDegree];
        }
        else
        {
            [self _setSideWayWithBullet: bullet index: i centerMovingVector: centerMovingVector currentDegree: &currentDegree];
        }
        
        [self _enableBulletAndAddToActionManager: bullet];
    }
    
    [self _updateAdditionalVelocity];
}

@end


#pragma mark

@implementation MZAttack_OddWay (Private)

#pragma mark - override (private)

-(void)_setCenterWayWithBullet:(MZEventControlCharacter *)bullet
            centerMovingVector:(CGPoint)centerMovingVector
                 currentDegree:(float *)currentDegree
{
    MZMotionSetting *firstMotionSetting = [bullet getMotionSettingWithIndex: 0];
    firstMotionSetting.movingVector = centerMovingVector;
    *currentDegree += setting.intervalDegree;
}

-(void)_setSideWayWithBullet:(MZEventControlCharacter *)bullet 
                       index:(int)index
          centerMovingVector:(CGPoint)centerMovingVector 
               currentDegree:(float *)currentDegree
{
    ( index % 2 == 1 )?
    [self _setLeftSideWayWithBullet: bullet index: index centerMovingVector: centerMovingVector currentDegree: &(*currentDegree)]:
    [self _setRightSideWayWithBullet: bullet index: index centerMovingVector: centerMovingVector currentDegree: &(*currentDegree)];
}

-(void)_setLeftSideWayWithBullet:(MZEventControlCharacter *)bullet 
                           index:(int)index 
              centerMovingVector:(CGPoint)centerMovingVector 
                   currentDegree:(float *)currentDegree
{
    MZMotionSetting *firstMotionSetting = [bullet getMotionSettingWithIndex: 0];
    CGPoint movingVector = [MZMath unitVectorFromVector1: centerMovingVector mapToDegrees: *currentDegree];
    firstMotionSetting.movingVector = movingVector;
    
    *currentDegree = -*currentDegree;
}

-(void)_setRightSideWayWithBullet:(MZEventControlCharacter *)bullet 
                           index:(int)index 
              centerMovingVector:(CGPoint)centerMovingVector 
                   currentDegree:(float *)currentDegree
{
    MZMotionSetting *firstMotionSetting = [bullet getMotionSettingWithIndex: 0];
    CGPoint movingVector = [MZMath unitVectorFromVector1: centerMovingVector mapToDegrees: *currentDegree];
    firstMotionSetting.movingVector = movingVector;
    
    *currentDegree = -*currentDegree + setting.intervalDegree;
}

@end
