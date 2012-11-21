#import <Foundation/Foundation.h>
#import "MZCharacterTypeStrings.h"

@class MZLevelComponents;
@class MZCharacter;
@class MZPlayerControlCharacter;
@class MZEventControlCharacter;
@class MZPlayerActionControl;
@class MZPlayerBulletsActionControl;
@class MZEnemiesActionControl;
@class MZEnemyBulletsActionControl;

@interface MZCharactersActionManager : NSObject 
{
    NSMutableArray *activeEnemies;
    NSMutableArray *activeEnemyBullets;
    NSMutableArray *activePlayerBullets;
    MZLevelComponents *levelComponentsRef;
    MZPlayerActionControl *playerActionControl;
    MZPlayerBulletsActionControl *playerBulletsActionControl;
    MZEnemiesActionControl *enemiesActionControl;
    MZEnemyBulletsActionControl *enemyBulletsActionControl;
}

-(id)initWithLevelComponents:(MZLevelComponents *)aLevelComponents;
-(void)addCharacterWithType:(MZCharacterType)characterType character:(MZCharacter *)character;
-(void)draw;
-(void)update;
-(void)clearAllWithType:(MZCharacterType)type;

@end