#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

@class MZGamePlayScene;

@class MZGamePlayLayer;
@class MZCharactersActionManager;
@class MZEventsExecutor;
@class MZScenario;
@class MZPlayerControlCharacter;
@class MZCCSpritesPool;
@class MZEventMetadata;
@class MZEffectsManager;

@interface MZLevelComponents : NSObject
{
    MZGamePlayScene *gamePlaySceneRef;
    NSString *levelName;
}

-(id)initWithLevelSettingDictionary:(NSDictionary *)aLevelSettingDictionary
                          levelName:(NSString *)aLevelName
                      gamePlayScene:(MZGamePlayScene *)aGamePlayScene;
-(void)update;

@property (nonatomic, readonly) MZGamePlayLayer *gamePlayLayer;
@property (nonatomic, readonly) MZCharactersActionManager *charactersActionManager;
@property (nonatomic, readonly) MZEventsExecutor *eventsExecutor;
@property (nonatomic, readonly) MZScenario *scenario; // 暫時用不到 ...
@property (nonatomic, readonly) MZEffectsManager *effectsManager;
@property (nonatomic, readonly) MZPlayerControlCharacter *player;
@property (nonatomic, readonly) MZCCSpritesPool *spritesPool;


-(void)addEventMetadata:(MZEventMetadata *)eventMetadata;
-(void)removeEventMetadata:(MZEventMetadata *)eventMetadata;
-(void)resetEventMeatadatas;
-(void)saveEventMetadata;
@property (nonatomic, readonly) NSDictionary *eventDefinesDictionary;
@property (nonatomic, readonly) NSString *eventsFileName;
@property (nonatomic, readonly) NSMutableArray *eventMetadatasArray;

@end