#import "MZBgEventsControl.h"
#import "MZCCUtilitiesHeader.h"
#import "MZUtilitiesHeader.h"
#import "MZLevelComponentsHeader.h"
#import "MZEventsHeader.h"
#import "MZGameSettingsHeader.h"
#import "MZGamePlayBackgroundLayer.h"
#import "MZEventMetadata.h"
#import "MZEnrageRangeManage.h"
#import "MZLevelComponentsHeader.h"
#import "cocos2d.h"

@interface MZBgEventsControl (Private)
-(void)_updateEventMetadatas;
-(CGPoint)_eventPositionInScreenWithMetaMetadata:(MZEventMetadata *)metadata;
@end

#pragma mark

@implementation MZBgEventsControl

#pragma mark - init and dealloc

-(id)initWithParentBgLayer:(MZGamePlayBackgroundLayer *)aParentBgLayer
{
    MZAssert( aParentBgLayer, @"aParentBgLayer is nil" );
    parentBackgroundLayerRef = aParentBgLayer;
    
    self = [super init];
    
    return self;
}

-(void)dealloc
{
    [enrageRangeManage release];
    parentBackgroundLayerRef = nil;
    
    [super dealloc];
}

#pragma mark - methods

@end

#pragma mark

@implementation MZBgEventsControl (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    
    enrageRangeManage =
    [[MZEnrageRangeManage alloc] initWithBackgroundLayer: parentBackgroundLayerRef
                                       settingDictionary: [MZGameSetting sharedInstance].gamePlay.enrageRangeRectStringsDictionary];
}

-(void)_update
{
    [super _update];
    [self _updateEventMetadatas];
}

@end

#pragma mark

@implementation MZBgEventsControl (Private)

#pragma mark - init

#pragma mark - methods

-(void)_updateEventMetadatas
{
    for( int i = 0; i < [[MZLevelComponents sharedInstance].eventMetadatasArray count]; i++ )
    {
        MZEventMetadata *metadata = [[MZLevelComponents sharedInstance].eventMetadatasArray objectAtIndex: i];
        
        if( metadata.hasExecuted == false && [enrageRangeManage isInEnrageRangeWithEventMetadata: metadata] )
        {
            NSDictionary *eventsDefineDictionary = [MZLevelComponents sharedInstance].eventDefinesDictionary;
            NSDictionary *eventDictionary = [eventsDefineDictionary objectForKey: metadata.eventDefineName];
            MZEvent *event = [[MZEventsFactory sharedInstance] eventByDcitionary: eventDictionary];
            event.position = [self _eventPositionInScreenWithMetaMetadata: metadata];
            [[MZLevelComponents sharedInstance].eventsExecutor executeEvent: event];
            
            metadata.hasExecuted = true;
            if( [MZGameSetting sharedInstance].system.isEditMode == false )
            {
                [[MZLevelComponents sharedInstance].eventMetadatasArray removeObjectAtIndex: i];
                i--;
            }
        }
    }
}

-(CGPoint)_eventPositionInScreenWithMetaMetadata:(MZEventMetadata *)metadata
{
    return mzpAdd( [MZCCDisplayHelper sharedInstance].stanadardCenter, mzpSub( metadata.position, parentBackgroundLayerRef.center ) );
}

@end