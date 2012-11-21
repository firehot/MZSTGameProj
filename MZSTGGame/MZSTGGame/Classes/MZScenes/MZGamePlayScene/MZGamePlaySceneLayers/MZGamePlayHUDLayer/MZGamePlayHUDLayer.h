#import "MZGamePlaySceneLayerBase.h"
#import "MZGamePlayHUDsHeader.h"

@class MZGamePlayHUD_Base;

@interface MZGamePlayHUDLayer : MZGamePlaySceneLayerBase
{
    NSMutableDictionary *gamePlayHUDComponenetsDictionary;
}

-(MZGamePlayHUD_Base *)hudComponenetsWithType:(MZGamePlayHUDType)type;

@end
