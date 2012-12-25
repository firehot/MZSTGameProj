#import "CCScene.h"
#import "MZGamePlayLayersHeader.h"
#import "MZScenesHeader.h"
#import "MZTypeDefine.h"

@class MZGamePlaySceneLayerBase;
@class MZLevelComponents;

@interface MZGamePlayScene : CCScene
{
    float defaultEyeZ;
    
    NSMutableDictionary *layersDictionary;
    MZLevelComponents *levelComponents;

    bool isPause;
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