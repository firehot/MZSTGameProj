#import <Foundation/Foundation.h>
#import "MZCharacterTypeStrings.h"

@class MZCCSpritesPool;
// 以下 ... 呃
@class MZLevelComponents;
@class MZCharacter;
@class MZCharacterSetting;
@class MZEventControlCharacter;
@class MZColor;

// test
@class MZPlayer;
@class MZEnemy;
@class MZBullet;

@protocol MZSpritesPoolSupport <NSObject>
-(MZCCSpritesPool *)spritesPoolByCharacterType:(MZCharacterType)characterType;
@end

@interface MZCharactersFactory : NSObject 
{
    id<MZSpritesPoolSupport> spritesPoolSupportRef;

    // 以下是即將完蛋的清單
    NSMutableDictionary *playerControlCharactersSettingDictionary;
    NSMutableDictionary *enemiesSettingDictionary;
    NSMutableDictionary *bulletsSettingDictionary;
}

-(id)initWithSpritePoolSupport:(id<MZSpritesPoolSupport>)aSpritesPoolSupport;

-(MZCharacter *)getByType:(MZCharacterType)type name:(NSString *)name;

@end

@interface MZCharactersFactory (Test)
-(MZPlayer *)__test_player;
-(MZEnemy *)__test_enemy;
-(MZBullet *)__test_enemy_bullet;
@end