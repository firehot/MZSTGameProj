#import "CCLayer.h"

@class MZGamePlayScene;
@class MZCCSpritesPool;
@class MZFramesManager;

@interface MZGamePlayLayer_Base : CCLayer
{
@private
    NSMutableDictionary *spritesPoolByActorTypeDictionary;
    MZFramesManager *framesManager;
@protected
    MZGamePlayScene *parentSceneRef; // 有相依 >/////<
}

+(MZGamePlayLayer_Base *)layerWithLevelSettingDictionary:(NSDictionary *)aLevelSettingDictioanry parentScene:(MZGamePlayScene *)aParentScene;
-(id)initWithLevelSettingDictionary:(NSDictionary *)aLevelSettingDictioanry parentScene:(MZGamePlayScene *)aParentScene;

// sprites pool
-(int)addSpritesPool:(MZCCSpritesPool *)spritesPool key:(int)key;
-(MZCCSpritesPool *)spritesPoolByKey:(int)key;

// control
-(void)pause;
-(void)resume;

-(void)update;

// release
-(void)beforeRelease;

@property (nonatomic, readonly) NSNumber *layerTypeInNSNumber;
@property (nonatomic, readonly) MZFramesManager *framesManager;

@end

@interface MZGamePlayLayer_Base (Protected)
-(void)_initValues;
-(void)_initWithLevelSettingDictionary:(NSDictionary *)levelSettingDictionary;
-(void)_initAfterGetLevelComponents;
@end