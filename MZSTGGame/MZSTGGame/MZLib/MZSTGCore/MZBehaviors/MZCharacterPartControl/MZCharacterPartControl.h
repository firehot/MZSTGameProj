#import "MZControl_Base.h"
#import "MZTypeDefine.h"
#import "MZFaceToControlProtocol.h"

@class MZCharacterPartControlSetting;
@class MZCharacterPart;
@class MZAttack_Base;
@class MZMotion_Base;
@class MZFaceToControl;

@interface MZCharacterPartControl : MZControl_Base <MZFaceToControlProtocol>
{
    MZCharacterPart *characterPartRef;
    
    MZCharacterPartControlSetting *setting;
    
    NSMutableArray *attackSettingsQueue;
    MZAttack_Base*currentAttack;
    
    NSMutableArray *motionsSettingsQueue;
    MZMotion_Base *currentMotion;
    
    MZFaceToControl *faceToControl;
}

+(MZCharacterPartControl *)characterControlPartWithSetting:(MZCharacterPartControlSetting *)aSetting
                                             characterPart:(MZCharacterPart *)aCharacterPart;
-(id)initWithSetting:(MZCharacterPartControlSetting *)aSetting characterPart:(MZCharacterPart *)aCharacterPart;

@property (nonatomic, readwrite) bool disableAttack;
@end