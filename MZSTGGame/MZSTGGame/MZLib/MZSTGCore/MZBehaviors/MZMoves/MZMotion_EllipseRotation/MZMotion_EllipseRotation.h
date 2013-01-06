#import "MZMove_Base.h"

@class MZCharacter;

@interface MZMotion_EllipseRotation : MZMove_Base
{
    float beginDegreeFromXAxis;
}

@end

/*
 setting:
 angularVelocity
 ellipseRadiansX
 ellipseRadiansY

 * 不支援 FakeCenter
 * 僅支援有主體的 Part
 * 理由: 因為無法由當時坐標算出橢圓的長短半徑, 所以只能用在靜態移動
*/