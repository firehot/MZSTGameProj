#import "MZLevelHud_Base.h"

@class CCSprite;

@interface MZLevelHud_BackgroundBillboards : MZLevelHud_Base
{
    CCSprite *upBillboard;
    CCSprite *downBillboard;
}

@property (nonatomic, readonly) CCSprite *upBillboard;

@end
