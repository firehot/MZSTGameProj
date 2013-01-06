#import "MZCharacter.h"
#import "MZMovesHeader.h"

@class MZMove_Base;

@interface MZEnemy : MZCharacter <MZMoveDelegate>
{
    MZMove_Base *testMove;
}

+(MZEnemy *)enemy;
@end
