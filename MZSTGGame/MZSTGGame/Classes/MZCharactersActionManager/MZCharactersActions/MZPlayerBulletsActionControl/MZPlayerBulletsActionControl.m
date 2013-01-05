#import "MZPlayerBulletsActionControl.h"
#import "MZGameCharactersHeader.h"
#import "MZCharacterDynamicSetting.h"

@implementation MZPlayerBulletsActionControl

-(void)drawCollision
{            
    for( MZCharacter *playerBullet in self.activePlayerBullets )
        [playerBullet drawCollision];
}


-(void)update
{
    if( self.activePlayerBullets != nil )
    {
        for( MZPlayerBullet *playerBullet in self.activePlayerBullets )
        {
            [playerBullet update];
            
            for( MZEnemy *enemy in self.activeEnemies )
            {
                if( [playerBullet isCollisionWithOtherCharacter: enemy] )
                {
                    enemy.currentHealthPoint -= playerBullet.characterDynamicSetting.strength; // take damage function
                    [playerBullet disable];
                }
            }
        }
    }
}

-(void)removeInactiveCharacters
{
    [self _removeInactiveCharactersFromActiveCharactersArray: self.activePlayerBullets];
}

@end
