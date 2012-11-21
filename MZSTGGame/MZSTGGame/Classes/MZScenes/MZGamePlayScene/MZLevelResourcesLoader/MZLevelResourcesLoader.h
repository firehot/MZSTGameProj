#import <Foundation/Foundation.h>

@interface MZLevelResourcesLoader : NSObject
+(MZLevelResourcesLoader *)levelResourcesLoaderWithLevelSettingNSDicitonary:(NSDictionary *)aLevelSettingNSDicitonary;
-(id)initWithLevelSettingNSDicitonary:(NSDictionary *)aLevelSettingNSDicitonary;
@end