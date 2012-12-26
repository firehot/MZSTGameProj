#import "CCLayer.h"

@class MZGamePlayScene;
@class MZCCSpritesPool;

@interface MZGamePlaySceneLayerBase : CCLayer
{
@private
    NSMutableDictionary *spritesPoolByActorTypeDictionary;
@protected
    MZGamePlayScene *parentSceneRef;
}

+(MZGamePlaySceneLayerBase *)layerWithLevelSettingDictionary:(NSDictionary *)aLevelSettingDictioanry parentScene:(MZGamePlayScene *)aParentScene;
-(id)initWithLevelSettingDictionary:(NSDictionary *)aLevelSettingDictioanry parentScene:(MZGamePlayScene *)aParentScene;

-(int)addSpritesPool:(MZCCSpritesPool *)spritesPool key:(int)key;
-(MZCCSpritesPool *)getSpritesPoolByKey:(int)key;

-(void)pause;
-(void)resume;

-(void)update;

-(void)beforeRelease;

@property (nonatomic, readonly) NSNumber *layerTypeInNSNumber;

@end

@interface MZGamePlaySceneLayerBase (Protected)
-(void)_initValues;
-(void)_initWithLevelSettingDictionary:(NSDictionary *)levelSettingDictionary;
-(void)_initAfterGetLevelComponents;
@end