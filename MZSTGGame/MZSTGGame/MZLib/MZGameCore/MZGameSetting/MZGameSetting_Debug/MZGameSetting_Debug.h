#import <Foundation/Foundation.h>

@interface MZGameSetting_Debug : NSObject

-(id)initWithNSDictionary:(NSDictionary *)nsDictionary;

@property (nonatomic, readonly) bool showLoadingStates;
@property (nonatomic, readonly) bool showFPS;
@property (nonatomic, readonly) bool showMemoryUsage;
@property (nonatomic, readonly) bool showCharactersNumber;
@property (nonatomic, readonly) bool showCharacterSpawnInfo;
@property (nonatomic, readonly) bool showScenarioInfo;
@property (nonatomic, readonly) bool showEventInfo;
@property (nonatomic, readonly) bool drawCollisionRange;
@property (nonatomic, readonly) bool drawBoundary;
@property (nonatomic, readonly) bool drawBGEventsInfo;

//@property (nonatomic, readonly) bool isDrawPlayer;
//@property (nonatomic, readonly) bool isDrawEnemies;
//@property (nonatomic, readonly) bool isDrawPlayerBullets;
//@property (nonatomic, readonly) bool isDrawEnemyBullets;
//@property (nonatomic, readonly) bool enablePlayerAttack;
//@property (nonatomic, readonly) bool enableEnemyAttack;

@end
