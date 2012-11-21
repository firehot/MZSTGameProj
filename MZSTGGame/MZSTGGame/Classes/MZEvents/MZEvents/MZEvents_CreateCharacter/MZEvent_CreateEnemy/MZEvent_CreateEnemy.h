#import "MZEvent.h"

@class MZEnemy;

@interface MZEvent_CreateEnemy : MZEvent 
{
    NSString *enemyName;
    MZEnemy *enemyRef;
}

@end

@interface MZEvent_CreateEnemy (Private)
@end