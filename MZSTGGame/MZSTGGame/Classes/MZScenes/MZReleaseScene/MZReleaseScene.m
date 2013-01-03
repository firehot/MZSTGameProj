#import "MZReleaseScene.h"
#import "MZUtilitiesHeader.h"
#import "MZFramesManager.h"
#import "MZAnimationsManager.h"
#import "MZScenesFactory.h"
#import "MZGameSettingsHeader.h"
#import "MZLogMacro.h"
#import "cocos2d.h"

@implementation MZReleaseScene

-(id)init
{
    self = [super init];
    if( self == nil ) return nil;
    
    [self addChild: [MZReleaseLayer node]];
    
    return self;
}

@end

#pragma mark

@interface MZReleaseLayer (Private)
-(void)_gotoLoadingScene:(mzTime)dt;
@end

@implementation MZReleaseLayer

#pragma mark - init and dealloc

-(id)init
{
    if( (self = [super init] ) )
    {
        if( ( self = [super init] ) )
        {        
            MZLog( @"" );
            [self schedule: @selector( _gotoLoadingScene: )];
        }
        
        return self;
    }
    
    return self;
}

-(void)dealloc
{
    [super dealloc];
}

@end

#pragma mark

@implementation MZReleaseLayer (Private)

#pragma mark - methods

-(void)_gotoLoadingScene:(mzTime)dt
{
	[self unschedule: @selector( _gotoLoadingScene: )];
    [NSThread sleepForTimeInterval: 0.2f];
    float memUsagePreAllRemove = [MZMemoryUsage getAvailableMegaBytes];
    
    if( [MZGameSetting sharedInstance].debug.showMemoryUsage )
        MZLog( @"MemUsage: %0.2fMB(pre-release)", memUsagePreAllRemove );
    
    [[MZAnimationsManager sharedInstance] releaseAllAnimations];
//    [[MZFramesManager sharedInstance] releaseAllFrames]; // need test ... 
	[CCLabelBMFont purgeCachedData];
    [[CCTextureCache sharedTextureCache] removeAllTextures];    
    [[CCTextureCache sharedTextureCache] dumpCachedTextureInfo];
    
    if( [MZGameSetting sharedInstance].debug.showMemoryUsage )
    {
        float memUsageAfterAllRemove = [MZMemoryUsage getAvailableMegaBytes];
        
        MZLog( @"MemUsage: %0.2fMB(after-release)", memUsageAfterAllRemove );
        
        float totalRelease = memUsageAfterAllRemove-memUsagePreAllRemove;
        MZLog( @"Total release: %0.2fMB", totalRelease );
    }
    
    MZLog( @"Go to Loading scene" );
    
    [[CCDirector sharedDirector] replaceScene: [[MZScenesFactory sharedInstance] sceneWithType: kMZSceneType_Loading]];
}

@end