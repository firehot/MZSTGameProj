#import "CCScene.h"
#import "MZGamePlayLayersHeader.h"
#import "MZScenesHeader.h"
#import "MZTypeDefine.h"

@class MZGamePlaySceneLayerBase;

@interface MZGamePlayScene : CCScene
{
    bool isPause;
    float defaultEyeZ;
    NSMutableDictionary *layersDictionary;
}

-(MZGamePlaySceneLayerBase *)layerByType:(MZGamePlayLayerType)layerType;

-(void)pause;
-(void)resume;

-(void)releaseAll;
-(void)switchSceneTo:(MZSceneType)sceneType;

-(MZGamePlayLayer *)layerWithType:(MZGamePlayLayerType)layerType;

@property (nonatomic, readonly) bool isPause;
@property (nonatomic, readwrite) float timeScale;
@property (nonatomic, readwrite) float zoom;

@end