#import "MZGamePlayHUD_Editor.h"
#import "MZGamePlayScene.h"
#import "MZUtilitiesHeader.h"
#import "MZCCUtilitiesHeader.h"
#import "MZEventOccurFlag.h"
#import "MZEventMetadata.h"
#import "MZGamePlayHUDLayer.h"
#import "MZGameSettingsHeader.h"
#import "MZLevelComponentsHeader.h"
#import "cocos2d.h"

#define EVENT_ITEM_SELECTED_COLOR ccc3( 255, 255, 255 );
#define EVENT_ITEM_UNSELECTED_COLOR ccc3( 209, 20, 114 );

const float CAMERA_ZOOM_OUT_Z = 200;
const float ZOOM_OUT_SCALE_VALUE_FOR_IPAD = 1.225;

@interface MZGamePlayHUD_Editor (Private)
-(void)_initLabels;
-(void)_initButtons;
-(void)_initCenterPositionLabel;
-(void)_initEventItemsList;
-(void)_initCurrentEventFlagControl;

// event list cntrol
-(void)_onShowEventItemListClick:(id)sender;
-(void)_onEventListItemClick:(id)sender;
-(void)_cancelCurrentEventItem;
-(void)_onSaveClick:(id)sender;
-(void)_updateCurrentEventItemLabel;
-(NSString *)_eventNameByIndex:(int)index;

// current focus event flag control
-(void)_onRemoveCurrentFocusEventFlag:(id)sender;
-(void)_setEventFlagControlWithFlag:(MZEventOccurFlag *)flag;
-(void)_updateCurrentFocusFlagPositionLabel;

// time flow control
-(CCMenuItemLabel *)_createTimeScaleButtonWithScale:(int)timeScale stdPosition:(CGPoint)stdPosition selector:(SEL)selector;
-(void)_onTimeSwitchClick:(id)sender;
-(void)_onTimeScaleClick:(id)sender;
-(void)_onTimeBackClick:(id)sender;
-(void)_pauseToEditMode;
-(void)_resumeFromEditMode;

// zoom control
-(void)_onZoomClick:(id)sender;

// EventOccurFlag
-(void)_addEventOccurFlagWithEventMetadata:(MZEventMetadata *)eventMetadata;
-(void)_addEventOccurFlagWithStdTouchPosition:(CGPoint)stdTouchPosition;

// position and touch
-(void)_setTouchPositionValue:(CGPoint)touchPositionValue;
-(CGPoint)_standPositionFromTouch:(UITouch *)touch;
@end

#pragma mark

@implementation MZGamePlayHUD_Editor

#pragma mark - init and dealloc

#pragma mark - properties

#pragma mark - CCStandardTouchDelegate

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( [touches count] > 1 || !isPauseForEdit ) return;
    
    CGPoint stdTouchPos = [self _standPositionFromTouch: [touches anyObject]];
    [self _setTouchPositionValue: stdTouchPos];
    
    currentFocusFlagRef = nil;
    for( MZEventOccurFlag *occurFlag in eventOccurFlagsArray )
    {
        occurFlag.focus = false;
        
        if( [occurFlag isInTouchRangeWithStandardTouch: stdTouchPos] )
        {
            occurFlag.focus = true;
            currentFocusFlagRef = occurFlag;
        }
    }
    
    if( currentFocusFlagRef == nil )
    {
        [self _addEventOccurFlagWithStdTouchPosition: stdTouchPos];
    }
    
    [self _setEventFlagControlWithFlag: currentFocusFlagRef];
    [self _updateCurrentFocusFlagPositionLabel];
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( [touches count] > 1 || !isPauseForEdit ) return;
    
    CGPoint stdTouchPos = [self _standPositionFromTouch: [touches anyObject]];
    [self _setTouchPositionValue: stdTouchPos];
    
    if( currentFocusFlagRef == nil ) return;
    
    currentFocusFlagRef.screenPosition = CGPointiFromPoint( stdTouchPos );
    [self _updateCurrentFocusFlagPositionLabel];
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

}

#pragma mark - MZEventOccurFlagHandler

-(void)removeEventOccurFlag:(MZEventOccurFlag *)occurFlag
{
    [eventOccurFlagsArray removeObject: occurFlag];
}

#pragma mark - override

-(void)update
{
    [super update];
    
    gameTimeLabelRef.string = [NSString stringWithFormat: @"%03.0fsec", [MZTime sharedInstance].totalTime];

    MZGamePlayBackgroundLayer *bgLayer = (MZGamePlayBackgroundLayer *)[parentSceneRef layerByType: kMZGamePlayLayerType_BackgroundLayer];
    centerPositionLabel.string = [NSString stringWithFormat: @"(%03.0f,%03.0f)", bgLayer.center.x, bgLayer.center.y];
    
    for( int i = 0; i < eventOccurFlagsArray.count; i++ )
    {
        MZEventOccurFlag *flag = [eventOccurFlagsArray objectAtIndex: i];
        [flag update];
        
        if( flag.isActive == false )
        {
            [eventOccurFlagsArray removeObjectAtIndex: i];
            i--;
        }
    }
}

-(void)beforeRelease
{
    [[CCDirector sharedDirector].touchDispatcher removeDelegate: self];

    [eventOccurFlagsArray release];
//    [eventsDefineDictionary release];
    [targetLayerRef removeChild: touchPositionLabel cleanup: false]; [touchPositionLabel release];
    [targetLayerRef removeChild: eventsButtonMenu cleanup: false]; [eventsButtonMenu release];
    [targetLayerRef removeChild: buttonsMenu cleanup: false]; [buttonsMenu release];
    [targetLayerRef removeChild: centerPositionLabel cleanup: false]; [centerPositionLabel release];
    [targetLayerRef removeChild: currentFocusFlagPositionLabel cleanup: false]; [currentFocusFlagPositionLabel release];
    [targetLayerRef removeChild: occurFlagControlMenu cleanup: false]; [occurFlagControlMenu release];
    
    if( currentEventLabel ) [targetLayerRef removeChild: currentEventLabel cleanup: false];

    eventsDefineDictionary = nil;
    gameTimeLabelRef = nil;
    targetLayerRef = nil;
}

#pragma mark - methods

-(void)setEventOccurFlagsAfterGetLevelComponenet
{
    MZAssert( targetLayerRef.levelComponentsRef, @"LevelComponenet is nil" );
    
    [self _initEventItemsList];
            
    for( MZEventMetadata *metadata in targetLayerRef.levelComponentsRef.eventMetadatasArray )
    {
        [self _addEventOccurFlagWithEventMetadata: metadata];
    }
}

@end

#pragma mark

@implementation MZGamePlayHUD_Editor (Protected)

#pragma mark - override

-(void)_init
{
    [super _init];

    [self _initLabels];
    [self _initButtons];
    [self _initCenterPositionLabel];
//    [self _initEventItemsList];
    [self _initCurrentEventFlagControl];

    isPauseForEdit = false;
    isZoomOut = false;
    
    CGSize realScreenSize = [MZCCDisplayHelper sharedInstance].realScreenSize;
    float diffScale = 1 - ZOOM_OUT_SCALE_VALUE_FOR_IPAD;
    bottomLeftForZoomOutOfIPad = mzp( realScreenSize.width*diffScale/2, realScreenSize.height*diffScale/2 );
    
    currentEventIndex = -1;
    
    [[CCDirector sharedDirector].touchDispatcher addStandardDelegate: self priority: 200];
}

@end

#pragma mark

@implementation MZGamePlayHUD_Editor (Private)

#pragma mark - init

-(void)_initLabels
{
    touchPositionLabel = [[CCLabelBMFont alloc] initWithString: @"(0.0,0.0)" fntFile: @"CooperStd.fnt"];
    touchPositionLabel.color = ccc3( 255, 128, 0 );
    touchPositionLabel.position = [[MZCCDisplayHelper sharedInstance] realPositionFromProportionWithStandard: mzp( 160, 10 )];
    
    [targetLayerRef addChild: touchPositionLabel];
}

-(void)_initButtons
{
    CCLabelBMFont *gameTimeLabel = [CCLabelBMFont labelWithString: @"000sec" fntFile: @"CooperStd.fnt"];
    CCMenuItemLabel *gameTime = [CCMenuItemLabel itemWithLabel: gameTimeLabel target: self selector: @selector( _onTimeSwitchClick: )];
    gameTime.scale = 2;
    gameTime.color = ccc3( 210, 138, 94 );
    gameTime.position = [[MZCCDisplayHelper sharedInstance] realPositionFromProportionWithStandard: mzp( 160, 30 )];
    gameTimeLabelRef = gameTimeLabel;
    
    CGPoint startPos = mzp( 15, 60 );
    float interval = 30;
    int scaleValues[] = { 1, 4, 8 };
    
    // time scale
    CCMenuItemLabel *timeScale1 = [self _createTimeScaleButtonWithScale: scaleValues[0]
                                                            stdPosition: mzpAdd( startPos, mzp( 0, interval*0 ) )
                                                               selector: @selector( _onTimeScaleClick: )];
    CCMenuItemLabel *timeScale2 = [self _createTimeScaleButtonWithScale: scaleValues[1]
                                                            stdPosition: mzpAdd( startPos, mzp( 0, interval*1 ) )
                                                               selector: @selector( _onTimeScaleClick: )];
    CCMenuItemLabel *timeScale3 = [self _createTimeScaleButtonWithScale: scaleValues[2]
                                                            stdPosition: mzpAdd( startPos, mzp( 0, interval*2 ) )
                                                               selector: @selector( _onTimeScaleClick: )];
    
    // time back
    CCMenuItemLabel *back10 = [CCMenuItemLabel itemWithLabel: [CCLabelBMFont labelWithString: @"Back10" fntFile: @"CooperStd.fnt"]
                                                      target: self
                                                    selector: @selector( _onTimeBackClick: )];
    back10.position = [[MZCCDisplayHelper sharedInstance] realPositionFromProportionWithStandard: mzpAdd( startPos, mzp( 30, interval*3 ) )];
    back10.tag = 10;
    
    CCMenuItemLabel *back30 = [CCMenuItemLabel itemWithLabel: [CCLabelBMFont labelWithString: @"Back30" fntFile: @"CooperStd.fnt"]
                                                      target: self
                                                    selector: @selector( _onTimeBackClick: )];
    back30.position = [[MZCCDisplayHelper sharedInstance] realPositionFromProportionWithStandard: mzpAdd( startPos, mzp( 30, interval*4 ) )];
    back30.tag = 30;

    // zoom
    CCMenuItemLabel *zoom = [CCMenuItemLabel itemWithLabel: [CCLabelBMFont labelWithString: @"ZOOM" fntFile: @"CooperStd.fnt"]
                                                    target: self
                                                  selector: @selector( _onZoomClick: )];
    zoom.position = [[MZCCDisplayHelper sharedInstance] realPositionFromProportionWithStandard: mzp( 285, 90 )];
    zoom.color = ccc3( 0, 255, 128 );
    
    // event
    CCMenuItemLabel *events = [CCMenuItemLabel itemWithLabel: [CCLabelBMFont labelWithString: @"EVENT" fntFile: @"CooperStd.fnt"]
                                                      target: self
                                                    selector: @selector( _onShowEventItemListClick: )];
    events.position = [[MZCCDisplayHelper sharedInstance] realPositionFromProportionWithStandard: mzp( 285, 120 )];

    // save
    CCMenuItemLabel *save = [CCMenuItemLabel itemWithLabel: [CCLabelBMFont labelWithString: @"SAVE" fntFile: @"CooperStd.fnt"]
                                                    target: self
                                                  selector: @selector( _onSaveClick: )];
    save.label.color = ccc3( 161, 227, 42 );
    save.position = [[MZCCDisplayHelper sharedInstance] realPositionFromProportionWithStandard: mzp( 220, 90 )];

    buttonsMenu = [CCMenu menuWithItems: gameTime, timeScale1, timeScale2, timeScale3, back10, back30, zoom, events, save, nil];
    [buttonsMenu retain];
    buttonsMenu.position = CGPointZero;

    [targetLayerRef addChild: buttonsMenu];
}

-(void)_initCenterPositionLabel
{
    centerPositionLabel = [CCLabelBMFont labelWithString: @"(000,000)" fntFile: @"CooperStd.fnt"];
    [centerPositionLabel retain];
    centerPositionLabel.position = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: mzp( 160, 230 )];
    centerPositionLabel.scale = 0.5;

    [targetLayerRef addChild: centerPositionLabel];
}

-(void)_initEventItemsList
{
    eventsDefineDictionary = targetLayerRef.levelComponentsRef.eventDefinesDictionary;
    //[[MZFileHelper plistContentFromBundleWithName: @"[test]events_define.plist"] objectForKey: @"EventsDefine"];
//    [eventsDefineDictionary retain];
    
    NSMutableArray *eventButtonsArray = [NSMutableArray arrayWithCapacity: 0];
    float interval = 25;
    CGPoint startPos = mzp( 300, 120 + interval );
    for( int i = 0; i < [[eventsDefineDictionary allKeys] count] + 1; i++ )
    {
        NSString *eventName = ( i != [[eventsDefineDictionary allKeys] count] )?
        [[eventsDefineDictionary allKeys] objectAtIndex: i] : @"Cancel";

        CCMenuItemLabel *eventButton = [CCMenuItemLabel itemWithLabel: [CCLabelBMFont labelWithString: eventName fntFile: @"CooperStd.fnt"]
                                                               target: self
                                                             selector: @selector( _onEventListItemClick: )];
        eventButton.anchorPoint = mzp( 1, 0 );
        eventButton.tag = i;
        eventButton.scale = 0.6;
        eventButton.color = EVENT_ITEM_UNSELECTED_COLOR;
        eventButton.position = [[MZCCDisplayHelper sharedInstance] realPositionFromProportionWithStandard: mzpAdd( startPos, mzp( 0, i*interval ) )];
        [eventButtonsArray addObject: eventButton];
    }
    
    eventsButtonMenu = [CCMenu menuWithArray: eventButtonsArray];
    [eventsButtonMenu retain];
    eventsButtonMenu.position = CGPointZero;
    eventsButtonMenu.visible = false;
    
    [targetLayerRef addChild: eventsButtonMenu];
}

-(void)_initCurrentEventFlagControl
{
    currentFocusFlagRef = nil;
    currentFocusFlagPositionLabel = [CCLabelBMFont labelWithString: @"{000,000}" fntFile: @"CooperStd.fnt"];
    [currentFocusFlagPositionLabel retain];
    currentFocusFlagPositionLabel.position = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: mzp( 52, 90 )];
    
    CCMenuItem *remove = [CCMenuItemLabel itemWithLabel: [CCLabelBMFont labelWithString: @"Remove" fntFile: @"CooperStd.fnt"]
                                                 target: self
                                               selector: @selector( _onRemoveCurrentFocusEventFlag: )];
    remove.position = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: mzp( 52, 70 )];
    
    occurFlagControlMenu = [CCMenu menuWithItems: remove, nil];
    [occurFlagControlMenu retain];
    occurFlagControlMenu.position = CGPointZero;
    
    occurFlagControlMenu.visible = false;
    currentFocusFlagPositionLabel.visible = false;
    
    [targetLayerRef addChild: currentFocusFlagPositionLabel];
    [targetLayerRef addChild: occurFlagControlMenu];
}

#pragma mark - actions

-(void)_onTimeSwitchClick:(id)sender
{    
    ( isPauseForEdit )? [self _resumeFromEditMode] : [self _pauseToEditMode];
}

-(void)_onTimeScaleClick:(id)sender
{
    parentSceneRef.timeScale = ((CCMenuItem *)sender).tag;
}

-(void)_onTimeBackClick:(id)sender
{
    [targetLayerRef.levelComponentsRef resetEventMeatadatas];
    
    [targetLayerRef.levelComponentsRef.charactersActionManager clearAllWithType: kMZCharacterType_EnemyBullet];
    [targetLayerRef.levelComponentsRef.charactersActionManager clearAllWithType: kMZCharacterType_Enemy];
    [targetLayerRef.levelComponentsRef.charactersActionManager clearAllWithType: kMZCharacterType_PlayerBullet];
    
    [[MZTime sharedInstance] back: ((CCMenuItem *)sender).tag];
}

-(void)_onZoomClick:(id)sender
{
    parentSceneRef.zoom = ( isZoomOut )? 0 : CAMERA_ZOOM_OUT_Z;
    isZoomOut = !isZoomOut;
}

-(void)_onShowEventItemListClick:(id)sender
{
    eventsButtonMenu.visible = !eventsButtonMenu.visible;

    if( eventsButtonMenu.visible )
        [self _pauseToEditMode];

    [self _updateCurrentEventItemLabel];
}

-(void)_onSaveClick:(id)sender
{
    [targetLayerRef.levelComponentsRef saveEventMetadata];
}

-(void)_onEventListItemClick:(id)sender
{
    for( CCMenuItemLabel *item in [eventsButtonMenu children] )
        item.color = EVENT_ITEM_UNSELECTED_COLOR;
        
    int index = ((CCMenuItem *)sender).tag;
    if( index != [eventsDefineDictionary allKeys].count )
    {
        currentEventIndex = index;
        ((CCMenuItemLabel *)sender).color = EVENT_ITEM_SELECTED_COLOR;
    }
    else
    {
        [self _cancelCurrentEventItem];
    }
}

#pragma mark - methods

-(void)_cancelCurrentEventItem
{
    currentEventIndex = -1;
    eventsButtonMenu.visible = false;
}

-(void)_updateCurrentEventItemLabel
{
    if( eventsButtonMenu.visible || currentEventIndex == -1 )
    {
        currentEventLabel.visible = false;
        return;
    }

    if( currentEventLabel != nil )
    {
        [targetLayerRef removeChild: currentEventLabel cleanup: false];
        [currentEventLabel release];
        currentEventLabel = nil;
    }

    currentEventLabel = [CCLabelBMFont labelWithString: [self _eventNameByIndex: currentEventIndex] fntFile: @"CooperStd.fnt"];
    [currentEventLabel retain];
    [targetLayerRef addChild: currentEventLabel];
    currentEventLabel.anchorPoint = mzp( 1, 0 );
    currentEventLabel.scale = 0.6;
    currentEventLabel.position = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: mzp( 340, 130 )];
}

-(NSString *)_eventNameByIndex:(int)index
{
    if( index >= [eventsDefineDictionary allKeys].count || index < 0 )
        return @"";

    return [[eventsDefineDictionary allKeys] objectAtIndex: index];
}

-(void)_onRemoveCurrentFocusEventFlag:(id)sender
{
    [self removeEventOccurFlag: currentFocusFlagRef];
    currentFocusFlagRef = nil;
    [self _setEventFlagControlWithFlag: currentFocusFlagRef];
}

-(void)_setEventFlagControlWithFlag:(MZEventOccurFlag *)flag
{
    bool controlVisible = ( flag == nil )? false : true;

    currentFocusFlagPositionLabel.visible = controlVisible;
    occurFlagControlMenu.visible = controlVisible;
    
    if( controlVisible == false ) return;
}

-(void)_updateCurrentFocusFlagPositionLabel
{
    if( currentFocusFlagRef == nil ) return;
    currentFocusFlagPositionLabel.string = [NSString stringWithFormat: @"{%0.0f,%0.0f}",
                                            currentFocusFlagRef.editPosition.x, currentFocusFlagRef.editPosition.y];
}

-(void)_setTouchPositionValue:(CGPoint)touchPositionValue
{
    touchPositionLabel.string = [NSString stringWithFormat: @"{%0.0f, %0.0f}", touchPositionValue.x, touchPositionValue.y];
}

-(CCMenuItemLabel *)_createTimeScaleButtonWithScale:(int)timeScale stdPosition:(CGPoint)stdPosition selector:(SEL)selector
{
    CCLabelBMFont *label = [CCLabelBMFont labelWithString: [NSString stringWithFormat: @"x%d", timeScale] fntFile: @"CooperStd.fnt"];
    label.color = ccc3( 169, 0, 176 );
    CCMenuItemLabel *button = [CCMenuItemLabel itemWithLabel: label target: self selector: selector];
    button.tag = timeScale;
    button.scale = 1.5;
    button.position = [[MZCCDisplayHelper sharedInstance] realPositionFromProportionWithStandard: stdPosition];
    
    return button;
}

-(void)_addEventOccurFlagWithEventMetadata:(MZEventMetadata *)eventMetadata
{
    if( eventOccurFlagsArray == nil ) eventOccurFlagsArray = [[NSMutableArray alloc] initWithCapacity: 0];
    
    MZGamePlayBackgroundLayer *bgLayer = (MZGamePlayBackgroundLayer *)[parentSceneRef layerByType: kMZGamePlayLayerType_BackgroundLayer];
    
    MZEventOccurFlag *occurFlag = [MZEventOccurFlag flagWithLevelComponenets: targetLayerRef.levelComponentsRef
                                                               eventMetadata: eventMetadata
                                                                     bgLayer: bgLayer
                                                                     handler: self];
    
    [eventOccurFlagsArray addObject: occurFlag];    
    [occurFlag enable];
}

-(void)_addEventOccurFlagWithStdTouchPosition:(CGPoint)stdTouchPosition
{
    if( currentEventIndex == -1 ) return;
    
    if( eventOccurFlagsArray == nil ) eventOccurFlagsArray = [[NSMutableArray alloc] initWithCapacity: 0];

    MZGamePlayBackgroundLayer *bgLayer = (MZGamePlayBackgroundLayer *)[parentSceneRef layerByType: kMZGamePlayLayerType_BackgroundLayer];
    
    NSString *eventDefineName = [self _eventNameByIndex: currentEventIndex];
    MZEventMetadata *eventMetadata = [MZEventMetadata metadataWithEventDefineName: eventDefineName position: CGPointZero];
    
    MZEventOccurFlag *occurFlag = [MZEventOccurFlag flagWithLevelComponenets: targetLayerRef.levelComponentsRef
                                                               eventMetadata: eventMetadata
                                                                     bgLayer: bgLayer
                                                                     handler: self];
    occurFlag.screenPosition = stdTouchPosition;
    
    [eventOccurFlagsArray addObject: occurFlag];
    [targetLayerRef.levelComponentsRef addEventMetadata: eventMetadata];
    
    [occurFlag enable];
}

-(CGPoint)_standPositionFromTouch:(UITouch *)touch
{
    CGPoint realTouchPos = [targetLayerRef convertTouchToNodeSpace: touch];
    CGPoint resultPos = realTouchPos;

    if( isZoomOut )
    {
        resultPos = mzp( realTouchPos.x*ZOOM_OUT_SCALE_VALUE_FOR_IPAD + bottomLeftForZoomOutOfIPad.x,
                        realTouchPos.y*ZOOM_OUT_SCALE_VALUE_FOR_IPAD + bottomLeftForZoomOutOfIPad.y );
    }

    return CGPointiFromPoint( [[MZCCDisplayHelper sharedInstance] standardPositionFromReal: resultPos] );
}

-(void)_pauseToEditMode
{
    if( isPauseForEdit ) return;
    
    isPauseForEdit = true;
    
    [targetLayerRef.levelComponentsRef.charactersActionManager clearAllWithType: kMZCharacterType_PlayerBullet];
    [targetLayerRef.levelComponentsRef.charactersActionManager clearAllWithType: kMZCharacterType_EnemyBullet];
    [targetLayerRef.levelComponentsRef.charactersActionManager clearAllWithType: kMZCharacterType_Enemy];
    
    [parentSceneRef pause];
    gameTimeLabelRef.color = ccc3( 255, 255, 255 );
}

-(void)_resumeFromEditMode
{
    if( !isPauseForEdit ) return;
    
    isPauseForEdit = false;
    
    [parentSceneRef resume];
    gameTimeLabelRef.color = ccc3( 255, 0, 255 );
}

@end