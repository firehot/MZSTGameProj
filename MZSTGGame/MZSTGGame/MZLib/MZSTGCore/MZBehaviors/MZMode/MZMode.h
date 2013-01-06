#import "MZControl_Base.h"
#import "MZTypeDefine.h"
#import "MZMove_Base.h"

@class MZCharacterPart;
@class MZControlUpdate;

@protocol MZModeDelegate <MZControlDelegate, MZMoveDelegate>
-(MZCharacterPart *)getChildWithName:(NSString *)childName; // 改個名 ><"
@end

@interface MZMode : MZControl_Base
{
    id<MZModeDelegate> modeDelegate;

    MZControlUpdate *movesUpdate;

    NSMutableArray *currentCharacterPartControls;
}

+(MZMode *)mode;

-(MZMove_Base *)addMoveWithName:(NSString *)name moveType:(MZMoveClassType)classType;
-(MZMove_Base *)moveByName:(NSString *)name;

// add part control

#pragma mark - settings
@property (nonatomic, readwrite, assign) id<MZModeDelegate> modeDelegate;
@property (nonatomic, readwrite) bool disableMove; 
@property (nonatomic, readwrite) bool disableAttack;

#pragma mark - states

@end