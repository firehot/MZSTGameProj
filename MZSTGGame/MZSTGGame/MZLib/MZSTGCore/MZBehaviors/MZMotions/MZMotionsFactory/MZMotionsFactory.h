#import <Foundation/Foundation.h>

@class MZMotion_Base;
@class MZMotionSetting;
@class MZGameObject;
@class MZLevelComponents;

@interface MZMotionsFactory : NSObject 
{

}

+(MZMotionsFactory *)sharedMZMotionsFactory;
-(MZMotion_Base *)getMotionBySetting:(MZMotionSetting *)aSetting controlTarget:(MZGameObject *)aControlTarget;
-(MZMotion_Base *)getReferenceToLeaderLinearMotionWithSetting:(MZMotionSetting *)aSetting controlTarget:(MZGameObject *)aControlTarget;
@end
