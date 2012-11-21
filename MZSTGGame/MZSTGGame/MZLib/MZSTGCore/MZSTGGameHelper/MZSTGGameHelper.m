#import "MZSTGGameHelper.h"
#import "MZBehavior_Base.h"
#import "MZLogMacro.h"

@implementation MZSTGGameHelper

+(void)destoryGameBase:(MZBehavior_Base **)targetGameBase
{
    if( targetGameBase == nil )
        return;
    
    [*targetGameBase disable];
    [*targetGameBase release];
    *targetGameBase = nil;
}

+(float)parseTimeValueFromString:(NSString *)timeValueString
{
    if( timeValueString == nil )
    {
        return 0;
    }
    
    float timeValue = [timeValueString floatValue];
    
    if( timeValue < 0 )
    {
        MZLog( @"time value(%0.2f) < 0, set to ZERO!!!", timeValue );
        timeValue = 0;
    }
    
    return timeValue;
}

+(MZTargetType)getTargetTypeByNSString:(NSString *)typeString
{
    if( typeString == nil || [typeString length] == 0 || [typeString isEqualToString: @"None"] )
        return kMZTargetType_None;
        
    if( [typeString isEqualToString: @"Player"] )
        return kMZTargetType_Player;
    
    if( [typeString isEqualToString: @"ReferenceTarget"] )
        return kMZTargetType_ReferenceTarget;
    
    if( [typeString isEqualToString: @"AbsolutePosition"] )
        return kMZTargetType_AbsolutePosition;
    
    if( [typeString isEqualToString: @"FaceTo"] )
        return kMZTargetType_FaceTo;
    
    if( [typeString isEqualToString: @"AssignPositionAddParentPosition"] )    
        return kMZTargetType_AssignPositionAddParentPosition;
    
    if( [typeString isEqualToString: @"AssignPositionAddSpawnPosition"] )
        return kMZTargetType_AssignPositionAddSpawnPosition;
    
    MZAssert( false, @"unknow typeString(%@)", typeString );
    
    return -1;
}

+(MZRotatedCenterType)getRotatedCenterTypeByNSString:(NSString *)typeString
{
    if( typeString == nil || [typeString length] == 0 || [typeString isEqualToString: @"None"] )
        return kMZRotatedCenterType_None;
    
    if( [typeString isEqualToString: @"AssignPosition"] )
        return kMZRotatedCenterType_AssignPosition;
    
    if( [typeString isEqualToString: @"Spawn"] )
        return kMZRotatedCenterType_Spawn;
    
    if( [typeString isEqualToString: @"Self"] )
        return kMZRotatedCenterType_Self;

    if( [typeString isEqualToString: @"Motion"] )
        return kMZRotatedCenterType_Motion;
    
    MZAssert( false, @"unknow typeString(%@)", typeString );
    
    return -1;
    
}

+(MZFaceToType)getFaceToByNSString:(NSString *)faceToString
{
    if( faceToString == nil || [faceToString length] == 0 || [faceToString isEqualToString: @"None"] )
        return kMZFaceToType_None;
    
    if( [faceToString isEqualToString: @"Direction"] )
        return kMZFaceToType_Direction;
    
    if( [faceToString isEqualToString: @"Target"] )
        return kMZFaceToType_Target;
    
    if( [faceToString isEqualToString: @"PreviousDirection"] )
        return kMZFaceToType_PreviousDirection;
        
//    if( [faceToString isEqualToString: @"CurrentMovingVector"] )
//        return kMZFaceToType_CurrentMovingVector;
        
    MZAssert( false, @"unknow faceToString(%@)", faceToString );
    return -1;
}

+(NSString *)getTargetTypeStringWithType:(MZTargetType)type
{
    switch( type )
    {
        case kMZTargetType_None:
            return @"None";
            
        case kMZTargetType_Player:
            return @"Player";
            
        case kMZTargetType_ReferenceTarget:
            return @"ReferenceTarget";
            
        case kMZTargetType_AbsolutePosition:
            return @"AbsolutePosition";
            
        case kMZTargetType_FaceTo:
            return @"FaceTo";
            
        case kMZTargetType_AssignPositionAddParentPosition:
            return @"AssignPositionAddParentPosition";

        case kMZTargetType_AssignPositionAddSpawnPosition:
            return @"AssignPositionAddSpawnPosition";

        default:
            break;
    }
    
    MZAssert( false, @"Can't convert to string with unknow type" );
    return nil;
}

+(NSString *)getFaceToStringWithType:(MZFaceToType)faceTo
{
    switch( faceTo )
    {
        case kMZFaceToType_None:
            return @"None";
            
        case kMZFaceToType_Direction:
            return @"Direction";
            
        case kMZFaceToType_Target:
            return @"Target";
            
        default:
            break;
    }
    
    MZAssert( false, @"Can't convert to string with unknow type" );
    return nil;
}

@end
