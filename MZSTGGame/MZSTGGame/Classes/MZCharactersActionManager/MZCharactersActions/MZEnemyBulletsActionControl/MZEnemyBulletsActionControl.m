#import "MZEnemyBulletsActionControl.h"
#import "MZGameCharactersHeader.h"

@implementation MZEnemyBulletsActionControl

#pragma mark - override

-(void)drawCollision
{            
    for( MZCharacter *enemyBullet in self.activeEnemyBullets )
        [enemyBullet drawCollision];
}

-(void)update
{
    if( self.activeEnemyBullets != nil )
    {        
        for( MZBullet *enemyBullet in self.activeEnemyBullets )
        {
            [enemyBullet update];
            
            if( [enemyBullet isCollisionWithOtherCharacter: self.player] )
                [enemyBullet disable];
        }
    }
}

-(void)removeInactiveCharacters
{
    [self _removeInactiveCharactersFromActiveCharactersArray: self.activeEnemyBullets];
}

@end
