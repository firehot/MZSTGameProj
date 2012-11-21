#import "MZMotionSetting.h"
#import "MZMath.h"
#import "MZSTGGameHelper.h"
#import "MZLogMacro.h"

@interface MZMotionSetting (Private)
-(void)_checkSettingsAccuracy;
-(bool)_isTargetTypeNeedAssignPosition;
-(CGPoint)_getPositionWithNSString:(NSString *)positionString;
@end

#pragma amrk

@implementation MZMotionSetting

@synthesize isRepeatForever;
@synthesize isUsingPreviousMovingVector;
@synthesize isRunOnce;
@synthesize isAlwaysToTarget;
@synthesize isReferenceLeader;
@synthesize duration;
@synthesize initVelocity;
@synthesize acceleration;
@synthesize maxAcceleration;
@synthesize angularVelocity;
@synthesize radians;
@synthesize additionalRadians;
@synthesize theta;
@synthesize targetType;
@synthesize rotatedCenterType;
@synthesize movingVector;
@synthesize assignPosition;
@synthesize motionType;
@synthesize rotatedCenterMotions;
@synthesize ellipseRadiansX, ellipseRadiansY;
@synthesize accelerationXY;

#pragma mark - init and dealloc

+(MZMotionSetting *)motionSettingWithNSDictionary:(NSDictionary *)nsDictionary
{
    return [[[self alloc] initWithNSDictionary: nsDictionary] autorelease];
}

-(id)initWithNSDictionary:(NSDictionary *)nsDictionary
{
    MZAssert( nsDictionary != nil, @"NSDictionary is nil" );
    
    self = [super init];
    
    settingNSDictionary = [nsDictionary retain];
        
    isRepeatForever = [[nsDictionary objectForKey: @"isRepeatForever"] boolValue];
    isUsingPreviousMovingVector = [[nsDictionary objectForKey: @"isUsingPreviousMovingVector"] boolValue];
    isRunOnce = [[nsDictionary objectForKey: @"isRunOnce"] boolValue];
    isAlwaysToTarget = [[nsDictionary objectForKey: @"isAlwaysToTarget"] boolValue];
    isReferenceLeader = [[nsDictionary objectForKey: @"isReferenceLeader"] boolValue];
    
    duration = [MZSTGGameHelper parseTimeValueFromString: [nsDictionary objectForKey: @"duration"]];
    
    initVelocity = [[nsDictionary objectForKey: @"initVelocity"] floatValue];
    acceleration = [[nsDictionary objectForKey: @"acceleration"] floatValue];
    maxAcceleration = ( [nsDictionary objectForKey: @"maxAcceleration"] != nil )? [[nsDictionary objectForKey: @"maxAcceleration"] floatValue] : -1;
    angularVelocity = [[nsDictionary objectForKey: @"angularVelocity"] floatValue];
    radians = [[nsDictionary objectForKey: @"radians"] floatValue];
    additionalRadians = [[nsDictionary objectForKey: @"additionalRadians"] floatValue];
    theta = [[nsDictionary objectForKey: @"theta"] floatValue];
    
    targetType = [MZSTGGameHelper getTargetTypeByNSString: [nsDictionary objectForKey: @"targetType"]];
    rotatedCenterType = [MZSTGGameHelper getRotatedCenterTypeByNSString: [nsDictionary objectForKey: @"rotatedCenterType"]];
    
    assignPosition = CGPointFromString( [nsDictionary objectForKey: @"assignPosition"] );
    
    movingVector = [MZMath unitVectorFromVector: CGPointFromString( [nsDictionary objectForKey: @"movingVector"] )];
    
    motionType = [[nsDictionary objectForKey: @"motionType"] retain];
    
    rotatedCenterMotions = [[nsDictionary objectForKey: @"rotatedCenterMotions"] retain];
    
    ellipseRadiansX = [[nsDictionary objectForKey: @"ellipseRadiansX"] floatValue];
    ellipseRadiansY = [[nsDictionary objectForKey: @"ellipseRadiansY"] floatValue];
    
    accelerationXY = CGPointFromString( [nsDictionary objectForKey: @"accelerationXY"] );
    
    [self _checkSettingsAccuracy];

    return self;
}

-(void)dealloc
{
    [settingNSDictionary release];
    [motionType release];
    [rotatedCenterMotions release];
    [super dealloc];
}

#pragma mark - properties

-(void)setMovingVector:(CGPoint)aMovingVector
{
    movingVector = [MZMath unitVectorFromVector: aMovingVector];
}

-(NSDictionary *)getOriginalNSDictionary
{
    return settingNSDictionary;
}

-(NSDictionary *)getOriginalNSDictionaryCopy
{
    return [NSDictionary dictionaryWithDictionary: settingNSDictionary];
}

@end

@implementation MZMotionSetting (Private)

-(void)_checkSettingsAccuracy
{
    MZAssert( !(isRepeatForever == false && duration == 0), @"isRepeatForever == false && duration == 0" );
    MZAssert( maxAcceleration == -1 || maxAcceleration >= 0, @"maxAcceleration less than zero" );
}

// 暫時不使用 ... 見 .h 的設計法 ... 
-(bool)_isTargetTypeNeedAssignPosition
{
    return 
    ( 
     targetType == kMZTargetType_AbsolutePosition || 
     targetType == kMZTargetType_AssignPositionAddParentPosition || 
     targetType == kMZTargetType_AssignPositionAddSpawnPosition 
     )?
    true : 
    false;
}

// 暫時不使用 ... 見 .h 的設計法 ... 
-(CGPoint)_getPositionWithNSString:(NSString *)positionString
{    
    if( [self _isTargetTypeNeedAssignPosition] )
    {
        MZAssert( positionString, @"positionString is nil(target type need it)" );
        return CGPointFromString( positionString );
    }
    
    return CGPointZero;
}

@end
