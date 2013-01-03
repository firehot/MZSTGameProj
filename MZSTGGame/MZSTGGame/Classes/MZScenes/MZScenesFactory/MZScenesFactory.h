#import <Foundation/Foundation.h>
#import "MZSceneTypeDefine.h"

@class CCScene;

@interface MZScenesFactory : NSObject
+(MZScenesFactory *)sharedInstance;

-(CCScene *)sceneWithType:(MZSceneType)sceneType;

@end
