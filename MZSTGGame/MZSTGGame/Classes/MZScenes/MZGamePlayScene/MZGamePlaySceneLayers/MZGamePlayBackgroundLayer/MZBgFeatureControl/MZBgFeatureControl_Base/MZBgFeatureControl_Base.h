#import "MZBehavior_Base.h"

@class MZGamePlayBackgroundLayer;

@interface MZBgFeatureControl_Base : MZBehavior_Base
{
@protected
    NSDictionary *settingDictionary;
    MZGamePlayBackgroundLayer *parentLayerRef;
}

+(MZBgFeatureControl_Base *)controlWithLevelComponenets:(MZLevelComponents *)aLevelComponents
                                      settingDictionary:(NSDictionary *)aSettingDictionary
                                            parentLayer:(MZGamePlayBackgroundLayer *)aParentLayer;
-(id)initWithLevelComponenets:(MZLevelComponents *)aLevelComponents
            settingDictionary:(NSDictionary *)aSettingDictionary
                  parentLayer:(MZGamePlayBackgroundLayer *)aParentLayer;

@end
