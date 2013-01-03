#import "MZGamePlayScene.h"
#import "MZLevelResourcesLoader.h"
#import "MZLevelComponentsHeader.h"
#import "MZTime.h"
#import "MZGameSettingsHeader.h"
#import "MZUtilitiesHeader.h"
#import "cocos2d.h"

@interface MZGamePlayScene (Private)
-(void)_initLayersWithLevelSettingDictionary:(NSDictionary *)levelSettingDictionary;
-(void)_initLevelComponentsWithLevelSettingDictionary:(NSDictionary *)levelSettingDictionary levelName:(NSString *)aLevelName;
-(void)_initScheduleAndDispatcher;

-(void)_unscheduleAndRemoveDispatcher;

-(void)_updateWithDeltaTime:(ccTime)deltaTime;
@end

#pragma mark

@implementation MZGamePlayScene

@synthesize isPause;
@synthesize timeScale;
@synthesize zoom;

-(id)init
{
    self = [super init];

    NSString *settingName = [[[MZGameSetting sharedInstance].gamePlay.levels objectAtIndex: 0] stringByAppendingPathExtension: @"plist"];
    NSDictionary *levelSettingDictioanry = [MZFileHelper plistContentFromBundleWithName: settingName];
    MZAssert( levelSettingDictioanry != nil, @"levelSettingDictioanry(%@) is nil", settingName );

    [MZLevelResourcesLoader levelResourcesLoaderWithLevelSettingNSDicitonary: levelSettingDictioanry];

    [self _initLayersWithLevelSettingDictionary: levelSettingDictioanry];
//    [self _initLevelComponentsWithLevelSettingDictionary: levelSettingDictioanry levelName: @"new_ver_test"];
    [self _initScheduleAndDispatcher];
    
    defaultEyeZ = -1;

    [[MZTime sharedInstance] reset];

    return self;
}

-(void)dealloc
{
    [super dealloc];
}

#pragma mark - properties

-(void)setTimeScale:(float)aTimeScale
{
    timeScale = aTimeScale;
    [CCDirector sharedDirector].scheduler.timeScale = timeScale;
}

-(void)setZoom:(float)aZoom
{
    zoom = aZoom;

    for( MZGamePlayLayer_Base *layer in [layersDictionary allValues] )
    {
        if( [layer class] == [MZGamePlayHUDLayer class] )
            continue;

        if( defaultEyeZ == -1 )
        {
            float eyeX, eyeY;
            [layer.camera eyeX: &eyeX eyeY: &eyeY eyeZ: &defaultEyeZ];
        }

        [layer.camera setEyeX: 0 eyeY: 0 eyeZ: ( zoom == 0 )? defaultEyeZ : zoom];
    }
}

#pragma mark - methods

-(MZGamePlayLayer_Base *)layerByType:(MZGamePlayLayerType)layerType
{
    NSNumber *nsType = [NSNumber numberWithInt: layerType];
    MZAssert( [layersDictionary objectForKey: nsType], @"Layer of this type not exist" );
    
    return [layersDictionary objectForKey: nsType];
}

-(void)pause
{
    if( isPause ) return;
    for( MZGamePlayLayer_Base *layer in [layersDictionary allValues] ) [layer pause];
    [self pauseSchedulerAndActions];
    isPause = true;
}

-(void)resume
{
    if( !isPause ) return;
    for( MZGamePlayLayer_Base *layer in [layersDictionary allValues] ) [layer resume];
    [self resumeSchedulerAndActions];
    isPause = false;
}

-(void)releaseAll
{
    [self _unscheduleAndRemoveDispatcher];
    
    for( NSNumber *layerType in [layersDictionary allKeys] )
    {
        MZGamePlayLayer_Base *layer = [layersDictionary objectForKey: layerType];
        
        [layer beforeRelease];
        [self removeChild: layer cleanup: false];
    }
    
    [layersDictionary release];

    [[MZLevelComponents sharedInstance] removeFromLevel];
}

-(void)switchSceneTo:(MZSceneType)sceneType
{
    [self releaseAll];
    [[MZScenesFlowController sharedScenesFlowController] fastSwitchToScene: sceneType];
}

@end

#pragma mark

@implementation MZGamePlayScene (Private)

#pragma mark - init

-(void)_initLayersWithLevelSettingDictionary:(NSDictionary *)levelSettingDictionary
{
//    MZGamePlaySceneLayerBase *background = [MZGamePlayBackgroundLayer layerWithLevelSettingDictionary: levelSettingDictionary parentScene: self];
    MZGamePlayLayer_Base *play = [MZGamePlayLayer layerWithLevelSettingDictionary: levelSettingDictionary parentScene: self];
//    MZGamePlaySceneLayerBase *hud = [MZGamePlayHUDLayer layerWithLevelSettingDictionary: levelSettingDictionary parentScene: self];
    
    layersDictionary = [[NSMutableDictionary alloc] initWithCapacity: 0];
//    [layersDictionary setObject: background forKey: background.layerTypeInNSNumber];
    [layersDictionary setObject: play forKey: play.layerTypeInNSNumber];
//    [layersDictionary setObject: hud forKey: hud.layerTypeInNSNumber];
    
//    [self addChild: background];
    [self addChild: play];
//    [self addChild: hud];
}

-(void)_initLevelComponentsWithLevelSettingDictionary:(NSDictionary *)levelSettingDictionary levelName:(NSString *)aLevelName
{
    [[MZLevelComponents sharedInstance] setLevelWithName: aLevelName settingDictionary: levelSettingDictionary playScene: self];

    // 有東西必須在取得 LevelComponents 之後進行, 如何修正????
    for( MZGamePlayLayer_Base *layer in [layersDictionary allValues] )
    {
        [layer _initAfterGetLevelComponents];
    }

    MZGamePlayLayer *playLayer = (MZGamePlayLayer *)[self layerByType: kMZGamePlayLayerType_PlayLayer];
    [playLayer setControlWithPlayer: [MZLevelComponents sharedInstance].player];
}

-(void)_initScheduleAndDispatcher
{
    [self schedule: @selector( _updateWithDeltaTime: )];
}

#pragma mark - releaee

-(void)_unscheduleAndRemoveDispatcher
{
    [self unschedule: @selector( _updateWithDeltaTime: )];
}

#pragma mark - methods

-(void)_updateWithDeltaTime:(ccTime)deltaTime
{
    [[MZTime sharedInstance] updateWithDeltaTime: deltaTime];
        
    [[MZLevelComponents sharedInstance] update];
    for( MZGamePlayLayer_Base *layer in [layersDictionary allValues] )
    {
        [layer update];
    }
}

@end