#import "MZGamePlayHUDLayer.h"
#import "MZGamePlayLayersHeader.h"
#import "MZUtilitiesHeader.h"
#import "MZGameSettingsHeader.h"

@interface MZGamePlayHUDLayer (Private)
-(void)_initHUDComponenets;
@end

#pragma mark

@implementation MZGamePlayHUDLayer

#pragma mark - init and dealloc

-(void)dealloc
{
    [gamePlayHUDComponenetsDictionary release];
    [super dealloc];
}

#pragma mark - properties

-(void)setLevelComponentsRef:(MZLevelComponents *)aLevelComponentsRef
{
    levelComponentsRef = aLevelComponentsRef;
    
    if( [gamePlayHUDComponenetsDictionary objectForKey: [NSNumber numberWithInt: kMZGamePlayHUD_Editor]] != nil )
    {
        MZGamePlayHUD_Editor *editor = [gamePlayHUDComponenetsDictionary objectForKey: [NSNumber numberWithInt: kMZGamePlayHUD_Editor]];
        [editor setEventOccurFlagsAfterGetLevelComponenet];
    }
}

-(NSNumber *)layerTypeInNSNumber
{
    return [NSNumber numberWithInt: kMZGamePlayLayerType_HUDLayer];
}

#pragma mark - override

-(void)update
{
    [super update];
    
    for( MZGamePlayHUD_Base *hud in [gamePlayHUDComponenetsDictionary allValues] )
        [hud update];
}

-(void)beforeRelease
{
    for( MZGamePlayHUD_Base *hud in [gamePlayHUDComponenetsDictionary allValues] )
        [hud beforeRelease];
}

#pragma mark - methods

-(MZGamePlayHUD_Base *)hudComponenetsWithType:(MZGamePlayHUDType)type
{
    return [gamePlayHUDComponenetsDictionary objectForKey: [NSNumber numberWithInt: type]];
}

@end

#pragma mark

@implementation MZGamePlayHUDLayer (Protected)

#pragma mark - override

-(void)_initWithLevelSettingDictionary:(NSDictionary *)levelSettingDictionary
{
    [self _initHUDComponenets];
}

@end

#pragma mark

@implementation MZGamePlayHUDLayer (Private)

-(void)_initHUDComponenets
{
    gamePlayHUDComponenetsDictionary = [[NSMutableDictionary alloc] initWithCapacity: 0];
    
    [gamePlayHUDComponenetsDictionary setObject: [MZGamePlayHUD_Panel gamePlayHUDWithTargetLayer: self parentScene: parentSceneRef]
                                         forKey: [NSNumber numberWithInt: kMZGamePlayHUD_Panel]];
    
    [gamePlayHUDComponenetsDictionary setObject: [MZGamePlayHUD_Buttons gamePlayHUDWithTargetLayer: self parentScene: parentSceneRef]
                                         forKey: [NSNumber numberWithInt: kMZGamePlayHUD_Buttons]];
    
    if( [MZGameSetting sharedInstance].system.isEditMode )
    {
        [gamePlayHUDComponenetsDictionary setObject: [MZGamePlayHUD_Editor gamePlayHUDWithTargetLayer: self parentScene: parentSceneRef]
                                             forKey: [NSNumber numberWithInt: kMZGamePlayHUD_Editor]];
    }
}

@end