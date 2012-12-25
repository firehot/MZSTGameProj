#import "MZControl_Base.h"
#import "MZTypeDefine.h"

@protocol MZAttackDelegate <MZControlDelegate>
@property (nonatomic, readonly) MZCharacterType characterType;
@property (nonatomic, readonly) CGPoint standardPosition;
@end

@class MZAttackSetting;
@class MZCharacter;
@class MZCharacterPart;
@class MZEventControlCharacter;
@class MZAttackTargetHelpKit;

@interface MZAttack_Base: MZControl_Base
{
@private
    MZEventControlCharacter *currentBulletLeaderRef;
@protected
    int launchCount;
    float currentAdditionalVelocity;
    mzTime colddownCount;
    MZAttackSetting *setting;
    MZAttackTargetHelpKit *attackTargetHelpKit;

    id<MZAttackDelegate> attackDelegate;
}

+(MZAttack_Base*)attackWithDelegate:(id<MZAttackDelegate>)aControlDelegate setting:(MZAttackSetting *)aSetting;
-(id)initWithDelegate:(id<MZAttackDelegate>)aControlDelegate setting:(MZAttackSetting *)aSetting;

@end

@interface MZAttack_Base(Protected)
-(void)_launchBullets;

-(void)_addMotionSettingToBullet:(MZEventControlCharacter *)bullet;

-(void)_updateAdditionalVelocity;

-(void)_enableBulletAndAddToActionManager:(MZEventControlCharacter *)bullet;

-(void)_setBulletLeader:(MZEventControlCharacter *)bulletLeader;

-(MZEventControlCharacter *)_getCurrentBulletLeader;
-(MZCharacterType)_getBulletType;
-(NSMutableDictionary *)_getCommonValuesNSDictionary;
-(MZEventControlCharacter *)_getBullet;
@end