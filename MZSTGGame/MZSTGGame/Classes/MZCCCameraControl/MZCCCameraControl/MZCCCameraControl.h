#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

@class CCLayer;
@class MZCCCameraFunction_Zoom;

@interface MZCCCameraControl : NSObject
{
    NSMutableDictionary *functionsDictionary;
    CCLayer *controlLayer;
}

+(MZCCCameraControl *)cameraControlWithCCLayer:(CCLayer *)aControlLayer;
-(id)initWithCCLayer:(CCLayer *)aControlLayer;
-(void)zoomWithValue:(float)zoomValue;
-(void)rotated;
-(void)updateWithDeltaTime:(mzTime)dt;

@property (nonatomic, readonly) CGPoint currentPosistionAtScaleOne;

@end

@interface MZCCCameraControl (Private)
-(void)_initFounctions;
@end