#import <Foundation/Foundation.h>
#import "ccTypes.h"

@interface MZCCColorHelper : NSObject
+(ccColor3B)color3BFromString:(NSString *)color3BString;
+(NSString *)colorStringFromColor3B:(ccColor3B)color3B;
@end
