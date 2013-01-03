#import "MZGamePlayLayer_Base.h"

@class MZBgEventsControl;
@class MZEventMetadata;

@interface MZGamePlayBackgroundLayer : MZGamePlayLayer_Base
{
    float deltaMovemnetEveryUpdate;
    CGPoint center;
    
    MZBgEventsControl *bgEventsControl;
    NSMutableArray *bgFeatureControlsArray;
    
    NSArray *tempEventsDictArray; // 這幹嘛的啊????
    NSArray *tempBgFeatureControlDicArray;
}

@property (nonatomic, readonly) float deltaMovemnetEveryUpdate;
@property (nonatomic, readonly) CGPoint center;

@end
