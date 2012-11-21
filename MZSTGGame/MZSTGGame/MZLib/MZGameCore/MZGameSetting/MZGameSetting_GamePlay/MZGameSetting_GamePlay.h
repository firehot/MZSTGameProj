#import <Foundation/Foundation.h>

@interface MZGameSetting_GamePlay : NSObject

-(id)initWithNSDictionary:(NSDictionary *)nsDictionary;

@property (nonatomic, readonly) int zIndexOfPlayer;
@property (nonatomic, readonly) int zIndexOfPlayerBullets;
@property (nonatomic, readonly) int zIndexOfEnemies;
@property (nonatomic, readonly) int zIndexOfEnemyBullets;
@property (nonatomic, readonly) int zIndexOfUI;
@property (nonatomic, readonly) int zIndexOfEffects;
@property (nonatomic, readonly) int zIndexOfBackground;
@property (nonatomic, readonly) int zIndexOfBackgroundEffects;
@property (nonatomic, readonly) int zIndexOfDebugInfo;
@property (nonatomic, readonly) int zIndexOfRewardItems;
@property (nonatomic, readonly) int zIndexOfHUDs;
@property (nonatomic, readonly) CGRect playerBoundary;
@property (nonatomic, readonly) CGRect realPlayerBoundary;
@property (nonatomic, readonly) CGRect enrageRect;
@property (nonatomic, readonly) NSArray *levels;
@property (nonatomic, readonly) NSDictionary *enrageRangeRectStringsDictionary;

@end
