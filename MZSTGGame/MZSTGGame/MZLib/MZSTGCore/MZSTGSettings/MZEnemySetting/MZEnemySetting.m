#import "MZEnemySetting.h"
#import "MZMotionSetting.h"
#import "MZAttackSetting.h"

@interface MZEnemySetting (Private)
-(void)_setMotionsWithNSArray:(NSArray *)motionsSettingNSArray;
-(void)_setAttacksWithNSArray:(NSArray *)nsArray; // delete
@end

#pragma mark

@implementation MZEnemySetting

@synthesize motionSettings;
@synthesize attackSettings;

+(MZEnemySetting *)settingWithDictionary:(NSDictionary *)settingDictionary
{
    return [[[self alloc] initWithDictionary: settingDictionary] autorelease];
}

-(id)initWithDictionary:(NSDictionary *)settingDictionary
{
    if( ( self = [super initWithDictionary: settingDictionary] ) )
    {
        [self _setMotionsWithNSArray: [settingDictionary objectForKey: @"Motions"]];
        [self _setAttacksWithNSArray: [settingDictionary objectForKey: @"Attacks"]];
    }
    
    return self;
}

-(void)dealloc
{
    [motionSettings release];
    [attackSettings release];
    
    [super dealloc];
}

@end

@implementation MZEnemySetting (Private)

-(void)_setMotionsWithNSArray:(NSArray *)nsArray
{
    if( nsArray == nil ) return;
    
    motionSettings = [[NSMutableArray alloc] initWithCapacity: 1];
    
    for( NSDictionary *nsDictionary in nsArray )
    {
        MZMotionSetting *motionSetting = [MZMotionSetting motionSettingWithNSDictionary: nsDictionary];
        [motionSettings addObject: motionSetting];
    }
}

-(void)_setAttacksWithNSArray:(NSArray *)nsArray
{
    if( nsArray == nil ) return;
    
    attackSettings = [[NSMutableArray alloc] initWithCapacity: 1];
    
    for( NSDictionary *nsDictionary in nsArray )
    {
        MZAttackSetting *attackSetting = [MZAttackSetting settingWithNSDictionary: nsDictionary];
        [attackSettings addObject: attackSetting];
    }
}

@end


