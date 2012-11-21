#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

typedef struct
{
    double x;
    double y;
    double z;
}MZGyroscopeRotationRateData;

typedef struct
{
    double roll;
    double pitch;
    double yaw;
}MZGyroscopeAttitudeData;

typedef enum 
{
    kMZMotionScenorType_Gyroscope,
    kMZMotionScenorType_Accelerometer,
}MZMotionScenorType;

@interface MZGyroscopeState : NSObject
{
    float accelerometerPrevX;
    float accelerometerPrevY;
    MZMotionScenorType currentUsingDeviceType;
    CMMotionManager *motionManager;
}

-(id)initWithUpdateInterval:(NSTimeInterval)updateInterval;
-(void)startUpdates;
-(void)stopUpdates;
-(MZGyroscopeRotationRateData)getRotationRateData;
-(MZGyroscopeAttitudeData)getAttitudeData;

@property (nonatomic, readonly) bool gyroAvailable;
@property (nonatomic, readonly) bool accelerometerAvailable;
@property (nonatomic, readonly) bool isUpdating;

@end