#import "MZGamePlayHUD_Base.h"
#import "CCTouchDelegateProtocol.h"
#import "MZEventOccurFlagHandlerProtocol.h"

@class CCLabelBMFont;
@class CCMenu;
@class CCDrawNode;
@class MZEventOccurFlag;
@class MZLevelComponents;

@interface MZGamePlayHUD_Editor : MZGamePlayHUD_Base <CCTouchAllAtOnceDelegate, MZEventOccurFlagHandler>
{
@private
    bool isPauseForEdit;
    bool isZoomOut;
    CGPoint bottomLeftForZoomOutOfIPad;

    CCLabelBMFont *touchPositionLabel;

    CCMenu *buttonsMenu;
    CCLabelBMFont *gameTimeLabelRef;

    CCLabelBMFont *centerPositionLabel;
    
    // events list
    int currentEventIndex;
    NSDictionary *eventsDefineDictionary;
    CCMenu *eventsButtonMenu;
    CCLabelBMFont *currentEventLabel;

    // event flags
    NSMutableArray *eventOccurFlagsArray;

    // current event flags control
    MZEventOccurFlag *currentFocusFlagRef;
    CCLabelBMFont *currentFocusFlagPositionLabel;
    CCMenu *occurFlagControlMenu;
}

-(void)setEventOccurFlagsAfterGetLevelComponenet;

@end
