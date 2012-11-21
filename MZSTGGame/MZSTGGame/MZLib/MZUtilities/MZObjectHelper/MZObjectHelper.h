#import <Foundation/Foundation.h>

@interface MZObjectHelper : NSObject
+(void)releaseObject:(NSObject **)targetObject;
+(void)releaseAndSetNilToObject:(NSObject **)targetObject;
+(void)releaseAndSetNilToObjectWithRetainCountEqualOne:(NSObject **)targetObject;
@end
