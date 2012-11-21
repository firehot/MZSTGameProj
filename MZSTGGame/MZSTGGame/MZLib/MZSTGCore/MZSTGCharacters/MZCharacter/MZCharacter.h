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

@interface MZCharacter : MZGameObject
{    
    NSMutableArray *modeSettingsQueue;
    MZMode *currentMode;
    MZCharacterSetting *setting;
}

+(MZCharacter *)characterWithLevelComponenets:(MZLevelComponents *)aLevelComponents;
-(void)setSetting:(MZCharacterSetting *)aSetting characterType:(MZCharacterType)aCharacterType;
-(void)applyDynamicSetting;
-(void)setSpawnWithParentCharacter:(MZCharacter *)aParentCharacter spawnPosition:(CGPoint)aSpawnPosition;
-(void)setSpawnWithaParentCharacterPart:(MZCharacterPart *)aParentCharacterPart spawnPosition:(CGPoint)aSpawnPosition;
-(bool)isCollisionWithOtherCharacter:(MZCharacter *)otherCharacter;
-(void)addMotionSetting:(MZMotionSetting *)motionSetting modeName:(NSString *)modeName;
-(MZMotionSetting *)getMotionSettingWithIndex:(int)index;

@property (nonatomic, readonly) bool isUsingDynamicSetting;
@property (nonatomic, readwrite) bool isLeader;
@property (nonatomic, readwrite) bool disableAttack;
@property (nonatomic, readwrite) int currentHealthPoint;
@property (nonatomic, readwrite) MZCharacterType characterType;
@property (nonatomic, readonly) MZCharacterDynamicSetting *characterDynamicSetting;
@property (nonatomic, readonly) MZCharacter *spawnParentCharacterRef;
@property (nonatomic, readwrite, assign) MZCharacter *leaderCharacterRef;
@property (nonatomic, readonly) MZCharacterPart *spawnParentCharacterPartRef;

@end