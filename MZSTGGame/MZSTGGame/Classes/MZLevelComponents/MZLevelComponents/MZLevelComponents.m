#import "MZLevelComponentsHeader.h"
#import "MZObjectHelper.h"
#import "MZGamePlayScene.h"
#import "MZUtilitiesHeader.h"
#import "MZCharactersFactory.h"
#import "MZAttacksFactory.h"
#import "MZMotionsFactory.h"
#import "MZEventsFactory.h"
#import "MZGameSettingsHeader.h"
#import "MZEventMetadata.h"
#import "MZEffectHeader.h"

@interface MZLevelComponents (Private)
-(void)_initMemberComponentsWithLevelSettingDictionary:(NSDictionary *)levelSettingDictionary;
-(void)_initEventsMetadatasArray;
-(void)_setSelfToFactories;
-(void)_initSpritePool;
-(void)_initEffectManager;
-(void)_initPlayer;

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
@synthesize spritesPool;
@synthesize eventDefinesDictionary;
@synthesize eventsFileName;
@synthesize eventMetadatasArray;

#pragma mark - init and deallc

-(id)initWithLevelSettingDictionary:(NSDictionary *)aLevelSettingDictionary
                          levelName:(NSString *)aLevelName
                      gamePlayScene:(MZGamePlayScene *)aGamePlayScene
{
    MZAssert( aLevelSettingDictionary, @"aLevelSettingDictionary is nil" );
    MZAssert( aGamePlayScene, @"aGamePlayScene is nil" );
    MZAssert( aLevelName, @"aLevelName is nil" );
    
    self = [super init];
    
    gamePlaySceneRef = aGamePlayScene;
    levelName = [aLevelName retain];
    
    [self _initMemberComponentsWithLevelSettingDictionary: aLevelSettingDictionary];
    
    return self;
}

-(void)dealloc
{
    [[MZCharactersFactory sharedCharactersFactory] removeFromLevel];

    [eventMetadatasArray release];
    [charactersActionManager release];
    [eventsExecutor release];
    [scenario release];
    [effectsManager release];
    [player release];
    [levelName release];
    [spritesPool release];
    [eventDefinesDictionary release];
    
    gamePlaySceneRef = nil;
    [super dealloc];
}

#pragma mark - properties

-(MZGamePlayLayer *)gamePlayLayer
{
    return (MZGamePlayLayer *)[gamePlaySceneRef layerByType: kMZGamePlayLayerType_PlayLayer];
}

-(NSString *)eventsFileName
{
    return [NSString stringWithFormat: @"%@_bgevents.plist", levelName];
}

#pragma mark - methods

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
    [self _setSelfToFactories];
    
    [self _initEventsMetadatasArray];
    [self _initSpritePool];
    [self _initPlayer];
    
    charactersActionManager = [[MZCharactersActionManager alloc] initWithLevelComponents: self];
    
    eventsExecutor = [[MZEventsExecutor alloc] initWithLevelComponents: self];
    
    eventDefinesDictionary = [[levelSettingDictionary objectForKey: @"eventsDefine"] retain];
    
    scenario = [[MZScenario alloc] initWithLevelComponents: self];
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

-(void)_setSelfToFactories
{
    [[MZCharactersFactory sharedCharactersFactory] setOnLevelWithComponemts: self];
    [[MZAttacksFactory sharedInstance] setOnLevelWithComponemts: self];
    [[MZMotionsFactory sharedMZMotionsFactory] setOnLevelWithComponemts: self];
    [[MZEventsFactory sharedEventsFactory] setOnLevelWithComponemts: self];
}

-(void)_initSpritePool
{
    NSDictionary *batchNodeSettingsDictionary =
    [NSDictionary dictionaryWithObjectsAndKeys:
     [MZCCSpritesPool __testBatchNodeSettingWithNumber: 10 textureName: @"ColorRect4x4_White.png"  usingBlend: false],
     [NSNumber numberWithInt: kMZCharacterType_None],
     
     [MZCCSpritesPool __testBatchNodeSettingWithNumber: 10 textureName: @"player_male.pvr.ccz" usingBlend: false],
     [NSNumber numberWithInt: kMZCharacterType_Player],
     
     [MZCCSpritesPool __testBatchNodeSettingWithNumber: 100 textureName: @"[test]enemies_atlas.png" usingBlend: false],
     [NSNumber numberWithInt: kMZCharacterType_Enemy],
     
     [MZCCSpritesPool __testBatchNodeSettingWithNumber: 100 textureName: @"explosion.png" usingBlend: true],
     [NSNumber numberWithInt: kMZCharacterType_Effect],
     
     [MZCCSpritesPool __testBatchNodeSettingWithNumber: 500 textureName: @"[test]bullets_atlas.png" usingBlend: true],
     [NSNumber numberWithInt: kMZCharacterType_PlayerBullet],
     
     [MZCCSpritesPool __testBatchNodeSettingWithNumber: 500 textureName: @"[test]bullets_atlas.png" usingBlend: false],
     [NSNumber numberWithInt: kMZCharacterType_EnemyBullet],
     
     [MZCCSpritesPool __testBatchNodeSettingWithNumber: 100 textureName: @"TestPic.png" usingBlend: false],
     [NSNumber numberWithInt: kMZCharacterType_EventFlag],
     
     nil];
    
    NSArray *addOrder = [NSArray arrayWithObjects:
                         [NSNumber numberWithInt: kMZCharacterType_None],
                         [NSNumber numberWithInt: kMZCharacterType_Enemy],
                         [NSNumber numberWithInt: kMZCharacterType_Player],
                         [NSNumber numberWithInt: kMZCharacterType_Effect],
                         [NSNumber numberWithInt: kMZCharacterType_PlayerBullet],
                         [NSNumber numberWithInt: kMZCharacterType_EnemyBullet],
                         [NSNumber numberWithInt: kMZCharacterType_EventFlag],
                         nil];
    
    NSDictionary *poolSettingDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                           batchNodeSettingsDictionary, @"BatchNodeSetting",
                                           addOrder, @"AddOrder",
                                           nil];
    
    spritesPool = [[MZCCSpritesPool alloc] initWithPoolSettingDictionary: poolSettingDictionary layer: self.gamePlayLayer];
}

-(void)_initEffectManager
{
    effectsManager = [[MZEffectsManager alloc] init];
}

-(void)_initPlayer
{
    player = (MZPlayerControlCharacter *)
    [[MZCharactersFactory sharedCharactersFactory] getCharacterByType: kMZCharacterType_Player
                                                          settingName: @"PlayerOne"];
    player.position = CGPointMake( 160, 70 );
    [player retain];
    [player enable];
}

-(void)_updateGame
{
    [scenario update];
    [eventsExecutor update];
    [charactersActionManager update];
}

@end