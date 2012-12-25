#import <Foundation/Foundation.h>

@class MZAttack_Base;
@class MZAttackSetting;
@class MZGameObject;

@interface MZAttacksFactory : NSObject 
{

}
+(MZAttacksFactory *)sharedInstance;
-(void)removeFromLevel;
-(MZAttack_Base *)getAttackBySetting:(MZAttackSetting *)setting controlTarget:(MZGameObject *)controlTarget;
@end