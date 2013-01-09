#import "MZLevelComponentsHeader.h"
#import "MZObjectHelper.h"
#import "MZGamePlayScene.h"
#import "MZUtilitiesHeader.h"
#import "MZCharactersFactory.h"
#import "MZAttacksFactory.h"
#import "MZEventsFactory.h"
#import "MZGameSettingsHeader.h"
#import "MZEventMetadata.h"
#import "MZEffectHeader.h"

static MZLevelComponents *_sharedLevelComponents = nil;

@interface MZLevelComponents (Private)
-(void)_initMemberComponentsWithLevelSettingDictionary:(NSDictionary *)levelSettingDictionary;
-(void)_initEventsMetadatasArray;
-(void)_initEffectManager;

-(void)_updateGame;
@end

#pragma mark

@implementation MZLevelComponents

@synthesize gamePlayLayer;
@synthesize charactersActionManager;
@synthesize eventsExecutor;
@synthesize scenario;
@synthesize effectsManager;
@synthesize player;
@synthesize eventDefinesDictionary;
@synthesize eventsFileName;
@synthesize eventMetadatasArray;

#pragma mark - init and deallc

+(MZLevelComponents *)sharedInstance
{
    if( _sharedLevelComponents == NULL )
        _sharedLevelComponents = [[self alloc] init];

    return _sharedLevelComponents;
}

-(id)init
{
    MZAssert( _sharedLevelComponents == NULL, @"I am Singtelon!!!!");
    self = [super init];
    return self;
}

-(void)dealloc
{
    [_sharedLevelComponents release];
    _sharedLevelComponents = nil;
    
    [super dealloc];
}

#pragma mark - properties

-(NSString *)eventsFileName
{
    return [NSString stringWithFormat: @"%@_bgevents.plist", levelName];
}

#pragma mark - methods

-(void)setLevelWithName:(NSString *)aName settingDictionary:(NSDictionary *)aSettingDictionary playScene:(MZGamePlayScene *)aPlayScene
{
    MZAssert( aSettingDictionary, @"aLevelSettingDictionary is nil" );
    MZAssert( aPlayScene, @"aPlayScene is nil" );
    MZAssert( aName, @"aLevelName is nil" );

    gamePlaySceneRef = aPlayScene;
    levelName = [aName retain];

    [self _initMemberComponentsWithLevelSettingDictionary: aSettingDictionary];
}

-(void)removeFromLevel
{
    [MZObjectHelper releaseAndSetNilToObject: &eventMetadatasArray];
    [MZObjectHelper releaseAndSetNilToObject: &eventsExecutor];
    [MZObjectHelper releaseAndSetNilToObject: &scenario];
    [MZObjectHelper releaseAndSetNilToObject: &effectsManager];
    [MZObjectHelper releaseAndSetNilToObject: &levelName];
    [MZObjectHelper releaseAndSetNilToObject: &eventDefinesDictionary];

    player = nil;
    charactersActionManager = nil;
    gamePlaySceneRef = nil;
}

-(void)update
{
    [self _updateGame];
}

-(void)addEventMetadata:(MZEventMetadata *)eventMetadata
{
    if( eventMetadatasArray == nil ) eventMetadatasArray = [[NSMutableArray alloc] initWithCapacity: 1];
    [eventMetadatasArray addObject: eventMetadata];
}

-(void)removeEventMetadata:(MZEventMetadata *)eventMetadata
{
    if( eventMetadatasArray == nil && [eventMetadatasArray count] == 0 ) return;
    [eventMetadatasArray removeObject: eventMetadata];
}

-(void)resetEventMeatadatas
{
    for( MZEventMetadata *metadata in eventMetadatasArray )
        metadata.hasExecuted = false;
}

-(void)saveEventMetadata
{
    NSMutableArray *metadatasArray = [NSMutableArray arrayWithCapacity: 1];
    for( MZEventMetadata *metadata in eventMetadatasArray )
    {
        NSDictionary *dataDic = @{
        @"eventDefineName" : metadata.eventDefineName,
        @"position": NSStringFromCGPoint( metadata.position ) };

        [metadatasArray addObject: dataDic];
    }

    NSDictionary *plistContent = [NSDictionary dictionaryWithObjectsAndKeys: metadatasArray, @"eventMetadatas", nil];
    bool saveState = [MZFileHelper saveFile: plistContent toDocumentsWithName: self.eventsFileName removeExist: true];

    MZAssert( saveState, @"!???!?!?!?!?" );
    
    NSString *alertTitle = nil;
    NSString *alertMessage = nil;
    
    if( saveState )
    {
        alertTitle = @"Save Success";
        alertMessage = [NSString stringWithFormat: @"Save to file: %@ Success ^_^(b", self.eventsFileName];
    }
    else
    {
        alertTitle = @"Save Fail";
        alertMessage = [NSString stringWithFormat: @"Save to file: %@ Fail >_<", self.eventsFileName];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: alertTitle
                                                    message: alertMessage
                                                   delegate: nil
                                          cancelButtonTitle: @"ok"
                                          otherButtonTitles: nil, nil];
    [alert show];
    [alert release];
}

@end

#pragma mark

@implementation MZLevelComponents (Private)

#pragma mark - methods

-(void)_initMemberComponentsWithLevelSettingDictionary:(NSDictionary *)levelSettingDictionary
{    
    [self _initEventsMetadatasArray];
    
    eventsExecutor = [[MZEventsExecutor alloc] init];
    
    eventDefinesDictionary = [[levelSettingDictionary objectForKey: @"eventsDefine"] retain];
    
    scenario = [[MZScenario alloc] init];
    [scenario setEventsWithNSArray: [levelSettingDictionary objectForKey: @"scenarios"]];
}

-(void)_initEventsMetadatasArray
{
    if( eventMetadatasArray == nil ) eventMetadatasArray = [[NSMutableArray alloc] initWithCapacity: 1];
    
    NSDictionary *bgEvMetadatasPlist = nil;

    if( [MZGameSetting sharedInstance].system.isEditMode )
        bgEvMetadatasPlist = [MZFileHelper plistContentFromHomeDocumentsWithName: self.eventsFileName];
    
    if( bgEvMetadatasPlist == nil )
        bgEvMetadatasPlist = [MZFileHelper plistContentFromBundleWithName: self.eventsFileName];
    
    if( bgEvMetadatasPlist == nil ) return;
    NSArray *eventMeatadataArray = [bgEvMetadatasPlist objectForKey: @"eventMetadatas"];
    
    for( NSDictionary *metadataDictionary in eventMeatadataArray )
    {
        MZEventMetadata *metadata = [MZEventMetadata metadataWithDictionary: metadataDictionary];
        [eventMetadatasArray addObject: metadata];
    }
}

-(void)_initEffectManager
{
    effectsManager = [[MZEffectsManager alloc] init];
}

-(void)_updateGame
{
    [scenario update];
    [eventsExecutor update];
}

@end