#import "CCScene.h"
#import "MZGamePlayLayersHeader.h"
#import "MZScenesHeader.h"
#import "MZTypeDefine.h"

@class MZGamePlayLayer_Base;

@interface MZGamePlayScene : CCScene
{
    bool isPause;
    float defaultEyeZ;
    NSMutableDictionary *layersDictionary;
}

-(MZGamePlayLayer_Base *)layerByType:(MZGamePlayLayerType)layerType;

-(void)pause;
-(void)resume;

-(void)releaseAll;
-(void)switchSceneTo:(MZSceneType)sceneType;

@property (nonatomic, readonly) bool isPause;
@property (nonatomic, readwrite) float timeScale;
@property (nonatomic, readwrite) float zoom;

@end