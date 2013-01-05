#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

@class MZCharacter;
@class MZPlayerActionControl;
@class MZPlayerBulletsActionControl;
@class MZEnemiesActionControl;
@class MZEnemyBulletsActionControl;

@interface MZCharactersActionManager : NSObject 
{
    NSMutableArray *activePlayers;
    NSMutableArray *activeEnemies;
    NSMutableArray *activeEnemyBullets;
    NSMutableArray *activePlayerBullets;
    MZPlayerActionControl *playerActionControl;
    MZPlayerBulletsActionControl *playerBulletsActionControl;
    MZEnemiesActionControl *enemiesActionControl;
    MZEnemyBulletsActionControl *enemyBulletsActionControl;
}

-(void)addWithType:(MZCharacterType)characterType character:(MZCharacter *)character;
-(void)draw;
-(void)update;
-(void)clearAllWithType:(MZCharacterType)type;

@end