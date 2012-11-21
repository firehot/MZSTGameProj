#import <Foundation/Foundation.h>
#import "MZSceneTypeDefine.h"

@interface MZScenesFlowController : NSObject 
{
    MZSceneType nextScene;
}

+(MZScenesFlowController *)sharedScenesFlowController;

-(void)fastSwitchToScene:(MZSceneType)sceneType;

@property (nonatomic, readonly) MZSceneType nextScene;

@end


/*
[設計考量]
* 把切換的功能放在裡面
* 先設定各種參數, 再 Apply
*/