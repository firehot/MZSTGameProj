#import "MZControl_Base.h"
#import "MZTypeDefine.h"

@class MZCharacterPart;
@class MZModeSetting;
@class MZMotionSetting;
@class MZCharacter;
@class MZDictionaryArray;
@class MZMove_Base;

@protocol MZModeDelegate <MZControlDelegate>
-(MZCharacterPart *)getChildWithName:(NSString *)childName;
@end

@interface MZMode : MZControl_Base
{
    id<MZModeDelegate> modeDelegate;

    MZDictionaryArray *movesDictionaryArray;
//    MZDictionaryArray *characterPartControlsDictionaryArray;

    MZMove_Base *currentMove;
    NSMutableArray *currentCharacterPartControls;

    // setting ... remove
    MZModeSetting *setting;
    NSMutableArray *characterPartControlSettingsArray;
}

+(MZMode *)mode;

-(MZMove_Base *)addMoveWithName:(NSString *)name;
// add part control

// 死亡確認
+(MZMode *)modeWithDelegate:(id<MZModeDelegate>)aDelegate setting:(MZModeSetting *)aSetting;
-(id)initWithDelegate:(id<MZModeDelegate>)aDelegate setting:(MZModeSetting *)aSetting;



@property (nonatomic, readwrite) bool disableAttack;
//@property (nonatomic, readwrite) bool disableMove;
@property (nonatomic, readonly) NSMutableArray *motionSettingsQueue;
@property (nonatomic, readonly) MZMove_Base *currentMotion;
@end