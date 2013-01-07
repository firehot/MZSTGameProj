#import "MZCharacter.h"
#import "MZMovesHeader.h"
#import "MZMode.h"

// test
@class MZControlUpdate;
//@class MZMode;

@interface MZEnemy : MZCharacter <MZMoveDelegate, MZModeDelegate> // MZModeDelegate 應該要合併 MZMoveDelegate
{
//    MZControlUpdate *moveControlUpdate;
//    MZMode *mode;

    MZControlUpdate *modeControlUpdate;
}

+(MZEnemy *)enemy;

// temp at enemy now
-(MZMode *)addModeWithName:(NSString *)name;

@property (nonatomic, readonly) MZControlUpdate *modeControlUpdate;

@end
