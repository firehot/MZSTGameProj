#import "MZCharacterSetting.h"
#import "MZLogMacro.h"

@interface MZCharacterSetting (Private)
@end

#pragma mark

@implementation MZCharacterSetting

@synthesize healthPoint;
@synthesize characterType;
@synthesize name;
@synthesize characterPartSettingsDictionary;
@synthesize modeSettings;

#pragma mark - init and dealloc

+(MZCharacterSetting *)setting
{
    return [[[self alloc] init] autorelease];
}

+(MZCharacterSetting *)settingWithDictionary:(NSDictionary *)nsDictionary
{
    return [[[self alloc] initWithDictionary: nsDictionary] autorelease];
}

-(id)initWithDictionary:(NSDictionary *)nsDictionary
{
    MZAssert( [nsDictionary objectForKey: @"name"], @"name is nil" );
    
    self = [super init];
    
    healthPoint = [[nsDictionary objectForKey: @"healthPoint"] intValue];
//    characterType = ??? // not yet
    name = [[nsDictionary objectForKey: @"name"] retain];
    [self _initCharacterPartSettingsWithDictionary: [nsDictionary objectForKey: @"parts"]];
    
    return self;
}

-(void)dealloc
{
    [name release];
    [characterPartSettingsDictionary release];
    [modeSettings release];
    
    [super dealloc];
}

@end

#pragma mark

@implementation MZCharacterSetting (Private)

#pragma mark - init

@end
