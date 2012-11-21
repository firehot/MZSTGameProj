#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

#define MZAccelerationData CMAcceleration

@class MZAccelerometerState;

@protocol MZAccelerometerStateDelegate <NSObject>
@optional
-(void)accelerometerStateDidInitialize:(MZAccelerometerState *)accelerometerState available:(bool)available;
@end

@interface MZAccelerometerState : NSObject
{
    CMMotionManager *motionManager;
}

-(id)initWithMotioManager:(CMMotionManager *)aMotionManager 
                 delegate:(id<MZAccelerometerStateDelegate>)aDelegate
           updateInterval:(NSTimeInterval)aUpdateInterval;
-(void)startUpdates;
-(void)stopUpdates;
-(MZAccelerationData)getAccelerationData;

@property (nonatomic, assign) id<MZAccelerometerStateDelegate> delegate;
@property (nonatomic, readonly) bool available;
@property (nonatomic, readwrite) NSTimeInterval updateInterval;

@end

@interface MZAccelerometerState (Private)
-(CMMotionManager *)_getNewMotionManager;
@end