#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

@class MZBehavior_Base;

@interface MZSTGGameHelper : NSObject
+(void)destoryGameBase:(MZBehavior_Base **)targetGameBase;
+(float)parseTimeValueFromString:(NSString *)timeValueString;
+(MZTargetType)getTargetTypeByNSString:(NSString *)typeString;
+(MZRotatedCenterType)getRotatedCenterTypeByNSString:(NSString *)typeString;
+(MZFaceToType)getFaceToByNSString:(NSString *)faceToString;
+(NSString *)getTargetTypeStringWithType:(MZTargetType)type;
+(NSString *)getFaceToStringWithType:(MZFaceToType)faceTo;
@end

/*
 暫時性的輔助, 應該要移到各自對應的 class 內作為 static methods
 */