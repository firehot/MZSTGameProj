#import "MZAttack_OddWay.h"
#import "MZMath.h"
#import "MZBullet.h"

@interface MZAttack_OddWay (Private)
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
    
    CGPoint centerMovingVector = self.target.currentMovingVector;
    float currentDegrees = 0;
    
    for( int i = 0; i < self.numberOfWays + ( self.launchCount - 1 )*self.additionalWaysPerLaunch; i++ )
    {
        MZBullet *bullet = [self _getBullet];
        [self _addFirstMoveToBullet: bullet];

        if( i == 0 )
        {
            [bullet moveByName: @"first"].movingVector = centerMovingVector;
            currentDegrees += self.intervalDegrees;
        }
        else
        {
            [bullet moveByName: @"first"].movingVector = [MZMath unitVectorFromVector1: centerMovingVector mapToDegrees: currentDegrees];
            currentDegrees = ( i % 2 == 1 )? -currentDegrees : -currentDegrees + self.intervalDegrees;
        }
        
        [self _addToActionManager: bullet];
    }
    
    [self _updateAdditionalVelocity];
}

@end


#pragma mark

@implementation MZAttack_OddWay (Private)

#pragma mark - methods

@end
