#import "MZCharacterPartControlSetting.h"
#import "MZAttackSetting.h"
#import "MZSTGGameHelper.h"
#import "MZMotionSetting.h"

@interface MZCharacterPartControlSetting (Private)
-(void)_initUsingDefault;
-(void)_initDictionary:(NSDictionary *)aDictinary controlName:(NSString *)aControlName;
-(void)_initAttackSettingsWithNSArray:(NSArray *)nsArray;
-(void)_initMotionSettingsWithNSArray:(NSArray *)nsArray;
@end

#pragma mark

@implementation MZCharacterPartControlSetting

@synthesize faceTo;
@synthesize controlName;
@synthesize controlPartName;
@synthesize attackSettingsArray;
@synthesize motionSettingsArray;

#pragma mark - init and dealloc

+(MZCharacterPartControlSetting *)settingWithDictionary:(NSDictionary *)aDictionary controlName:(NSString *)aControlName
{
    return [[[self alloc] initWithDictionary: aDictionary controlName: aControlName] autorelease];
}

-(id)initWithDictionary:(NSDictionary *)aDictionary controlName:(NSString *)aControlName
{
    self = [super init];
        
    ( aDictionary == nil )? [self _initUsingDefault] : [self _initDictionary: aDictionary controlName: aControlName];
    
    return self;
}

-(void)dealloc
{
    [controlName release];
    [controlPartName release];
    [attackSettingsArray release];
    [motionSettingsArray release];
    
    [super dealloc];
}
         
@end

#pragma mark - 

@implementation MZCharacterPartControlSetting (Private)

#pragma mark - init

-(void)_initUsingDefault
{
    faceTo = kMZFaceToType_None;
    controlName = [@"Default" retain];
    controlPartName = [@"Default" retain];
}

-(void)_initDictionary:(NSDictionary *)aDictinary controlName:(NSString *)aControlName
{
    controlName = [aControlName retain];
    
    controlPartName = ( [aDictinary objectForKey: @"controlPartName"] )? [aDictinary objectForKey: @"controlPartName"] : controlName;
    [controlPartName retain];
    
    faceTo = [MZSTGGameHelper getFaceToByNSString: [aDictinary objectForKey: @"faceTo"]];
    [self _initAttackSettingsWithNSArray: [aDictinary objectForKey: @"attacks"]];
    [self _initMotionSettingsWithNSArray: [aDictinary objectForKey: @"motions"]];
}

-(void)_initAttackSettingsWithNSArray:(NSArray *)nsArray
{
    if( nsArray == nil ) return;
    
    attackSettingsArray = [[NSMutableArray alloc] initWithCapacity: 1];
    
    for( NSDictionary *nsDictionary in nsArray )
    {
        MZAttackSetting *attackSetting = [MZAttackSetting settingWithNSDictionary: nsDictionary];
        [attackSettingsArray addObject: attackSetting];
    }
}

-(void)_initMotionSettingsWithNSArray:(NSArray *)nsArray
{
    if( nsArray == nil ) return;
    
    motionSettingsArray = [[NSMutableArray alloc] initWithCapacity: 1];
    
    for( NSDictionary *nsDictionary in nsArray )
    {
        MZMotionSetting *motionSetting = [MZMotionSetting motionSettingWithNSDictionary: nsDictionary];
        [motionSettingsArray addObject: motionSetting];
    }
}

#pragma mark - methods

@end