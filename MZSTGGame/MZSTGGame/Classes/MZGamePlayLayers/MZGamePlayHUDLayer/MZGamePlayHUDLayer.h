#import "MZGamePlayLayer_Base.h"
#import "MZGamePlayHUDsHeader.h"

@class MZGamePlayHUD_Base;

@interface MZGamePlayHUDLayer : MZGamePlayLayer_Base
{
    NSMutableDictionary *gamePlayHUDComponenetsDictionary;
}

-(MZGamePlayHUD_Base *)hudComponenetsWithType:(MZGamePlayHUDType)type;

@end
