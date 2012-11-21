#import "MZEffectsManager.h"
#import "MZGameCoreHeader.h"
#import "MZUtilitiesHeader.h"

@implementation MZEffectsManager

-(id)init
{
    self = [super init];
    
    NSDictionary *effectSettingDictionary = [MZFileHelper plistContentFromBundleWithName: @"EffectSetting.plist"];
    [[MZAnimationsManager sharedAnimationsManager] addAnimationsFromNSDictionary: effectSettingDictionary[@"animations"]];
    
    return self;
}

-(void)playWithName:(NSString *)name position:(CGPoint)position
{
    
}

-(void)stop
{

}

@end