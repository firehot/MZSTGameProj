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
@class MZCharacterPart;
@class MZCharacter;

@interface MZGamePlayLayer : MZGamePlaySceneLayerBase
{    
    MZTouchesControlPlayer *touchesControlPlayer;
    CCDrawNode *referenceLines;
    
    // 以下是測試用的
    MZCCCameraControl *cameraControl;
    MZCharacterPart *part;
    MZCharacter *testCharacter;
}

-(void)setControlWithPlayer:(MZPlayerControlCharacter *)player;

@end


@interface MZGamePlayLayer (Test)
-(void)__test_init;
-(void)__test_init_spritesPool;
-(void)__test_random_sprites;
-(void)__randomAssignGameObjectWithFrameName:(NSString *)frameName spritesPool:(MZCCSpritesPool *)spritesPool number:(int)number;
-(void)__test_characterPart;
-(void)__test_character;
-(void)__test_release;
@end