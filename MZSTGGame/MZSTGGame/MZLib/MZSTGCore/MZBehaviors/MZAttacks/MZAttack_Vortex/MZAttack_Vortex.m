#import "MZAttack_Vortex.h"
#import "MZMath.h"
#import "MZAttackSetting.h"
#import "MZCharactersFactory.h"
#import "MZSTGCharactersHeader.h"
#import "MZCharactersActionManager.h"
#import "MZCharacterPart.h"
#import "MZAttackTargetHelpKit.h"
#import "MZTime.h"
#import "MZUtilitiesHeader.h"

@interface MZAttack_Vortex (Private)
-(bool)_isResting;
-(void)_launchWaveBullet;
@end

#pragma mark

@implementation MZAttack_Vortex
@end

#pragma mark

@implementation MZAttack_Vortex (Protected)

#pragma mark - override

-(void)_firstUpdate
{
    [super _firstUpdate];
    
    initDegrees = [attackTargetHelpKit getDegreeToTarget];
    resetTimeCount = 0;
    launchTimeCount = 0;
}

-(void)_launchBullets
{
    [super _launchBullets];
    
    if( [self _isResting] ) return;
    [self _launchWaveBullet];
}

@end

#pragma mark

@implementation MZAttack_Vortex (Private)

#pragma mark

-(bool)_isResting
{
    resetTimeCount -= [MZTime sharedInstance].deltaTime;    
    return ( resetTimeCount >= 0 );
}

-(void)_launchWaveBullet
{
//    MZEventControlCharacter *bullet = [self _getBullet];
//    
//    float currentDegrees = initDegrees + setting.intervalDegree*( launchCount - 1 );
//    CGPoint newMovingVector = [MZMath unitVectorFromDegrees: currentDegrees];
//    
//    MZMotionSetting *firstMotionSetting = [bullet getMotionSettingWithIndex: 0];
//    firstMotionSetting.movingVector = newMovingVector;
//    
//    [self _enableBulletAndAddToActionManager: bullet];
//    [self _updateAdditionalVelocity];
//    
//    launchTimeCount += [MZTime sharedInstance].deltaTime;
//    
//    if( launchTimeCount >= setting.timePerWave )
//    {
//        resetTimeCount = setting.restTime;
//        launchTimeCount = 0;
//        
//        if( setting.resetAtRest )
//        {
//            currentAdditionalVelocity = 0;
//        }
//    }
}

@end