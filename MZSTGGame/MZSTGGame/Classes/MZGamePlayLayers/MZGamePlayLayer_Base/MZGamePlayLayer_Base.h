#import "CCLayer.h"

@class MZGamePlayScene;
@class MZCCSpritesPool;

@interface MZGamePlayLayer_Base : CCLayer
{
@private
    NSMutableDictionary *spritesPoolByActorTypeDictionary;
@protected
    MZGamePlayScene *parentSceneRef;
}

+(MZGamePlayLayer_Base *)layerWithLevelSettingDictionary:(NSDictionary *)aLevelSettingDictioanry parentScene:(MZGamePlayScene *)aParentScene;
-(id)initWithLevelSettingDictionary:(NSDictionary *)aLevelSettingDictioanry parentScene:(MZGamePlayScene *)aParentScene;

-(int)addSpritesPool:(MZCCSpritesPool *)spritesPool key:(int)key;
-(MZCCSpritesPool *)spritesPoolByKey:(int)key;

-(void)pause;
-(void)resume;

-(void)update;

-(void)beforeRelease;

@property (nonatomic, readonly) NSNumber *layerTypeInNSNumber;

@end

@interface MZGamePlayLayer_Base (Protected)
-(void)_initValues;
-(void)_initWithLevelSettingDictionary:(NSDictionary *)levelSettingDictionary;
-(void)_initAfterGetLevelComponents;
@end