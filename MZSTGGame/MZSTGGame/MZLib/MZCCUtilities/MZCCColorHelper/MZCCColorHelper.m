#import "MZCCColorHelper.h"
#import "MZLogMacro.h"

@implementation MZCCColorHelper

#pragma mark - methods

+(ccColor3B)color3BFromString:(NSString *)color3BString
{
    if( color3BString == nil )
        return ccc3( 255, 255, 255 );
    
    NSRange rangeOfLeftBracket = [color3BString rangeOfString: @"{"];
    NSRange rangeOfRightBracket = [color3BString rangeOfString: @"}" options: NSBackwardsSearch];
    
    NSRange rangeBetweenBrackets;
    rangeBetweenBrackets.location = rangeOfLeftBracket.location + 1;
    rangeBetweenBrackets.length = rangeOfRightBracket.location - rangeOfLeftBracket.location - 1;
    
    NSString *colorNumbersString = [color3BString substringWithRange: rangeBetweenBrackets];
    NSArray *colorStringsArray = [colorNumbersString componentsSeparatedByString: @","];
    
    MZAssert( [colorStringsArray count] == 3, @"colorDefineString is not equal 3" );
    
    int red = [[colorStringsArray objectAtIndex: 0] intValue];
    int green = [[colorStringsArray objectAtIndex: 1] intValue];
    int blue = [[colorStringsArray objectAtIndex: 2] intValue];
    
    return ccc3( red, green, blue );
}

+(NSString *)colorStringFromColor3B:(ccColor3B)color3B
{
    return [NSString stringWithFormat: @"{%d, %d, %d}", color3B.r, color3B.g, color3B.b];
}

@end
