#import "MZModeSetting.h"
#import "MZMotionSetting.h"
#import "MZCharacterPartControlSetting.h"
#import "MZCharacter.h"
#import "MZGameSettingsHeader.h"
#import "MZSTGGameHelper.h"
#import "MZLogMacro.h"

@interface MZModeSetting (Private)
-(void)_initMotionSettingsWithNSArray:(NSArray *)nsArray;
-(void)_initPartControlSettingsWithDictionary:(NSDictionary *)dictionary;

-(void)_initPartControlSettingsUsingDefault;
-(void)_initPartControlSettingsUsingNonNilDictionary:(NSDictionary *)dictionary;

-(void)_checkSettingsAccuracy;
@end

@implementation MZModeSetting

@synthesize isRunOnce;
@synthesize isRepeatForever;
@synthesize duration;
@synthesize name;
@synthesize motionSettings;
@synthesize characterPartControlSettingsDictionary;

#pragma mark - init and dealloc

+(MZModeSetting *)modeSettingWithNSDictionary:(NSDictionary *)nsDictionary
{
    return [[[self alloc] initWithNSDictionary: nsDictionary] autorelease];
}

-(id)initWithNSDictionary:(NSDictionary *)nsDictionary
{
    self = [super init];
    
    if( nsDictionary == nil )
    {
        isRunOnce = false;
        isRepeatForever = true;
        name = [[NSString stringWithFormat: @"default_mode_name"] retain];
    }
    else
    {
        isRunOnce = ( [nsDictionary objectForKey: @"isRunOnce"] )? [[nsDictionary objectForKey: @"isRunOnce"] boolValue] : false;
        isRepeatForever = ( [nsDictionary objectForKey: @"isRepeatForever"] )? [[nsDictionary objectForKey: @"isRepeatForever"] boolValue]: false;
        duration = [MZSTGGameHelper parseTimeValueFromString: [nsDictionary objectForKey: @"duration"]];
        
        name = [[nsDictionary objectForKey: @"name"] retain];
    }
    
    [self _initMotionSettingsWithNSArray: [nsDictionary objectForKey: @"motions"]];
    [self _initPartControlSettingsWithDictionary: [nsDictionary objectForKey: @"partControls"]];
    [self _checkSettingsAccuracy];
    
    return self;
}

-(void)dealloc
{
    [name release];
    [motionSettings release];
    [characterPartControlSettingsDictionary release];
    
    [super dealloc];
}

#pragma mark - methods

-(void)addMotionSetting:(MZMotionSetting *)motionSetting
{
    if( motionSettings == nil )
        motionSettings = [[NSMutableArray alloc] initWithCapacity: 1];
    
    [motionSettings addObject: motionSetting];
}

@end

#pragma mark

@implementation MZModeSetting (Private)

#pragma mark - init

-(void)_initMotionSettingsWithNSArray:(NSArray *)nsArray
{
    if( nsArray == nil ) return;
    
    if( motionSettings == nil )
        motionSettings = [[NSMutableArray alloc] initWithCapacity: 1];
    
    for( NSDictionary *nsDictionary in nsArray )
    {
        MZMotionSetting *motionSetting = [MZMotionSetting motionSettingWithNSDictionary: nsDictionary];
        [motionSettings addObject: motionSetting];
    }
}

-(void)_initPartControlSettingsWithDictionary:(NSDictionary *)dictionary
{
    if( characterPartControlSettingsDictionary == nil )
        characterPartControlSettingsDictionary = [[NSMutableDictionary alloc] initWithCapacity: 1];
    
    ( dictionary == nil )?
    [self _initPartControlSettingsUsingDefault] : [self _initPartControlSettingsUsingNonNilDictionary: dictionary];
}

-(void)_initPartControlSettingsUsingDefault
{
    if( [MZGameSetting sharedInstance].debug.showCharacterSpawnInfo )
        MZLog( @"" );
    
    MZCharacterPartControlSetting *characterPartControlSetting = [MZCharacterPartControlSetting settingWithDictionary: nil controlName: nil];
    
    [characterPartControlSettingsDictionary setObject: characterPartControlSetting forKey: @"default"];
}

-(void)_initPartControlSettingsUsingNonNilDictionary:(NSDictionary *)dictionary
{
    MZAssert( dictionary != nil, @"dictionary is nil" );

    for( NSString *controlName in [dictionary allKeys] )
    {
        NSDictionary *settingDictionary = [dictionary objectForKey: controlName];
        
        MZCharacterPartControlSetting *characterPartControlSetting = [MZCharacterPartControlSetting settingWithDictionary: settingDictionary
                                                                                                              controlName: controlName];
        [characterPartControlSettingsDictionary setObject: characterPartControlSetting forKey: controlName];
    }
}

#pragma mark - methods

-(void)_checkSettingsAccuracy
{
    MZAssert( !(isRepeatForever == false && duration == 0), @"isRepeatForever == false && duration == 0" );
}

@end