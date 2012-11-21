#import "MZConvert.h"

@implementation MZConvert

+(NSString *)stringFromBool:(bool)boolValue
{
    return ( boolValue )? @"TRUE": @"FALSE";
}

@end
