#import "MZPlayerBulletsActionControl.h"
#import "MZGameCharactersHeader.h"
#import "MZCharacterDynamicSetting.h"

@implementation MZPlayerBulletsActionControl

-(void)drawCollision
{            
    for( MZCharacter *playerBullet in activePlayerBulletsRef )
        [playerBullet drawCollision];
}


-(void)update
{
    if( activePlayerBulletsRef != nil )
    {
        for( MZPlayerBullet *playerBullet in activePlayerBulletsRef )
        {
            [playerBullet update];
            
            for( MZEnemy *enemy in activeEnemiesRef )
            {
                if( [playerBullet isCollisionWithOtherCharacter: enemy] )
                {
                    enemy.currentHealthPoint -= playerBullet.characterDynamicSetting.strength;
                    [playerBullet disable];
                }
            }
        }
    }
}

-(void)removeInactiveCharacters
{
    [self _removeInactiveCharactersFromActiveCharactersArray: activePlayerBulletsRef];
}

@end
