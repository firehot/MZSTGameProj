#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

@class MZAttackSetting;
@class MZCharacter;
@class MZGameObject;

@interface MZAttackTargetHelpKit : NSObject
{
    float currentAdditionalDegree;
    CGPoint movingVectorToTarget;
    MZAttackSetting *settingRef;
    MZGameObject *controlTargetRef;
}

-(id)initWithAttackSetting:(MZAttackSetting *)aSetting controlTarget:(MZGameObject *)aControlTarget;
-(float)getDegreeToTarget;
-(CGPoint)getTargetPosition;
-(CGPoint)getMovingVectorToTarget;
@end