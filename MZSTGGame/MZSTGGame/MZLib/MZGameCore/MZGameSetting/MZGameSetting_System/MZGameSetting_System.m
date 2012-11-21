#import "MZGameSetting_System.h"

@implementation MZGameSetting_System

@synthesize isEditMode;
@synthesize fps;
@synthesize texture2DPixelFormat;
@synthesize playRange;

#pragma mark - init and dealloc

-(id)initWithNSDictionary:(NSDictionary *)nsDictionary
{
    if( ( self = [super init] ) )
    {
        fps = [[nsDictionary objectForKey: @"FPS"] intValue];
        texture2DPixelFormat = kCCTexture2DPixelFormat_RGBA8888;
        playRange = CGRectFromString( [nsDictionary objectForKey: @"PlayRange"] );
        
        isEditMode= false;
    }
    
    return self;
}

@end
