#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

@class MZAttackSetting;
@class MZCharacter;
@class MZGameObject;
@class MZLevelComponents;

@interface MZAttackTargetHelpKit : NSObject
{
    float currentAdditionalDegree;
    CGPoint movingVectorToTarget;
    MZAttackSetting *settingRef;
    MZGameObject *controlTargetRef;
    MZLevelComponents *levelComponentsRef;
}

-(id)initWithAttackSetting:(MZAttackSetting *)aSetting 
             controlTarget:(MZGameObject *)aControlTarget
          levelComponenets:(MZLevelComponents *)aLevelComponenets;
-(float)getDegreeToTarget;
-(CGPoint)getTargetPosition;
-(CGPoint)getMovingVectorToTarget;
@end