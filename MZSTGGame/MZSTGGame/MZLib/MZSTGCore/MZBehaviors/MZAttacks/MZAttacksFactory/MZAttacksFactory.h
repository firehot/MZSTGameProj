#import <Foundation/Foundation.h>

@class MZAttack_Base;
@class MZAttackSetting;
@class MZGameObject;
@class MZLevelComponents;

@interface MZAttacksFactory : NSObject 
{
    MZLevelComponents *levelComponentsRef;
}
+(MZAttacksFactory *)sharedInstance;
-(void)setOnLevelWithComponemts:(MZLevelComponents *)aLevelComponents;
-(void)removeFromLevel;
-(MZAttack_Base *)getAttackBySetting:(MZAttackSetting *)setting controlTarget:(MZGameObject *)controlTarget;
@end