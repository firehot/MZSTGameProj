#import "MZAccelerometerState.h"
#import "MZLogMacro.h"

@implementation MZAccelerometerState

@synthesize delegate;
@synthesize available;
@synthesize updateInterval;

#pragma mark - init and dealloc

-(id)initWithMotioManager:(CMMotionManager *)aMotionManager 
                 delegate:(id<MZAccelerometerStateDelegate>)aDelegate
           updateInterval:(NSTimeInterval)aUpdateInterval
{
    if( ( self = [super init] ) )
    {
        delegate = aDelegate;
        
        motionManager = ( aMotionManager )? aMotionManager : [self _getNewMotionManager];
        MZAssert( motionManager, @"motionManager is nil" );
        [motionManager retain];
        
        motionManager.accelerometerUpdateInterval = aUpdateInterval;
        
        if( [delegate respondsToSelector: @selector( accelerometerStateDidInitialize:available: )] )
            [delegate accelerometerStateDidInitialize: self available: motionManager.accelerometerAvailable];
    }

    return self;
}

-(void)dealloc
{
    delegate = nil;
    [motionManager release];
    
    [super dealloc];
}

#pragma mark - properties

-(void)setUpdateInterval:(NSTimeInterval)aUpdateInterval
{
    motionManager.accelerometerUpdateInterval = aUpdateInterval;
}

-(NSTimeInterval)updateInterval
{
    return motionManager.accelerometerUpdateInterval;
}

-(bool)available
{
    return motionManager.accelerometerAvailable;
}

#pragma mark - methods

-(void)startUpdates
{
    [motionManager startAccelerometerUpdates];
}

-(void)stopUpdates
{
    [motionManager stopAccelerometerUpdates];
}

-(MZAccelerationData)getAccelerationData
{
    return motionManager.accelerometerData.acceleration;
}

@end

@implementation MZAccelerometerState (Private)

#pragma mark - methods (private)

-(CMMotionManager *)_getNewMotionManager
{
    return [[[CMMotionManager alloc] init] autorelease];
}

@end