#import "MZGamePlaySceneLayerBase.h"
#import "MZGamePlayLayer.h"
#import "MZGamePlayHUDLayer.h"
#import "MZGamePlayBackgroundLayer.h"

typedef enum 
{
    kMZGamePlayLayerType_PlayLayer,
    kMZGamePlayLayerType_HUDLayer,    
    kMZGamePlayLayerType_BackgroundLayer,
}MZGamePlayLayerType;