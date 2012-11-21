#import "MZBgFeatureControl_Base.h"

@class MZGameObject;

@interface MZBgFeatureControl_RepeatTexture : MZBgFeatureControl_Base
{
@private
    MZGameObject *repeatTexture;
    CGPoint velocityXY;
//    CGPoint movingVector;
}

@end
