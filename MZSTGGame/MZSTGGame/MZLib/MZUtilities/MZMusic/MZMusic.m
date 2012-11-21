#import "MZMusic.h"
#import "MZUtilitiesHeader.h"
#import "CDAudioManager.h"

@implementation MZMusic

@synthesize showState;
@synthesize globalVolume;
@synthesize gain;

static MZMusic *sharedMusic_ = nil;

#pragma mark - init and dealloc

+(MZMusic *)sharedMusic
{
    if( sharedMusic_ == nil )
        sharedMusic_ = [[MZMusic alloc] init];
    
    return sharedMusic_;
}

-(void)dealloc
{
    audioManagerRef = nil;
    
    [sharedMusic_ release];
    sharedMusic_ = nil;
    
    [super dealloc];
}

#pragma mark - properties

-(void)setGain:(float)aGain
{
    gain = aGain*globalVolume;
    gain = ( gain > 1.0 )? 1.0 : gain;
    gain = ( gain < 0.0 )? 0.0 : gain;
    audioManagerRef.backgroundMusic.volume = gain;
}

-(float)gain
{
    return gain;
}

#pragma mark - methods

-(void)preLoadMusicWithName:(NSString *)fileName
{
    if( showState )
        MZLog( @"%@", fileName );
    
	[audioManagerRef preloadBackgroundMusic: fileName];
}

-(void)playMusicByName:(NSString *)name loop:(bool)loop
{	    
    if( showState )
        MZLog( @"%@", name );
    
    if( name == nil || [name length] <= 0 )
        return;
    
	[audioManagerRef playBackgroundMusic: name loop: loop];
}

-(void)stopAll
{
    [audioManagerRef stopBackgroundMusic];
}

@end

#pragma mark

@implementation MZMusic (Private)

#pragma mark - override

-(id)init
{
    self = [super init];
    
    if( self )
    {
        globalVolume = 1.0;
        self.gain = 1.0;
        audioManagerRef = [CDAudioManager sharedManager];
    }
    
    return self;
}

@end
