#import "MZControl_Base.h"
#import "MZTarget_Base.h"
#import "MZTypeDefine.h"

typedef enum
{
    kMZAttack_OddWay,
}MZAttackClassType;

@protocol MZAttackDelegate <MZControlDelegate>
@property (nonatomic, readonly) MZCharacterType characterType;
@property (nonatomic, readonly) CGPoint standardPosition;
@end

@class MZCharacter;
@class MZCharacterPart;
@class MZBullet;

@interface MZAttack_Base: MZControl_Base <MZTargetDelegate>
{
@private
    int launchCount;
    float currentAdditionalVelocity;
    mzTime colddownCount;
    
@protected
}

+(MZAttack_Base *)createWithClassType:(MZAttackClassType)classType;
+(MZAttack_Base *)attack;

+(NSString *)classStringFromType:(MZAttackClassType)moveClassType;

-(void)reset;

#pragma mark - settings

@property (nonatomic, readwrite, assign) id<MZAttackDelegate> attackDelegate;
@property (nonatomic, readwrite) int numberOfWays;
@property (nonatomic, readwrite) int additionalWaysPerLaunch;
@property (nonatomic, readwrite) int strength;
@property (nonatomic, readwrite) float colddown;
@property (nonatomic, readwrite) float intervalDegrees;
@property (nonatomic, readwrite) float initVelocity;
@property (nonatomic, readwrite) float additionalVelocityPerLaunch;
@property (nonatomic, readwrite) float additionalVelocityLimited;
@property (nonatomic, readwrite) float maxVelocity;
@property (nonatomic, readwrite, retain) NSString *bulletName;
@property (nonatomic, readwrite, retain) MZTarget_Base *target;
//@property (nonatomic, readwrite) MZFaceTo.Type bulletFaceToType = MZFaceTo.Type.MovingVector;

#pragma mark - states

@property (nonatomic, readonly) int launchCount;
@property (nonatomic, readonly) float currentVelocity;
@property (nonatomic, readonly) float currentAdditionalVelocityPerLaunch;

@end

@interface MZAttack_Base(Protected)

-(void)_launchBullets;
-(MZBullet *)_getBullet;
-(void)_addToActionManager:(MZBullet *)bullet;

-(void)_updateAdditionalVelocity;

-(MZCharacterType)_getBulletType;

//-(void)_addMotionSettingToBullet:(MZEventControlCharacter *)bullet;
//-(void)_setBulletLeader:(MZEventControlCharacter *)bulletLeader;
//-(MZEventControlCharacter *)_getCurrentBulletLeader;
//-(NSMutableDictionary *)_getCommonValuesNSDictionary;
@end