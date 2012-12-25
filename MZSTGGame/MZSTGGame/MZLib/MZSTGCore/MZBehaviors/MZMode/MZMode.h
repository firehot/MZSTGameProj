#import "MZControl_Base.h"
#import "MZTypeDefine.h"

@class MZModeSetting;
@class MZMotionSetting;
@class MZCharacter;
@class MZMotion_Base;

@interface MZMode : MZControl_Base
{
    MZModeSetting *setting;
    NSMutableArray *characterPartControlSettingsArray;
    
    NSMutableArray *currentCharacterPartControls;
}

+(MZMode *)modeWithModeSetting:(MZModeSetting *)aSetting controlTarget:(MZGameObject *)aControlTarget;
-(id)initWithModeSetting:(MZModeSetting *)aSetting controlTarget:(MZGameObject *)aControlTarget;

@property (nonatomic, readwrite) bool disableAttack;
@property (nonatomic, readonly) NSMutableArray *motionSettingsQueue;
@property (nonatomic, readonly) MZMotion_Base *currentMotion;
@end