#import "MZSound.h"
#import "MZUtilitiesHeader.h"
#import "CocosDenshion.h"
#import "CDAudioManager.h"

@interface MZSound (Private)
@end

#pragma mark

@implementation MZSound

@synthesize showState;
@synthesize globalVolume;

@synthesize preSleepTime;
@synthesize afterSleepTime;

static MZSound *sharedSound_ = nil;

#pragma mark - init and dealloc

+(MZSound *)sharedSound
{
    if( sharedSound_ == nil )
        sharedSound_ = [[MZSound alloc] init];
    
    return sharedSound_;
}

-(id)init
{
    MZAssert( !sharedSound_, @"I am singleton!!!!" );
    
    if( ( self = [super init] ) )
    {
        globalVolume = 1.0;
        preSleepTime = 0.0;
        afterSleepTime = 0.0;
        soundRunTimeIdForNameDictionary = [[NSMutableDictionary alloc] initWithCapacity: 1];
        soundEngineRef = [[CDAudioManager sharedManager] soundEngine];
    }
    
    return self;
}

-(void)dealloc
{
    [soundNamesIndexDictionary release];
    [soundRunTimeIdForNameDictionary release];
    
    soundEngineRef = nil;
    
    [sharedSound_ release];
    sharedSound_ = nil;
    
    [super dealloc];
}

#pragma mark - methods

-(void)setSoundsByPlist:(NSString *)plistFileName
{
    NSDictionary *soundsDictionary = [MZFileHelper plistContentFromBundleWithName: plistFileName];
    MZAssert( soundsDictionary != nil, @"settingNsDictionary is nil" );
    
    [self setSoundsByNSDictionary: soundsDictionary];
}

-(void)setSoundsByNSDictionary:(NSDictionary *)nsDictionary
{
    if( nsDictionary == nil )
        return;
    
    if( !soundNamesIndexDictionary )
        soundNamesIndexDictionary = [[NSMutableDictionary alloc] initWithCapacity: 1];;
    
	int bufferIndex = [soundNamesIndexDictionary count];
	for( NSString *soundName in [nsDictionary allKeys] ) 
	{
        if( showState )
            MZLog( @"add sound(%@)", soundName );
        
		NSString *soundFileName = [nsDictionary objectForKey: soundName];
		[soundEngineRef loadBuffer: bufferIndex filePath: soundFileName];
        [soundNamesIndexDictionary setValue: [NSNumber numberWithInt: bufferIndex] forKey: soundName];
        
		bufferIndex++;
	}
}

-(void)playSoundByName:(NSString *)soundName loop:(bool)loop
{
    [self playSoundByName: soundName gain: 1.0 loop: loop];
}

-(void)playSoundByName:(NSString *)soundName gain:(float)gain loop:(bool)loop
{    
    MZAssert( [soundNamesIndexDictionary objectForKey: soundName], @"Can not found sound(%@)", soundName );
    
    if( preSleepTime > 0 )
    {
        [NSThread sleepForTimeInterval: preSleepTime];
        preSleepTime = 0.0;
    }
        
    int bufferIndex = [[soundNamesIndexDictionary objectForKey: soundName] intValue];
    float gain_ = gain*globalVolume;
    
    gain_ = ( gain_ > 1.0 )? 1.0 : gain_;
    
    if( showState )
        MZLog( @"%@, gain: %0.2f, loop: %@", soundName, gain_, ( loop )? @"TRUE" : @"FALSE" );
    
	int runTimeSourceId = [soundEngineRef playSound: bufferIndex sourceGroupId: 0 pitch: 1 pan: 0.0f gain: gain_ loop: loop];
    [soundRunTimeIdForNameDictionary setObject: [NSNumber numberWithInt: runTimeSourceId] forKey: soundName];
    
    if( afterSleepTime > 0 )
    {
        [NSThread sleepForTimeInterval: afterSleepTime];
        afterSleepTime = 0.0;
    }
}

-(void)stopSoundByName:(NSString *)soundName
{
    MZAssert( soundRunTimeIdForNameDictionary != nil, @"stopSound: soundRunTimeIdForNameDictionary is nil" );
    
    int runTimeSourceId = [[soundRunTimeIdForNameDictionary objectForKey: soundName] intValue];
    
    if( showState )
        MZLog( @"%@, srcID=%d", soundName, runTimeSourceId );
    
    [soundEngineRef stopSound: runTimeSourceId];
}

-(void)stopAll
{
    [soundEngineRef stopAllSounds];
}

@end