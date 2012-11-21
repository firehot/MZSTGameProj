#import "MZTime.h"

@implementation MZTime

@synthesize deltaTime;
@synthesize totalTime;

#pragma mark - init and deallc

MZTime *sharedTime_ = nil;

+(MZTime *)sharedInstance
{
    if( sharedTime_ == nil )
    {
        sharedTime_ = [[MZTime alloc] init];
        [sharedTime_ reset];
    }
    
    return sharedTime_;
}

-(void)dealloc
{
    [sharedTime_ release];
    sharedTime_ = nil;
    
    [super dealloc];
}

#pragma mark - methods

-(void)reset
{
    deltaTime = 0;
    totalTime = 0;
}

-(void)forward:(float)forwardTime
{
    totalTime += forwardTime;
}

-(void)back:(float)backTime
{
    totalTime = ( totalTime - backTime <= 0 )? 0 : totalTime - backTime;
}

-(void)updateWithDeltaTime:(mzTime)aDeltaTime
{
    deltaTime = aDeltaTime;
    totalTime += deltaTime;
}

@end
