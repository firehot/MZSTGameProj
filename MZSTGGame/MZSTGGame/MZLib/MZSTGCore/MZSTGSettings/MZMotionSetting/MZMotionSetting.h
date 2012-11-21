#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

@interface MZMotionSetting : NSObject
{
@private
    NSDictionary *settingNSDictionary;
}

+(MZMotionSetting *)motionSettingWithNSDictionary:(NSDictionary *)nsDictionary;
-(id)initWithNSDictionary:(NSDictionary *)nsDictionary;
-(NSDictionary *)getOriginalNSDictionary;
-(NSDictionary *)getOriginalNSDictionaryCopy;

@property (nonatomic, readonly) bool isRepeatForever;
@property (nonatomic, readonly) bool isUsingPreviousMovingVector;
@property (nonatomic, readonly) bool isRunOnce;
@property (nonatomic, readonly) bool isAlwaysToTarget;
@property (nonatomic, readonly) bool isReferenceLeader;
@property (nonatomic, readonly) float duration;
@property (nonatomic, readwrite) float initVelocity;
@property (nonatomic, readonly) float acceleration;
@property (nonatomic, readonly) float maxAcceleration;
@property (nonatomic, readonly) float angularVelocity;
@property (nonatomic, readonly) float radians;
@property (nonatomic, readonly) float additionalRadians;
@property (nonatomic, readonly) float theta;
@property (nonatomic, readonly) MZTargetType targetType;
@property (nonatomic, readonly) MZRotatedCenterType rotatedCenterType;
@property (nonatomic, readwrite) CGPoint movingVector;
@property (nonatomic, readonly) CGPoint assignPosition;
@property (nonatomic, readonly) NSString *motionType;
@property (nonatomic, readonly) NSArray *rotatedCenterMotions;

// EllipseRotation
@property (nonatomic, readonly) float ellipseRadiansX;
@property (nonatomic, readonly) float ellipseRadiansY;

// AccelerationXY
@property (nonatomic, readonly) CGPoint accelerationXY;

@end