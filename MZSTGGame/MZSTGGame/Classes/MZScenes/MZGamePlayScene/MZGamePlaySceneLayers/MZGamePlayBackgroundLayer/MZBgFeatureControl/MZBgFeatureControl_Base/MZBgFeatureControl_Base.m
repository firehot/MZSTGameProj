#import "MZBgFeatureControl_Base.h"
#import "MZGamePlayBackgroundLayer.h"
#import "MZUtilitiesHeader.h"

@implementation MZBgFeatureControl_Base

#pragma mark - init and dealloc

+(MZBgFeatureControl_Base *)controlWithSettingDictionary:(NSDictionary *)aSettingDictionary parentLayer:(MZGamePlayBackgroundLayer *)aParentLayer
{
    return [[[self alloc] initWithWithSettingDictionary: aSettingDictionary parentLayer: aParentLayer] autorelease];
}

-(id)initWithWithSettingDictionary:(NSDictionary *)aSettingDictionary parentLayer:(MZGamePlayBackgroundLayer *)aParentLayer
{
    MZAssert( aSettingDictionary, @"aSettingDictionary is nil" );
    MZAssert( aParentLayer, @"aParentLayer is nil" );
    
    settingDictionary = [aSettingDictionary retain];
    parentLayerRef = aParentLayer;
    
    self = [super init];
    return  self;
}

-(void)dealloc
{
    [settingDictionary release];
    parentLayerRef = nil;
    
    [super dealloc];
}

@end