#import <Foundation/Foundation.h>

@interface MZFileHelper : NSObject
+(NSString *)homeDocumentsFileFullPathWithFileName:(NSString *)fileName;
+(NSDictionary *)plistContentFromBundleWithName:(NSString *)fileName;
+(NSDictionary *)plistContentFromHomeDocumentsWithName:(NSString *)fileName;
+(bool)saveFile:(NSObject *)file toDocumentsWithName:(NSString *)fileName removeExist:(bool)removeExist;
@end
