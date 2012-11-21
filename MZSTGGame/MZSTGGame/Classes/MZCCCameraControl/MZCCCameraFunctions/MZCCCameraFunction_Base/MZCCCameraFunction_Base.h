#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

@class CCLayer;
@class CCCamera;
@class MZCCCameraControl;

@interface MZCCCameraFunction_Base : NSObject
{
    bool isActive;
    MZCCCameraControl *cameraControlRef;
    CCLayer *controlLayerRef;
    CCCamera *cameraRef;
}

+(MZCCCameraFunction_Base *)cameraFunctionWithControlLayer:(CCLayer *)aControlLayer cameraControl:(MZCCCameraControl *)aCameraControl;
-(id)initWithControlLayer:(CCLayer *)aControlLayer cameraControl:(MZCCCameraControl *)aCameraControl;
-(void)enable;
-(void)disable;
-(void)updateWithDeltaTime:(mzTime)dt;

@end


@interface MZCCCameraFunction_Base (Private)
-(void)_initValues;
-(void)_updateWithDeltaTime:(mzTime)dt;
@end