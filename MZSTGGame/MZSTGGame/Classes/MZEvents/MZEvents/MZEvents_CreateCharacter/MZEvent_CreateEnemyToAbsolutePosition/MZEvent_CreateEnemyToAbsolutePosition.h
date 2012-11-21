#import "MZEvent.h"

@class MZEvent_CreateEnemy;

@interface MZEvent_CreateEnemyToAbsolutePosition : MZEvent
{
    CGPoint absolutePosition;
    MZEvent_CreateEnemy *createEnemy;
}

@end