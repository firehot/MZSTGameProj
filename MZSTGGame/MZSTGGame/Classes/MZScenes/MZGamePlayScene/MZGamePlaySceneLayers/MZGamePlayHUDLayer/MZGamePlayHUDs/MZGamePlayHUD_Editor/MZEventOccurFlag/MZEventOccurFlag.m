#import "MZEventOccurFlag.h"
#import "MZGamePlayBackgroundLayer.h"
#import "MZUtilitiesHeader.h"
#import "MZCCUtilitiesHeader.h"
#import "MZEventMetadata.h"
#import "MZLevelComponentsHeader.h"
#import "cocos2d.h"

@interface MZEventOccurFlag (Private)
-(void)_setEditPosition:(CGPoint)aEditPosition;
-(CGRect)_boundRect;

-(void)_updateState;
-(void)_setFocusState;
-(void)_setNonFocusState;

-(void)_setBeforeEnrageState;
-(void)_setAfterEnrageState;

@end

#pragma mark

@implementation MZEventOccurFlag

@synthesize focus;
@synthesize editPosition;
@synthesize screenPosition;
@synthesize eventMetadataRef;

#pragma mark - init and dealloc

+(MZEventOccurFlag *)flagWithLevelComponenets:(MZLevelComponents *)aLevelComponents
                                eventMetadata:(MZEventMetadata *)aEventMetadata
                                      bgLayer:(MZGamePlayBackgroundLayer *)aBgLayer
                                      handler:(id<MZEventOccurFlagHandler>)aHandler
{
    return [[[self alloc] initWithLevelComponenets: aLevelComponents
                                     eventMetadata: aEventMetadata
                                           bgLayer: aBgLayer
                                           handler: aHandler] autorelease];
}

-(id)initWithLevelComponenets:(MZLevelComponents *)aLevelComponents
                eventMetadata:(MZEventMetadata *)aEventMetadata
                      bgLayer:(MZGamePlayBackgroundLayer *)aBgLayer
                      handler:(id<MZEventOccurFlagHandler>)aHandler;
{
    MZAssert( aBgLayer, @"aBgLayer is nil" );
    MZAssert( aEventMetadata, @"aEventMetadata is nil" );
    bgLayerRef = aBgLayer;
    handler = aHandler;
    eventMetadataRef = aEventMetadata;

    self = [super initWithLevelComponenets: aLevelComponents];

    return self;
}

-(void)dealloc
{
    [flag release];
    [bgLayerRef removeChild: flagBound cleanup: false]; [flagBound release];
    
    [levelComponentsRef removeEventMetadata: eventMetadataRef];
    eventMetadataRef = nil;
    
    bgLayerRef = nil;
    handler = nil;

    [super dealloc];
}

#pragma mark - properties

-(void)setPosition:(CGPoint)aPosition
{
    
}

-(CGPoint)position
{
    return CGPointZero;
}

-(void)setScreenPosition:(CGPoint)aScreenPosition
{
    screenPosition = aScreenPosition;
    bgCenterAtSetPosition = bgLayerRef.center;
    
    diffBetweenCenter = mzpSub( aScreenPosition, [MZCCDisplayHelper sharedInstance].stanadardCenter );
    [self _setEditPosition: mzpAdd( bgCenterAtSetPosition, diffBetweenCenter )];
    
    [self _update];
}

#pragma mark - override

-(void)disable
{
    [super disable];
    [handler removeEventOccurFlag: self];
}

#pragma mark - methods

-(bool)isInTouchRangeWithStandardTouch:(CGPoint)standardTouch
{
    CGRect boundRectInScreen = [self _boundRect];
    boundRectInScreen.origin = mzp( flag.position.x - boundRectInScreen.size.width/2, flag.position.y - boundRectInScreen.size.height/2 );
    
    return CGRectContainsPoint( boundRectInScreen, [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: standardTouch] );
}

@end

@implementation MZEventOccurFlag (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];

    NSDictionary *iconSettingDict = [[levelComponentsRef.eventDefinesDictionary objectForKey: eventMetadataRef.eventDefineName] objectForKey: @"icon"];

    MZAssert( iconSettingDict, @"iconSettingDict is nil" );

    flag = [CCSprite node];
    [flag retain];
    [self setSprite: flag parentLayer: bgLayerRef];
    [self setPropertiesWithDictionary: iconSettingDict];
    
    flagBound = [CCDrawNode node];
    [flagBound retain];
    [bgLayerRef addChild: flagBound];
    
    self.screenPosition = eventMetadataRef.position;
}

-(void)_update
{
    [super _update];
    
    CGPoint diffOfCurrentAndEventBgCenter = mzpSub( bgCenterAtSetPosition, bgLayerRef.center );
    CGPoint currentEventBgCenterInScreen = mzpAdd( [MZCCDisplayHelper sharedInstance].stanadardCenter, diffOfCurrentAndEventBgCenter );
    
    flag.position = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: mzpAdd( currentEventBgCenterInScreen, diffBetweenCenter )];
    flagBound.position = flag.position;
    
    [self _updateState];
}

@end

#pragma mark

@implementation MZEventOccurFlag (Private)

#pragma mark - methods

-(void)_setEditPosition:(CGPoint)aEditPosition
{
    CGPoint editPosition_ = CGPointiFromPoint( aEditPosition );

    editPosition = editPosition_;
    eventMetadataRef.position = editPosition_;
}

-(CGRect)_boundRect
{
    CGSize flagSize =  CGSizeMake( flag.contentSize.width*flag.scaleX, flag.contentSize.height*flag.scaleY );
    return CGRectMake( -flagSize.width/2, -flagSize.height/2, flagSize.width, flagSize.height );
}

-(void)_updateState
{
    ( focus )? [self _setFocusState] : [self _setNonFocusState];
}

-(void)_setFocusState
{
    flag.opacity = 255;
    
    [flagBound clear];
    [MZCCDrawPrimitivesHelper addToDrawNode: &flagBound withRect: [self _boundRect] lineWidth: 4 color: ccc4f( 0, 1, 0, 1 )];
}

-(void)_setNonFocusState
{
    ( eventMetadataRef.hasExecuted )? [self _setAfterEnrageState] : [self _setBeforeEnrageState];
}

-(void)_setBeforeEnrageState
{
    flag.opacity = 255;
    [flagBound clear];
    [MZCCDrawPrimitivesHelper addToDrawNode: &flagBound withRect: [self _boundRect] lineWidth: 2 color: ccc4f( 0, 0.5, 0, 1 )];
}

-(void)_setAfterEnrageState
{
    flag.opacity = 128;
    [flagBound clear];
    [MZCCDrawPrimitivesHelper addToDrawNode: &flagBound withRect: [self _boundRect] lineWidth: 2 color: ccc4f( 0, 0.5, 0, 0.5 )];
}

@end