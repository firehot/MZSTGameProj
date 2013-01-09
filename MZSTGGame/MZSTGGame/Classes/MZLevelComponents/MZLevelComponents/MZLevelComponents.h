#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

@class MZGamePlayScene;

@class MZGamePlayLayer;
@class MZCharactersActionManager;
@class MZEventsExecutor;
@class MZScenario;
@class MZPlayer;
@class MZEventMetadata;
@class MZEffectsManager;

@interface MZLevelComponents : NSObject
{
    MZGamePlayScene *gamePlaySceneRef;
    NSString *levelName;
}

+(MZLevelComponents *)sharedInstance;

-(void)setLevelWithName:(NSString *)aName settingDictionary:(NSDictionary *)aSettingDictionary playScene:(MZGamePlayScene *)aPlayScene;
-(void)removeFromLevel;
-(void)update;

@property (nonatomic, readwrite, assign) MZGamePlayLayer *gamePlayLayer;
@property (nonatomic, readonly) MZCharactersActionManager *charactersActionManager; // will Ref or return gamePlayLayer directly
@property (nonatomic, readonly) MZEventsExecutor *eventsExecutor;
@property (nonatomic, readonly) MZScenario *scenario; // 暫時用不到 ...
@property (nonatomic, readonly) MZEffectsManager *effectsManager; // 暫時用不到 ...
@property (nonatomic, readonly) MZPlayer *player;

-(void)addEventMetadata:(MZEventMetadata *)eventMetadata;
-(void)removeEventMetadata:(MZEventMetadata *)eventMetadata;
-(void)resetEventMeatadatas;
-(void)saveEventMetadata;
@property (nonatomic, readonly) NSDictionary *eventDefinesDictionary;
@property (nonatomic, readonly) NSString *eventsFileName;
@property (nonatomic, readonly) NSMutableArray *eventMetadatasArray;

@end