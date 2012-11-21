#import <Foundation/Foundation.h>
#import "MZSceneTypeDefine.h"

@class CCScene;

@interface MZCCScenesFactory : NSObject
+(MZCCScenesFactory *)sharedScenesFactory;

-(CCScene *)sceneWithType:(MZSceneType)sceneType;

@end
