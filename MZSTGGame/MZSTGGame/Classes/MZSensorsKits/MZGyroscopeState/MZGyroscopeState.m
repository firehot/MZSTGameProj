#import "MZGyroscopeState.h"

#define ACCELEROMETER_TO_GYROSCOPE_FILTER_FACTOR 0.05

@implementation MZGyroscopeState

@synthesize gyroAvailable;
@synthesize accelerometerAvailable;
@synthesize isUpdating;

#pragma matk - init and dealloc

-(id)initWithUpdateInterval:(NSTimeInterval)updateInterval
{
    if( ( self = [super init] ) )
    {
        motionManager = [[CMMotionManager alloc] init];
        motionManager.gyroUpdateInterval = updateInterval;
        motionManager.accelerometerUpdateInterval = updateInterval;
        
        currentUsingDeviceType = ( motionManager.gyroAvailable )? kMZMotionScenorType_Gyroscope : kMZMotionScenorType_Accelerometer;
        
        accelerometerPrevX = 0;
        accelerometerPrevY = 0;
    }
    
    return self;
}

-(void)dealloc
{
    [motionManager release];
    [super dealloc];
}

#pragma mark - properties

-(bool)gyroAvailable
{
    return motionManager.gyroAvailable;
}

-(bool)accelerometerAvailable
{
    return motionManager.accelerometerAvailable;
}

#pragma mark - methods

-(void)startUpdates
{
    if( currentUsingDeviceType == kMZMotionScenorType_Gyroscope )
    {
        [motionManager startGyroUpdates];
    }
    else
    {
        [motionManager startAccelerometerUpdates];
    }
    
    [motionManager startDeviceMotionUpdates];
    isUpdating = true;
}

-(void)stopUpdates
{
    [motionManager stopGyroUpdates];
    [motionManager stopAccelerometerUpdates];
    [motionManager stopDeviceMotionUpdates];
    
    isUpdating = false;
}

-(MZGyroscopeRotationRateData)getRotationRateData
{
    MZGyroscopeRotationRateData rotationRateData;
    CMDeviceMotion *deviceMotion = motionManager.deviceMotion;
    rotationRateData.x = deviceMotion.rotationRate.x;
    rotationRateData.x = deviceMotion.rotationRate.y;
    rotationRateData.x = deviceMotion.rotationRate.z;
    
    return rotationRateData;
}

-(MZGyroscopeAttitudeData)getAttitudeData
{
    MZGyroscopeAttitudeData attitudeData;
    
    if( currentUsingDeviceType == kMZMotionScenorType_Gyroscope )
    {
        CMDeviceMotion *deviceMotion = motionManager.deviceMotion;

        attitudeData.roll = deviceMotion.attitude.roll;
        attitudeData.pitch = deviceMotion.attitude.pitch;
        attitudeData.yaw = deviceMotion.attitude.yaw;
    }
    else if( currentUsingDeviceType == kMZMotionScenorType_Accelerometer )
    {
        CMAccelerometerData *accelerometerData = motionManager.accelerometerData;
        CMAcceleration acceleration = accelerometerData.acceleration;
        
        float filterFactor = ACCELEROMETER_TO_GYROSCOPE_FILTER_FACTOR;
        
        float accelX = (float)acceleration.x*filterFactor + ( 1 - filterFactor )*accelerometerPrevX;
        float accelY = (float)acceleration.y*filterFactor + ( 1 - filterFactor )*accelerometerPrevY;
        
        accelerometerPrevX = accelX;
        accelerometerPrevY = accelY;
        
        attitudeData.roll = accelX;
        attitudeData.pitch = -accelY;
    }
    
    return attitudeData;
}

@end