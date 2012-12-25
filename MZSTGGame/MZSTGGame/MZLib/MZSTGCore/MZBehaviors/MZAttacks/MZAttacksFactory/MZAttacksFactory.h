#import <Foundation/Foundation.h>
#import "MZAttack_Base.h"

@class MZAttackSetting;
@class MZGameObject;

@interface MZAttacksFactory : NSObject 
{

}
+(MZAttacksFactory *)sharedInstance;
-(void)removeFromLevel;
-(MZAttack_Base *)getAttackWithDelegate:(id<MZAttackDelegate>)aDelegate setting:(MZAttackSetting *)setting;
@end