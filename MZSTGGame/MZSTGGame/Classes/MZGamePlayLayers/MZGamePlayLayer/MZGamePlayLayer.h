#import "MZGamePlayLayer_Base.h"
#import "MZTouchesControlPlayer.h"
#import "MZTypeDefine.h"

typedef enum
{
    kMZGamePlayLayerActorType_Player,
    kMZGamePlayLayerActorType_PlayerBullet,
    kMZGamePlayLayerActorType_Enemy,
    kMZGamePlayLayerActorType_EnemyBullet,
    
}MZGamePlayLayerActorType;

@class MZPlayer;
@class MZTouchesControlPlayer;
@class MZLevelComponents;
@class CCDrawNode;

// wew are test
@class MZCCCameraControl;
@class MZCCSpritesPool;
@class MZCharacterPart;
@class MZCharacter;
@class MZPlayer;
@class MZEnemy;

@interface MZGamePlayLayer : MZGamePlayLayer_Base <MZTouchSpaceDelegate>
{    
    MZTouchesControlPlayer *touchesControlPlayer;
    CCDrawNode *referenceLines;
    
    // 以下是測試用的
    MZCCCameraControl *cameraControl;
    MZCharacterPart *part;
    MZCharacter *testCharacter;
    MZPlayer *testPlayer;
    MZEnemy *testEnemy;
}

-(void)setControlWithPlayer:(MZPlayer *)player;

@end


@interface MZGamePlayLayer (Test)
-(void)__test_init;
-(void)__test_random_sprites;
-(void)__randomAssignGameObjectWithFrameName:(NSString *)frameName spritesPool:(MZCCSpritesPool *)spritesPool number:(int)number;
-(void)__test_characterPart;
-(void)__test_character;
-(void)__test_init_player;
-(void)__test_init_enemy;
-(void)__test_update;
-(void)__test_release;
@end