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

@property (nonatomic, readwrite) bool isRepeatForever;
@property (nonatomic, readwrite) bool isRunOnce;
@property (nonatomic, readwrite) bool isAimTargetEveryWave;

@property (nonatomic, readwrite) int numberOfWays;
@property (nonatomic, readwrite) int additionalWaysPerLaunch;

@property (nonatomic, readwrite) int strength;

@property (nonatomic, readwrite) float duration;
@property (nonatomic, readwrite) float colddownTime;

@property (nonatomic, readwrite) float intervalDegree;

@property (nonatomic, readwrite) float additionalVelocity;
@property (nonatomic, readwrite) float additionalVelocityLimited;

@property (nonatomic, readwrite) float additionalDegreePerWaveForLinear;

@property (nonatomic, readwrite) MZTargetType targetType;
@property (nonatomic, readwrite) MZFaceToType faceTo;

@property (nonatomic, readwrite) CGPoint assignPosition;

@property (nonatomic, readwrite) MZattackType *attackType;
@property (nonatomic, retain, readwrite) NSString *attackTypeString;
@property (nonatomic, retain, readwrite) NSString *bulletSettingName;

@property (nonatomic, retain, readwrite) NSMutableArray *motionSettingNsDictionariesArray;

// for vortex only
@property (nonatomic, readwrite) bool resetAtRest;
@property (nonatomic, readwrite) float timePerWave;
@property (nonatomic, readwrite) float restTime;

@end