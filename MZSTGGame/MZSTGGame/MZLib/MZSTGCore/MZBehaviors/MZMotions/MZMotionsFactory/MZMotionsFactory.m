#import "MZMotionsFactory.h"
#import "MZCharacter.h"
#import "MZMotionsHeader.h"
#import "MZLevelComponentsHeader.h"
#import "MZObjectHelper.h"
#import "MZLogMacro.h"

@implementation MZMotionsFactory

#pragma mark - init and dealloc

MZMotionsFactory *sharedMZMotionsFactory_ = nil;

+(MZMotionsFactory *)sharedMZMotionsFactory
{
    if( sharedMZMotionsFactory_ == nil )
        sharedMZMotionsFactory_ = [[MZMotionsFactory alloc] init];
    return sharedMZMotionsFactory_;
}

-(void)dealloc
{
    [sharedMZMotionsFactory_ release];
    sharedMZMotionsFactory_ = nil;
    
    [super dealloc];
}

#pragma mark - methods

-(MZMotion_Base *)getMotionBySetting:(MZMotionSetting *)aSetting controlTarget:(MZGameObject *)aControlTarget
{
    NSString *motionClassName = [NSString stringWithFormat: @"MZMotion_%@", aSetting.motionType];
    MZMotion_Base *motion = [NSClassFromString( motionClassName ) motionWithControlTarget: aControlTarget motionSetting: aSetting];
    MZAssert( motion != nil, @"Create motion fail, class name=(%@)", motionClassName );
    
    return motion;
}

-(MZMotion_Base *)getReferenceToLeaderLinearMotionWithSetting:(MZMotionSetting *)aSetting controlTarget:(MZGameObject *)aControlTarget
{
    NSMutableDictionary *nsDictionary = [NSMutableDictionary dictionaryWithDictionary: [aSetting getOriginalNSDictionary]];
    [nsDictionary setObject: @"Linear" forKey: @"MotionType"];
        
    MZMotionSetting *newSetting = [MZMotionSetting motionSettingWithNSDictionary: nsDictionary];
    return [self getMotionBySetting: newSetting controlTarget: aControlTarget];
}

@end
