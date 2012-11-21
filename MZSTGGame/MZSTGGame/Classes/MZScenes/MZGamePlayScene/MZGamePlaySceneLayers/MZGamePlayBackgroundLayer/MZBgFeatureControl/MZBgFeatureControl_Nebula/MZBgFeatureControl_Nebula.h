#import "MZBgFeatureControl_Base.h"

@class MZCCSpritesPool;

@interface MZBgFeatureControl_Nebula : MZBgFeatureControl_Base
{
    float NEBULA_TIME_PER_LAYER;
    
    NSMutableArray *nebulaSpritesArray;
    int currentLayerIndex;
    float layerSpawnTimeCount;
    
    MZCCSpritesPool *spritesPool;

}

@end
