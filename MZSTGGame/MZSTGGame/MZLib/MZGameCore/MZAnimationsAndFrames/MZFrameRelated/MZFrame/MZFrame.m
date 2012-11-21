#import "MZFrame.h"
#import "MZUtilitiesHeader.h"

@implementation MZFrame

@synthesize frameSize;
@synthesize frameName;
@synthesize frame;

#pragma mark - init and dealloc

+(MZFrame *)frameControlWithFrameName:(NSString *)aFrameName
{
    return [[[self alloc] initWithWithFrameName: aFrameName] autorelease];
}

-(id)initWithWithFrameName:(NSString *)aFrameName
{
    if( ( self = [super init] ) )
    {
        MZAssert( aFrameName, @"frameName is nil" );
        frameName = [aFrameName retain];
        
        frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: frameName];
        MZAssert( frame, @"frame is nil" );
        
        [frame retain];        
        frameSize = frame.originalSizeInPixels;
    }
    
    return self;
}

-(void)dealloc
{
    [frameName release];
    [frame release];
    [super dealloc];
}

@end
