#import "MZGameSetting.h"
#import "MZFileHelper.h"
#import "MZGameSetting_System.h"
#import "MZGameSetting_GamePlay.h"
#import "MZGameSettingsHeader.h"
#import "MZLogMacro.h"

#define VERSION @"Alpha 0.09"

@implementation MZGameSetting

@synthesize system;
@synthesize gamePlay;
@synthesize debug;

static MZGameSetting *sharedGameSetting_ = nil;

#pragma mark - init and dealloc

+(MZGameSetting *)sharedInstance
{
	if( !sharedGameSetting_ )
		sharedGameSetting_ = [[self alloc] init];
	
	return sharedGameSetting_;
}

-(id)init
{
    MZAssert( sharedGameSetting_ == nil, @"I am number one ... !!!" );
    
    self = [super init];

    NSDictionary *gameSettingPlist = [MZFileHelper plistContentFromBundleWithName: @"GameSetting.plist"];
    MZAssert( gameSettingPlist != nil, @"gameSettingPlist is nil" );
    
    system = [[MZGameSetting_System alloc] initWithNSDictionary: [gameSettingPlist objectForKey: @"system"]];
    gamePlay = [[MZGameSetting_GamePlay alloc] initWithNSDictionary: [gameSettingPlist objectForKey: @"gamePlay"]];
    debug = [[MZGameSetting_Debug alloc] initWithNSDictionary: [gameSettingPlist objectForKey: @"debug"]];
	
	return self;
}

-(void)dealloc
{
    [system release];
    [gamePlay release];
    [debug release];
    
    [sharedGameSetting_ release];
	sharedGameSetting_ = nil;
	
	[super dealloc];
}

@end
