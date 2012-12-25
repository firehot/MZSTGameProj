#import "MZAttackSetting.h"
#import "MZMotionSetting.h"
#import "MZSTGGameHelper.h"
#import "MZLogMacro.h"

@interface MZAttackSetting (Private)
-(void)_checkSettingsAccuracy;
@end

@implementation MZAttackSetting

@synthesize isRepeatForever, isRunOnce, isAimTargetEveryWave;
@synthesize numberOfWays, additionalWaysPerLaunch, strength;
@synthesize duration, colddownTime, intervalDegree, additionalVelocity, additionalVelocityLimited, additionalDegreePerWaveForLinear;
@synthesize targetType;
@synthesize faceTo;
@synthesize assignPosition;
@synthesize attackType;
@synthesize attackTypeString, bulletSettingName;
@synthesize motionSettingNsDictionariesArray;
@synthesize timePerWave, resetAtRest, restTime;

#pragma mark - init and dealloc

+(MZAttackSetting *)settingWithNSDictionary:(NSDictionary *)nsDictionary
{
    return [[[self alloc] initWithNSDictionary: nsDictionary] autorelease];
}

-(id)initWithNSDictionary:(NSDictionary *)nsDictionary
{
    if( ( self = [super init] ) )
    {
        isRepeatForever = [[nsDictionary objectForKey: @"isRepeatForever"] boolValue];
        isRunOnce = [[nsDictionary objectForKey: @"isRunOnce"] boolValue];
        isAimTargetEveryWave = [[nsDictionary objectForKey: @"isAimTargetEveryWave"] boolValue];
        
        numberOfWays = [[nsDictionary objectForKey: @"numberOfWays"] intValue];
        additionalWaysPerLaunch = [[nsDictionary objectForKey: @"additionalWaysPerLaunch"] intValue];
        strength = [[nsDictionary objectForKey: @"strength"] intValue];
        
        duration = [MZSTGGameHelper parseTimeValueFromString: [nsDictionary objectForKey: @"duration"]];
        colddownTime = [[nsDictionary objectForKey: @"colddown"] floatValue];
        intervalDegree = [[nsDictionary objectForKey: @"intervalDegree"] floatValue];
        additionalVelocity = [[nsDictionary objectForKey: @"additionalVelocity"] floatValue];
        additionalVelocityLimited = ( [nsDictionary objectForKey: @"additionalVelocityLimited"] )?
        [[nsDictionary objectForKey: @"additionalSpeedLimited"] floatValue] : -1;
        additionalDegreePerWaveForLinear = [[nsDictionary objectForKey: @"additionalDegreePerWaveForLinear"] floatValue];
        
        targetType = [MZSTGGameHelper getTargetTypeByNSString: [nsDictionary objectForKey: @"targetType"]];
        faceTo = [MZSTGGameHelper getFaceToByNSString: [nsDictionary objectForKey: @"faceTo"]];
        
        assignPosition = CGPointFromString( [nsDictionary objectForKey: @"assignPosition"] );
        attackTypeString = [[nsDictionary objectForKey: @"type"] retain];
        
        bulletSettingName = [[nsDictionary objectForKey: @"bulletName"] retain];
        motionSettingNsDictionariesArray = [[nsDictionary objectForKey: @"motions"] retain];
        
        resetAtRest = ( [nsDictionary objectForKey: @"resetAtRest"] )? [[nsDictionary objectForKey: @"resetAtRest"] boolValue] : false;
        timePerWave = ( [nsDictionary objectForKey: @"timePerWave"] )? [[nsDictionary objectForKey: @"timePerWave"] floatValue] : -1;
        restTime = ( [nsDictionary objectForKey: @"restTime"] )? [[nsDictionary objectForKey: @"restTime"] floatValue] : -1;
                
        [self _checkSettingsAccuracy];
    }
    
    return self;
}

-(void)dealloc
{
    [attackTypeString release];
    [bulletSettingName release];
    [motionSettingNsDictionariesArray release];
    [super dealloc];
}

@end

#pragma mark

@implementation MZAttackSetting (Private)

#pragma mark - methods

-(void)_checkSettingsAccuracy
{
    MZAssert( !(isRepeatForever == false && duration == 0), @"isRepeatForever == false && duration == 0" );
    
    // 當 None 時, 可以使用 movingVector ... 
//    if( ![attackTypeString isEqualToString: @"Idle"] )
//        MZAssert( targetType != kMZTargetType_None, @"target type can't be none when idle" );
}

@end