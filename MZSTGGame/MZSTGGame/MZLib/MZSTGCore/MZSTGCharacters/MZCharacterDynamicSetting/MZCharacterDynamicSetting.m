#import "MZCharacterDynamicSetting.h"

@implementation MZCharacterDynamicSetting
@synthesize strength;
@synthesize absolutePosition;
@synthesize faceTo;

-(id)init
{
    if( ( self = [super init] ) )
    {
        strength = 0;
        absolutePosition = CGPointZero;
        faceTo = kMZFaceToType_None;
    }
    
    return self;
}

@end
