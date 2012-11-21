#import "MZCCCameraFunction_Base.h"

@interface MZCCCameraFunction_Rotated : MZCCCameraFunction_Base
{
    float cameraActionTimeCount;
}

+(MZCCCameraFunction_Rotated *)cameraFunctionWithControlLayer:(CCLayer *)aControlLayer cameraControl:(MZCCCameraControl *)aCameraControl;

@end
