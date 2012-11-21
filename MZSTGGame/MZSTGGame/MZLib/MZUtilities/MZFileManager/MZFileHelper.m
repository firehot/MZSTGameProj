#import "MZFileHelper.h"
#import "MZLogMacro.h"

@implementation MZFileHelper

+(NSString *)homeDocumentsFileFullPathWithFileName:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    return [[paths objectAtIndex: 0] stringByAppendingPathComponent: fileName];
}

+(NSDictionary *)plistContentFromBundleWithName:(NSString *)fileName
{
	NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
	NSString *fullPath = [bundlePath stringByAppendingPathComponent: fileName];
    NSDictionary *plistContent = [NSDictionary dictionaryWithContentsOfFile: fullPath];
    
	return plistContent;
}

+(NSDictionary *)plistContentFromHomeDocumentsWithName:(NSString *)fileName
{
    NSString *fullPath = [MZFileHelper homeDocumentsFileFullPathWithFileName: fileName];
    NSDictionary *plistContent = [NSDictionary dictionaryWithContentsOfFile: fullPath];

    return plistContent;
}

+(bool)saveFile:(NSObject *)file toDocumentsWithName:(NSString *)fileName removeExist:(bool)removeExist
{
    if( fileName == nil ) return false;

    NSString *filePath = [MZFileHelper homeDocumentsFileFullPathWithFileName: fileName];
    
    if( removeExist )
    {
        if( [[NSFileManager defaultManager] fileExistsAtPath: filePath] )
        {
            NSError *error = nil;
            [[NSFileManager defaultManager] removeItemAtPath: filePath error: &error];
            
            if( error )
            {
                MZLog( @"%@", [error localizedDescription] );
                return false;
            }
        }
    }
    
    if( ![file respondsToSelector: @selector( writeToFile:atomically: )] ) return false;
    
    bool result = [file performSelector: @selector( writeToFile: atomically: ) withObject: filePath withObject: 0];

    return result;
}

@end