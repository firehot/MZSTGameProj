#import "MZCharacterSetting.h"
#import "MZCharacterPartSetting.h"
#import "MZLogMacro.h"

@interface MZCharacterSetting (Private)
-(void)_initCharacterPartSettingsWithDictionary:(NSDictionary *)dictionary;
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

#pragma mark - init (private)

-(void)_initCharacterPartSettingsWithDictionary:(NSDictionary *)dictionary
{
    if( dictionary == nil ) return;
    
    if( characterPartSettingsDictionary == nil )
        characterPartSettingsDictionary = [[NSMutableDictionary alloc] initWithCapacity: 1];
    
    for( NSString *partName in [dictionary allKeys] )
    {
        NSDictionary *partDictionary = [dictionary objectForKey: partName];
        
        MZCharacterPartSetting *characterPartSetting = [MZCharacterPartSetting settingWithDictionary: partDictionary name: partName];
        [characterPartSettingsDictionary setObject: characterPartSetting forKey: partName];
    }
}

@end
