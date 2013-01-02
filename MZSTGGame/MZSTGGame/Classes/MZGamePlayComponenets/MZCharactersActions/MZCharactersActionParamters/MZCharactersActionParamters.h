#import <Foundation/Foundation.h>

@class MZPlayer;

@interface MZCharactersActionParamters : NSObject

+(MZCharactersActionParamters *)charactersActionParamters;
-(void)checkCompleteness;

@property (nonatomic, assign) NSMutableArray *activeEnemiesRef;
@property (nonatomic, assign) NSMutableArray *activeEnemyBulletsRef;
@property (nonatomic, assign) NSMutableArray *activePlayerBulletsRef;
@property (nonatomic, assign) MZPlayer *playerRef;

@end
