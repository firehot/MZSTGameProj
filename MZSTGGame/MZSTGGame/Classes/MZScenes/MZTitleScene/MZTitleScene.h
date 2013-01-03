#import "CCScene.h"
#import "CCLayer.h"

@class CCLabelBMFont;
@class MZFramesManager;

@interface MZTitleScene : CCScene
@end

@interface MZTitleLayer : CCLayer
{
    CCLabelBMFont *modeSwitchLabelRef;
    MZFramesManager *framesManager;
}
@end

