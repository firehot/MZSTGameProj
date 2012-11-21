#import "MZColor.h"

@implementation MZColor

@synthesize red;
@synthesize green;
@synthesize blue;

+(MZColor *)colorWithRed:(int)aRed green:(int)aGreen blue:(int)aBlue
{
    return [[[self alloc] initWithRed: aRed green: aGreen blue: aBlue] autorelease];
}

-(id)initWithRed:(int)aRed green:(int)aGreen blue:(int)aBlue
{
    if( ( self = [super init] ) )
    {
        red = aRed;
        green = aGreen;
        blue = aBlue;
    }
    
    return self;
}

@end