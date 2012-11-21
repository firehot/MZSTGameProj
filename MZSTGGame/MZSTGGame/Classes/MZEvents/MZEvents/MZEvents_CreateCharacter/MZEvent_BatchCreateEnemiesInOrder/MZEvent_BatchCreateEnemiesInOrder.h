#import "MZEvent.h"

@interface MZEvent_BatchCreateEnemiesInOrder : MZEvent
{
    int numberOfEnemies;
    int currentSpawnCount;
    mzTime nextSpawnTime;
    mzTime intervalSpawnTime;
    CGPoint changePositionEverySpawn;
    NSString *enemyName;
    NSMutableArray *tempDictionariesArrayForSpawnEnemies;
    NSDictionary *createEnemyDictionary;
}

@end