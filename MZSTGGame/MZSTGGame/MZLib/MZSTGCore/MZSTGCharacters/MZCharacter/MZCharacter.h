#import "MZGameObject.h"
#import "MZTypeDefine.h"
#import "MZCharacterTypeStrings.h"

@class MZCharacterPart;
@class MZMotion_Base;
@class MZCharacterSetting;
@class MZMotionSetting;
@class MZColor;
@class MZMode;
@class MZCharacterDynamicSetting;
@class MZCCSpritesPool;

@interface MZCharacter : MZGameObject
{    
    NSMutableArray *modeSettingsQueue;
    NSMutableDictionary *partsDictionary;
    MZMode *currentMode;
    MZCharacterSetting *setting;
}

+(MZCharacter *)character;
-(MZCharacterPart *)addPartWithName:(NSString *)aName;

// 以下未動刀 wwww
-(void)setSetting:(MZCharacterSetting *)aSetting characterType:(MZCharacterType)aCharacterType; // delete
-(void)applyDynamicSetting;
-(void)setSpawnWithParentCharacter:(MZCharacter *)aParentCharacter spawnPosition:(CGPoint)aSpawnPosition;
-(void)setSpawnWithaParentCharacterPart:(MZCharacterPart *)aParentCharacterPart spawnPosition:(CGPoint)aSpawnPosition;
-(bool)isCollisionWithOtherCharacter:(MZCharacter *)otherCharacter;

-(void)addMotionSetting:(MZMotionSetting *)motionSetting modeName:(NSString *)modeName;
-(MZMotionSetting *)getMotionSettingWithIndex:(int)index;

@property (nonatomic, readwrite) MZCharacterType characterType;
@property (nonatomic, readwrite, assign) MZCCSpritesPool *partSpritesPoolRef;

// no good 分隔線
@property (nonatomic, readonly) bool isUsingDynamicSetting;
@property (nonatomic, readwrite) bool isLeader;
@property (nonatomic, readwrite) bool disableAttack;
@property (nonatomic, readwrite) int currentHealthPoint;
@property (nonatomic, readwrite, retain) MZCharacterSetting *setting;
@property (nonatomic, readonly) MZCharacterDynamicSetting *characterDynamicSetting;
@property (nonatomic, readonly) MZCharacter *spawnParentCharacterRef;
@property (nonatomic, readwrite, assign) MZCharacter *leaderCharacterRef;
@property (nonatomic, readonly) MZCharacterPart *spawnParentCharacterPartRef;

@end


/*
 AddPart
 */