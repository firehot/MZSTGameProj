#import "MZBehavior_Base.h"

@class MZGamePlayBackgroundLayer;
@class MZEnrageRangeManage;
@class MZEventMetadata;

@interface MZBgEventsControl : MZBehavior_Base
{
@private
    MZGamePlayBackgroundLayer *parentBackgroundLayerRef;
    MZEnrageRangeManage *enrageRangeManage;
}

-(id)initWithParentBgLayer:(MZGamePlayBackgroundLayer *)aParentBgLayer;

@end
