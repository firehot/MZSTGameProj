#import "MZControl_Base.h"
#import "MZTypeDefine.h"

@class MZCharacterPart;
@class MZModeSetting;
@class MZMotionSetting;
@class MZCharacter;
@class MZMotion_Base;

@protocol MZModeDelegate <MZControlDelegate>
-(MZCharacterPart *)getChildWithName:(NSString *)childName;
@end

@interface MZMode : MZControl_Base
{
    id<MZModeDelegate> modeDelegate;
    MZModeSetting *setting;

    NSMutableArray *characterPartControlSettingsArray;
    NSMutableArray *currentCharacterPartControls;
}

+(MZMode *)modeWithDelegate:(id<MZModeDelegate>)aDelegate setting:(MZModeSetting *)aSetting;
-(id)initWithDelegate:(id<MZModeDelegate>)aDelegate setting:(MZModeSetting *)aSetting;

@property (nonatomic, readwrite) bool disableAttack;
@property (nonatomic, readonly) NSMutableArray *motionSettingsQueue;
@property (nonatomic, readonly) MZMotion_Base *currentMotion;
@end