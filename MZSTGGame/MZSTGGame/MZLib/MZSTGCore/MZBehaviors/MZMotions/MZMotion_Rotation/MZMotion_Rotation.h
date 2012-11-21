#import "MZMotion_Base.h"

@class MZCharacter;
@class MZCharacterSetting;

@interface MZMotion_Rotation : MZMotion_Base
{
    float currentRadians;
    float currentTheta;
    CGPoint spawnPosition;
    CGPoint lastCenter; // 用途不明 ... 
//    MZCharacter *fakeCenterCharacter;
}

@end

/*
 setting:
    rotatedCenterType
    assignPosition ... 作為圓心
    radians <-- 好像不用
    theta <-- 好像不用
    angularVelocity
    additionalRadians
 */