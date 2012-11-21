#import "cocos2d.h"
#import "AppDelegate.h"
#import "MZGameSettingsHeader.h"
#import "MZCCScenesFactory.h"
#import "MZCCDisplayHelper.h"

@implementation MyNavigationController

// The available orientations should be defined in the Info.plist file.
// And in iOS 6+ only, you can override it in the Root View controller in the "supportedInterfaceOrientations" method.
// Only valid for iOS 6+. NOT VALID for iOS 4 / 5.
-(NSUInteger)supportedInterfaceOrientations
{
	// iPhone only
	if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone )
		return UIInterfaceOrientationMaskLandscape;
	
	// iPad only
	return UIInterfaceOrientationMaskLandscape;
}

// Supported orientations. Customize it for your own needs
// Only valid on iOS 4 / 5. NOT VALID for iOS 6.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// iPhone only
	if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone )
        return ( interfaceOrientation == UIInterfaceOrientationPortrait );
//		return UIInterfaceOrientationIsLandscape(interfaceOrientation);
	
	// iPad only
	// iPhone only
//	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    return ( interfaceOrientation == UIInterfaceOrientationPortrait );
}

// This is needed for iOS4 and iOS5 in order to ensure
// that the 1st scene has the correct dimensions
// This is not needed on iOS6 and could be added to the application:didFinish...
-(void)directorDidReshapeProjection:(CCDirector*)director
{
	if(director.runningScene == nil)
    {
		// Add the first scene to the stack. The director will draw it immediately into the framebuffer. (Animation is started automatically when the view is displayed.)
		// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
		[director runWithScene: [[MZCCScenesFactory sharedScenesFactory] sceneWithType: kMZSceneType_Title]];
	}
}

-(BOOL)shouldAutorotate
{
    return NO;
}

@end

#pragma mark

@interface AppController (Private)
-(bool)_enableRetinaDisplayButIPad3;
@end

#pragma mark

@implementation AppController

@synthesize window=window_, navController=navController_, director=director_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	window_ = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
	CCGLView *glView = [CCGLView viewWithFrame: [window_ bounds]
								   pixelFormat: kEAGLColorFormatRGB565
								   depthFormat: 0
							preserveBackbuffer: NO
									sharegroup: nil
								 multiSampling: NO
							   numberOfSamples: 0];
    
	director_ = (CCDirectorIOS *)[CCDirector sharedDirector];
	director_.wantsFullScreenLayout = YES;
	[director_ setDisplayStats: [MZGameSetting sharedInstance].debug.showFPS];
	[director_ setAnimationInterval: 1.0/[MZGameSetting sharedInstance].system.fps];
	[director_ setView: glView];
    
//  [director_ setProjection: kCCDirectorProjection2D];
	[director_ setProjection: kCCDirectorProjection3D];
    
	if( ! [director_ enableRetinaDisplay: [self _enableRetinaDisplayButIPad3]] )
		CCLOG( @"Retina Display Not supported" );
    
    [[MZCCDisplayHelper sharedInstance] setDisplayInfoAfterViewActive];
    
	[CCTexture2D setDefaultAlphaPixelFormat: [MZGameSetting sharedInstance].system.texture2DPixelFormat];
    [CCTexture2D PVRImagesHavePremultipliedAlpha: YES];
    
    CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes: NO];
    [sharedFileUtils setiPhoneRetinaDisplaySuffix: @"-hd"];
	[sharedFileUtils setiPadSuffix: @"-hd"];
	[sharedFileUtils setiPadRetinaDisplaySuffix: @"-ipadhd"];
    
    navController_ = [[MyNavigationController alloc] initWithRootViewController: director_];
	navController_.navigationBarHidden = YES;
    
    [director_ setDelegate: navController_];
    
	[window_ addSubview: navController_.view];
	[window_ makeKeyAndVisible];
    
	return YES;
}

-(void)applicationWillResignActive:(UIApplication *)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ pause];
}

-(void)applicationDidBecomeActive:(UIApplication *)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ resume];
}

-(void)applicationDidEnterBackground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ stopAnimation];
}

-(void)applicationWillEnterForeground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ startAnimation];
}

-(void)applicationWillTerminate:(UIApplication *)application
{
	CC_DIRECTOR_END();
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void)applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

-(void)dealloc
{
	[window_ release];
	[navController_ release];
    
	[super dealloc];
}

@end

#pragma mark

@implementation AppController (Private)

-(bool)_enableRetinaDisplayButIPad3
{
    return !( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && [[UIScreen mainScreen] scale] == 2 );
}

@end