#import "MZGamePlaySceneLayerBase.h"
#import "MZTypeDefine.h"

@class MZPlayerControlCharacter;
@class MZTouchesControlPlayer;
@class MZLevelComponents;
@class CCDrawNode;

// wew are test
@class MZCCCameraControl;

@interface MZGamePlayLayer : MZGamePlaySceneLayerBase
{
    MZTouchesControlPlayer *touchesControlPlayer;
    CCDrawNode *referenceLines;
    
    // 以下是測試用的
    MZCCCameraControl *cameraControl;
}

-(void)setControlWithPlayer:(MZPlayerControlCharacter *)player;

@end


@interface MZGamePlayLayer (Test)
-(void)__test_init;
@end