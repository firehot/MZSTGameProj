#import <Foundation/Foundation.h>

@class MZMove_Base;
@class MZMotionSetting;
@class MZGameObject;
@class MZLevelComponents;

@interface MZMotionsFactory : NSObject 
{

}

+(MZMotionsFactory *)sharedMZMotionsFactory;
-(MZMove_Base *)getMotionBySetting:(MZMotionSetting *)aSetting controlTarget:(MZGameObject *)aControlTarget;
-(MZMove_Base *)getReferenceToLeaderLinearMotionWithSetting:(MZMotionSetting *)aSetting controlTarget:(MZGameObject *)aControlTarget;
@end
