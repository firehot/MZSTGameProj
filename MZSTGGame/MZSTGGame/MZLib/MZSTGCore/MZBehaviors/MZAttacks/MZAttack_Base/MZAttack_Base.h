#import "MZControl_Base.h"
#import "MZTypeDefine.h"

@class MZAttackSetting;
@class MZCharacter;
@class MZCharacterPart;
@class MZEventControlCharacter;
@class MZAttackTargetHelpKit;
@class MZLevelComponents;

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
}

+(MZAttack_Base*)attackWithAttackSetting:(MZAttackSetting *)aSetting
                         levelComponents:(MZLevelComponents *)aLevelComponents
                           controlTarget:(MZGameObject *)aControlTarget;
-(id)initWithAttackSetting:(MZAttackSetting *)aSetting
           levelComponents:(MZLevelComponents *)aLevelComponents
             controlTarget:(MZGameObject *)aControlTarget;
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