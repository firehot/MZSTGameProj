#import "MZGamePlayBackgroundLayer.h"
#import "MZLevelComponents.h"
#import "MZUtilitiesHeader.h"
#import "MZCCUtilitiesHeader.h"
#import "MZTime.h"
#import "MZGamePlayLayersHeader.h"
#import "MZBgEventsControl.h"
#import "MZBgFeatureControlHeader.h"
#import "MZObjectHelper.h"
#import "MZGameSettingsHeader.h"
#import "cocos2d.h"

@interface MZGamePlayBackgroundLayer (Private)
-(void)_setDeltaMovement;
-(void)_updateCenter;
-(void)_updateSubLayers;
@end

#pragma mark

@implementation MZGamePlayBackgroundLayer

@synthesize deltaMovemnetEveryUpdate;
@synthesize center;

#pragma mark - init and dealloc

#pragma mark - properties

-(NSNumber *)layerTypeInNSNumber
{
    return [NSNumber numberWithInt: kMZGamePlayLayerType_BackgroundLayer];
}

#pragma mark - override

-(void)update
{
    [super update];
    
    [self _setDeltaMovement];
    [self _updateCenter];
    [self _updateSubLayers];
}

-(void)beforeRelease
{
    [MZObjectHelper releaseAndSetNilToObject: &tempEventsDictArray];
    [MZObjectHelper releaseAndSetNilToObject: &tempBgFeatureControlDicArray];
    [bgEventsControl release];
    
    [bgFeatureControlsArray release];
    
    [super beforeRelease];
}

#pragma mark - methods

@end

#pragma mark

@implementation MZGamePlayBackgroundLayer (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    
    center = [MZCCDisplayHelper sharedInstance].stanadardCenter;
}

-(void)_initWithLevelSettingDictionary:(NSDictionary *)levelSettingDictionary
{
    tempEventsDictArray = [[levelSettingDictionary objectForKey: @"Events"] retain];
    tempBgFeatureControlDicArray = [[levelSettingDictionary objectForKey: @"backgrounds"] retain];
}

-(void)_initAfterGetLevelComponents
{
    [super _initAfterGetLevelComponents];
    
    [tempEventsDictArray release];
    tempEventsDictArray = nil;
    
    if( bgFeatureControlsArray == nil ) bgFeatureControlsArray = [[NSMutableArray alloc] initWithCapacity: 1];
    
    for( NSDictionary *bgFeatureControlDic in tempBgFeatureControlDicArray )
    {
        MZAssert( [bgFeatureControlDic objectForKey: @"type"], @"bgFeatureControlDic do not have type" );
        NSString *className = [NSString stringWithFormat: @"MZBgFeatureControl_%@", [bgFeatureControlDic objectForKey: @"type"]];
        
        MZBgFeatureControl_Base *bgFeatureControl = [NSClassFromString( className ) controlWithSettingDictionary: bgFeatureControlDic
                                                                                                     parentLayer: self];
        MZAssert( bgFeatureControl, @"bgFeatureControl create fail with class name(%@)", className );
        
        [bgFeatureControlsArray addObject: bgFeatureControl];
    }
    
    [tempBgFeatureControlDicArray release];
    tempBgFeatureControlDicArray = nil;
    
    for( MZBgFeatureControl_Base *bgFeature in bgFeatureControlsArray )
        [bgFeature enable];
    
    bgEventsControl = [[MZBgEventsControl alloc] initWithParentBgLayer: self];
    [bgEventsControl enable];
}

@end

#pragma mark

@implementation MZGamePlayBackgroundLayer (Private)

-(void)_setDeltaMovement
{
    float movemnet = 10; // temp
    deltaMovemnetEveryUpdate = [MZTime sharedInstance].deltaTime*movemnet;
}

-(void)_updateCenter
{
    center = mzp( 160, 240 + [MZTime sharedInstance].totalTime*10 );
}

-(void)_updateSubLayers
{
    [bgEventsControl update];
    
    for( MZBgFeatureControl_Base *featureControl in bgFeatureControlsArray )
        [featureControl update];
}

@end
