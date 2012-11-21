#import "MZGameObject.h"
#import "MZEventOccurFlagHandlerProtocol.h"

@class MZGamePlayBackgroundLayer;
@class MZLevelComponents;
@class MZEventMetadata;
@class CCSprite;
@class CCDrawNode;
@class CCMenu;

@interface MZEventOccurFlag : MZGameObject
{
@private
    id<MZEventOccurFlagHandler> handler;
    MZGamePlayBackgroundLayer *bgLayerRef;

    CGPoint diffBetweenCenter;
    CGPoint bgCenterAtSetPosition;
    CCSprite *flag;
    CCDrawNode *flagBound;
}

+(MZEventOccurFlag *)flagWithLevelComponenets:(MZLevelComponents *)aLevelComponents
                                eventMetadata:(MZEventMetadata *)aEventMetadata
                                      bgLayer:(MZGamePlayBackgroundLayer *)aBgLayer
                                      handler:(id<MZEventOccurFlagHandler>)aHandler;
-(id)initWithLevelComponenets:(MZLevelComponents *)aLevelComponents
                eventMetadata:(MZEventMetadata *)aEventMetadata
                      bgLayer:(MZGamePlayBackgroundLayer *)aBgLayer
                      handler:(id<MZEventOccurFlagHandler>)aHandler;

-(bool)isInTouchRangeWithStandardTouch:(CGPoint)standardTouch;

@property (nonatomic, readwrite) bool focus;

// 相對於目前螢幕的坐標, 即中心永遠是 (160,240)
@property (nonatomic, readwrite) CGPoint screenPosition;
// 絕對對於世界的坐標
@property (nonatomic, readonly) CGPoint editPosition;

@property (nonatomic, readwrite, assign) MZEventMetadata *eventMetadataRef;

@end
