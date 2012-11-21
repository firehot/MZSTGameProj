#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

//typedef float mzTime;
//typedef double mzTime;

@interface MZTime : NSObject

+(MZTime *)sharedInstance;

-(void)reset;
-(void)forward:(float)forwardTime;
-(void)back:(float)backTime;

-(void)updateWithDeltaTime:(mzTime)aDeltaTime;

@property (nonatomic, readonly) mzTime deltaTime;
@property (nonatomic, readonly) mzTime totalTime;

@end
