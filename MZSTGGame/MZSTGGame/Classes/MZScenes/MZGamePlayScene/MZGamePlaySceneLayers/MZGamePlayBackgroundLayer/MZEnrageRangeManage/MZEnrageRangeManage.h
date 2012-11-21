#import <Foundation/Foundation.h>

@class MZGamePlayBackgroundLayer;
@class MZEventMetadata;
@class CCDrawNode;

@interface MZEnrageRangeManage : NSObject
{
    MZGamePlayBackgroundLayer *backgroundLayerRef;
    CCDrawNode *rangeDraw;
    NSMutableDictionary *enrageRectsByNameDictionary;
}

-(id)initWithBackgroundLayer:(MZGamePlayBackgroundLayer *)aBackgroundLayer settingDictionary:(NSDictionary *)aSettingDictionary;

-(bool)isInEnrageRangeWithEventMetadata:(MZEventMetadata *)eventMetadata;
@end
