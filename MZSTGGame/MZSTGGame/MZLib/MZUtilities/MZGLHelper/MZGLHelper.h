#import <Foundation/Foundation.h>

@interface MZGLHelper : NSObject
+(GLenum)glBlendEnumFromString:(NSString *)enumString;
+(GLenum)defaultBlendFuncSrc;
+(GLenum)defaultBlendFuncDest;
@end

