#import "MZControl_Base.h"
#import "MZTypeDefine.h"
#import "MZFaceToControlProtocol.h"

@protocol MZCharacterPartControlDelegate <MZControlDelegate>
@property (nonatomic, readwrite) bool visible;
@property (nonatomic, readwrite) float rotation;
@property (nonatomic, readwrite) CGPoint standardPosition;
@property (nonatomic, readwrite) CGPoint currentMovingVector;
@end

@class MZCharacterPartControlSetting;
@class MZCharacterPart;
@class MZAttack_Base;
@class MZMove_Base;
@class MZFaceToControl;

@interface MZCharacterPartControl : MZControl_Base <MZFaceToControlProtocol>
{
    id<MZCharacterPartControlDelegate> characterPartDelegate;
    
    MZCharacterPartControlSetting *setting;
    
    NSMutableArray *attackSettingsQueue;
    MZAttack_Base*currentAttack;
    
    NSMutableArray *motionsSettingsQueue;
    MZMove_Base *currentMotion;
    
    MZFaceToControl *faceToControl;
}

+(MZCharacterPartControl *)characterPartControlWithDelegate:(id<MZCharacterPartControlDelegate>)aDelegate
                                                    setting:(MZCharacterPartControlSetting *)aSetting;
-(id)initWithDelegate:(id<MZCharacterPartControlDelegate>)aDelegate
              setting:(MZCharacterPartControlSetting *)aSetting;

@property (nonatomic, readwrite) bool disableAttack;
@end