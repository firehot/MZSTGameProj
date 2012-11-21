#import <Foundation/Foundation.h>

@interface MZMemoryUsage : NSObject
+(double)getAvailableBytes;
+(double)getAvailableKiloBytes;
+(double)getAvailableMegaBytes;
@end
