#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

typedef enum
{
    Idle,
    OddWay,
    EvenWay,
    Vortex,
}MZattackType;

@interface MZAttackSetting : NSObject 
{
    
}

+(MZAttackSetting *)settingWithNSDictionary:(NSDictionary *)nsDictionary;
-(id)initWithNSDictionary:(NSDictionary *)nsDictionary;

@property (nonatomic, readonly) bool isRepeatForever;
@property (nonatomic, readonly) bool isRunOnce;
@property (nonatomic, readonly) bool isAimTargetEveryWave;

@property (nonatomic, readonly) int numberOfWays;
@property (nonatomic, readonly) int additionalWaysPerLaunch;

@property (nonatomic, readonly) int strength;

@property (nonatomic, readonly) float duration;
@property (nonatomic, readonly) float colddownTime;

@property (nonatomic, readonly) float intervalDegree;

@property (nonatomic, readonly) float additionalVelocity;
@property (nonatomic, readonly) float additionalVelocityLimited;

@property (nonatomic, readonly) float additionalDegreePerWaveForLinear;

@property (nonatomic, readonly) MZTargetType targetType;
@property (nonatomic, readonly) MZFaceToType faceTo;

@property (nonatomic, readonly) CGPoint assignPosition;

@property (nonatomic, readonly) MZattackType *attackType;
@property (nonatomic, readonly) NSString *attackTypeString;
@property (nonatomic, readonly) NSString *bulletSettingName;

@property (nonatomic, readonly) NSMutableArray *motionSettingNsDictionariesArray;

// for vortex only
@property (nonatomic, readonly) bool resetAtRest;
@property (nonatomic, readonly) float timePerWave;
@property (nonatomic, readonly) float restTime;

@end