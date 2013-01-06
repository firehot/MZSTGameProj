#import "MZCharacter.h"
#import "MZMovesHeader.h"

@class MZControlUpdate;

@interface MZEnemy : MZCharacter <MZMoveDelegate>
{
    MZControlUpdate *moveControlUpdate;
}

+(MZEnemy *)enemy;
@end
