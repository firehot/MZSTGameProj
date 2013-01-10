#import "MZGamePlayLayer_Base.h"
#import "MZTouchesControlPlayer.h"
#import "MZTypeDefine.h"
#import "MZCharactersFactory.h"

typedef enum
{
    kMZGamePlayLayerActorType_Player,
    kMZGamePlayLayerActorType_PlayerBullet,
    kMZGamePlayLayerActorType_Enemy,
    kMZGamePlayLayerActorType_EnemyBullet,
    
}MZGamePlayLayerActorType;

@class CCDrawNode;
@class MZPlayer;
@class MZTouchesControlPlayer;
@class MZCharactersActionManager;
@class MZLevelComponents;

// wew are test
@class MZCCCameraControl;
@class MZCCSpritesPool;

@interface MZGamePlayLayer : MZGamePlayLayer_Base <MZTouchSpaceDelegate, MZSpritesPoolSupport>
{    
    MZTouchesControlPlayer *touchesControlPlayer;
    MZCharactersFactory *charactersFactory;
    CCDrawNode *referenceLines;
    
    // 以下是測試用的
    MZCCCameraControl *cameraControl;
}

-(void)setControlByUserTouchDelegate:(id<MZPlayerTouchDelegate>)touchDelegate;

@property (nonatomic, readonly) MZCharactersFactory *charactersFactory;
@property (nonatomic, readonly) MZCharactersActionManager *charactersActionManager;

@end

@interface MZGamePlayLayer (Test)
-(void)__test_init;
-(void)__test_random_sprites;
-(void)__randomAssignGameObjectWithFrameName:(NSString *)frameName spritesPool:(MZCCSpritesPool *)spritesPool number:(int)number;
-(void)__test_init_player;
-(void)__test_init_enemy;
-(void)__test_update;
-(void)__test_release;
@end

/*
 尚缺 Animation 的資源載入 ...
 */