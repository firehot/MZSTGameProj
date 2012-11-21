#import "CCLayer.h"

@class MZGamePlayScene;
@class MZLevelComponents;

@interface MZGamePlaySceneLayerBase : CCLayer
{
    MZGamePlayScene *parentSceneRef;
    MZLevelComponents *levelComponentsRef;
}

+(MZGamePlaySceneLayerBase *)layerWithLevelSettingDictionary:(NSDictionary *)aLevelSettingNSDictioanry parentScene:(MZGamePlayScene *)aParentScene;
-(id)initWithLevelSettingDictionary:(NSDictionary *)aLevelSettingNSDictioanry parentScene:(MZGamePlayScene *)aParentScene;

-(void)pause;
-(void)resume;

-(void)update;

-(void)beforeRelease;

@property (nonatomic, readonly) NSNumber *layerTypeInNSNumber;
@property (nonatomic, assign) MZLevelComponents *levelComponentsRef;

@end

@interface MZGamePlaySceneLayerBase (Protected)
-(void)_initValues;
-(void)_initWithLevelSettingDictionary:(NSDictionary *)levelSettingDictionary;
-(void)_initAfterGetLevelComponents;
@end