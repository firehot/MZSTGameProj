#import "MZBehavior_Base.h"

@class MZGamePlayBackgroundLayer;

@interface MZBgFeatureControl_Base : MZBehavior_Base
{
@protected
    NSDictionary *settingDictionary;
    MZGamePlayBackgroundLayer *parentLayerRef;
}

+(MZBgFeatureControl_Base *)controlWithSettingDictionary:(NSDictionary *)aSettingDictionary parentLayer:(MZGamePlayBackgroundLayer *)aParentLayer;
-(id)initWithWithSettingDictionary:(NSDictionary *)aSettingDictionary parentLayer:(MZGamePlayBackgroundLayer *)aParentLayer;

@end
