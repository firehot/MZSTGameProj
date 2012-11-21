#import "MZEnemyBulletsActionControl.h"
#import "MZGameCharactersHeader.h"

@implementation MZEnemyBulletsActionControl

#pragma mark - override

-(void)drawCollision
{            
    for( MZCharacter *enemyBullet in activeEnemyBulletsRef )
        [enemyBullet drawCollision];
}

-(void)update
{
    if( activeEnemyBulletsRef != nil )
    {        
        for( MZEventControlCharacter *enemyBullet in activeEnemyBulletsRef )
        {
            [enemyBullet update];
            
            if( [enemyBullet isCollisionWithOtherCharacter: playerRef] )
                [enemyBullet disable];
        }
    }
}

-(void)removeInactiveCharacters
{
    [self _removeInactiveCharactersFromActiveCharactersArray: activeEnemyBulletsRef];
}

@end
