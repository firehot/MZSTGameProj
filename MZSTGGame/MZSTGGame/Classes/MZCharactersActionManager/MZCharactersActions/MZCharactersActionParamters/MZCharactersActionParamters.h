#import <Foundation/Foundation.h>

@class MZPlayer;

@interface MZCharactersActionParamters : NSObject

+(MZCharactersActionParamters *)charactersActionParamters;
-(void)checkCompleteness;

@property (nonatomic, assign) NSMutableArray *activePlayers;
@property (nonatomic, assign) NSMutableArray *activePlayerBullets;
@property (nonatomic, assign) NSMutableArray *activeEnemies;
@property (nonatomic, assign) NSMutableArray *activeEnemyBullets;
@property (nonatomic, readonly) MZPlayer *player;

@end
