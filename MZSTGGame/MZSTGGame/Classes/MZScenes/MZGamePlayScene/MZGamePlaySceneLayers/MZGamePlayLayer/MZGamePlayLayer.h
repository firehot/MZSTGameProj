#import "MZGamePlaySceneLayerBase.h"
#import "MZTypeDefine.h"

typedef enum
{
    kMZGamePlayLayerActorType_Player,
    kMZGamePlayLayerActorType_PlayerBullet,
    kMZGamePlayLayerActorType_Enemy,
    kMZGamePlayLayerActorType_EnemyBullet,
    
}MZGamePlayLayerActorType;

@class MZPlayerControlCharacter;
@class MZTouchesControlPlayer;
@class MZLevelComponents;
@class CCDrawNode;

// wew are test
@class MZCCCameraControl;
@class MZCCSpritesPool;

@interface MZGamePlayLayer : MZGamePlaySceneLayerBase
{
    NSDictionary *spritesPoolByActorTypeDictionary;
    
    MZTouchesControlPlayer *touchesControlPlayer;
    CCDrawNode *referenceLines;
    
    // 以下是測試用的
    MZCCCameraControl *cameraControl;
}

-(void)setControlWithPlayer:(MZPlayerControlCharacter *)player;

@property (nonatomic, readonly) NSDictionary *spritesPoolByActorTypeDictionary;

@end


@interface MZGamePlayLayer (Test)
-(void)__test_init;
-(void)__test_init_spritesPool;
-(void)__randomAssignGameObjectWithFrameName:(NSString *)frameName spritesPool:(MZCCSpritesPool *)spritesPool number:(int)number;
@end