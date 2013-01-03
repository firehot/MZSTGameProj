#import "MZTypeDefine.h"

@class MZLevelComponents;
@class MZGamePlayHUDLayer;
@class MZGamePlayScene;

@interface MZGamePlayHUD_Base : NSObject
{
    MZGamePlayHUDLayer *targetLayerRef;
    MZGamePlayScene *parentSceneRef;
}

+(MZGamePlayHUD_Base *)gamePlayHUDWithTargetLayer:(MZGamePlayHUDLayer *)aTargetLayer parentScene:(MZGamePlayScene *)aParentScene;
-(id)initWithTargetLayer:(MZGamePlayHUDLayer *)aTargetLayer parentScene:(MZGamePlayScene *)aParentScene;

-(void)update;

-(void)beforeRelease;

@end

@interface MZGamePlayHUD_Base (Protected)
-(void)_init;
@end
