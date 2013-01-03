#import "MZEnrageRangeManage.h"
#import "MZGameSettingsHeader.h"
#import "MZGamePlayBackgroundLayer.h"
#import "MZUtilitiesHeader.h"
#import "MZCCUtilitiesHeader.h"
#import "MZEventMetadata.h"
#import "cocos2d.h"

@interface MZEnrageRangeManage (Private)
-(void)_initEnrageRectsWithSettingDictoinary:(NSDictionary *)settingDictoinary;
-(void)_initDrawRange;
@end

#pragma mark

@implementation MZEnrageRangeManage

#pragma mark - init and dealloc

-(id)initWithBackgroundLayer:(MZGamePlayBackgroundLayer *)aBackgroundLayer settingDictionary:(NSDictionary *)aSettingDictionary
{
    MZAssert( aBackgroundLayer, @"aBackgroundLayer is nil" );
    
    self = [super init];
    
    backgroundLayerRef = aBackgroundLayer;
    [self _initEnrageRectsWithSettingDictoinary: aSettingDictionary];
    [self _initDrawRange];
    
    return self;
}

-(void)dealloc
{
    [backgroundLayerRef removeChild: rangeDraw cleanup: false]; [rangeDraw release];
    [enrageRectsByNameDictionary release];
    backgroundLayerRef = nil;
    [super dealloc];
}

#pragma mark - methods

-(bool)isInEnrageRangeWithEventMetadata:(MZEventMetadata *)eventMetadata
{
    CGPoint offset = mzpSub( backgroundLayerRef.center, [MZCCDisplayHelper sharedInstance].stanadardCenter );
    
    for( NSString *name in [enrageRectsByNameDictionary allKeys] )
    {
        // name 判斷 ... 暫時不實裝
        
        CGRect rect = [[enrageRectsByNameDictionary objectForKey: name] CGRectValue];
        CGRect currentRect = CGRectMake( rect.origin.x + offset.x, rect.origin.y + offset.y, rect.size.width, rect.size.height );
        if( CGRectContainsPoint( currentRect, eventMetadata.position ) )
        {
            return true;
        }
    }
    
    return false;
}

@end

#pragma mark

@implementation MZEnrageRangeManage (Private)

#pragma mark - init

-(void)_initEnrageRectsWithSettingDictoinary:(NSDictionary *)settingDictoinary
{
    MZAssert( settingDictoinary, @"settingDictoinary is nil" );
    
    enrageRectsByNameDictionary = [[NSMutableDictionary alloc] initWithCapacity: 0];
    
    for( NSString *name in [settingDictoinary allKeys] )
    {
        NSString *rectString = [settingDictoinary objectForKey: name];
        CGRect rect = CGRectFromString( rectString );
        
        [enrageRectsByNameDictionary setObject: [NSValue valueWithCGRect: rect] forKey: name];
    }
}

-(void)_initDrawRange
{
    rangeDraw = [CCDrawNode node];
    [rangeDraw retain];
    
    for( NSValue *nsRect in [enrageRectsByNameDictionary allValues] )
    {
        CGRect rect = [nsRect CGRectValue];
        [MZCCDrawPrimitivesHelper addToDrawNode: &rangeDraw withStdRect: rect lineWidth: 3 color: ccc4f( 0.929, 1.0, 0.325, 1 )];
    }
    
    [backgroundLayerRef addChild: rangeDraw];
}

@end