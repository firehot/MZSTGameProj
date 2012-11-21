#import "MZBgFeatureControl_Base.h"
#import "MZGamePlayBackgroundLayer.h"
#import "MZUtilitiesHeader.h"

@implementation MZBgFeatureControl_Base

#pragma mark - init and dealloc

+(MZBgFeatureControl_Base *)controlWithLevelComponenets:(MZLevelComponents *)aLevelComponents
                                      settingDictionary:(NSDictionary *)aSettingDictionary
                                            parentLayer:(MZGamePlayBackgroundLayer *)aParentLayer
{
    return [[[self alloc] initWithLevelComponenets: aLevelComponents settingDictionary: aSettingDictionary parentLayer: aParentLayer] autorelease];
}

-(id)initWithLevelComponenets:(MZLevelComponents *)aLevelComponents
            settingDictionary:(NSDictionary *)aSettingDictionary
                  parentLayer:(MZGamePlayBackgroundLayer *)aParentLayer
{
    MZAssert( aLevelComponents, @"aLevelComponents is nil" );
    MZAssert( aSettingDictionary, @"aSettingDictionary is nil" );
    MZAssert( aParentLayer, @"aParentLayer is nil" );
    
    settingDictionary = [aSettingDictionary retain];
    parentLayerRef = aParentLayer;
    
    self = [super initWithLevelComponenets: aLevelComponents];
    return  self;
}

-(void)dealloc
{
    [settingDictionary release];
    parentLayerRef = nil;
    
    [super dealloc];
}

@end