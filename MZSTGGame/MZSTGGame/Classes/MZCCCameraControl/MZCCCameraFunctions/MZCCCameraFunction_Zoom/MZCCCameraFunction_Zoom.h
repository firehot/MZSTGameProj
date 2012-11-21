#import "MZCCCameraFunction_Base.h"

typedef struct
{
    float max;
    float min;
    
}MZCCCameraZoomRange;

@interface MZCCCameraFunction_Zoom : MZCCCameraFunction_Base

+(MZCCCameraFunction_Zoom *)cameraFunctionWithControlLayer:(CCLayer *)aControlLayer cameraControl:(MZCCCameraControl *)aCameraControl;

@property (nonatomic, readwrite) bool useZoomAnimation;
@property (nonatomic, readwrite) float zoomValue;
@property (nonatomic, readwrite) float zoomAnimationTime;
@property (nonatomic, readwrite, assign) MZCCCameraZoomRange zoomRange;

@end

@interface MZCCCameraFunction_Zoom (Private)
-(void)_zoomWithValue:(float)zoomValue;
-(void)_zoomWithNormalWithScale:(float)resultScale resultPosition:(CGPoint)resultPosition;
-(void)_zoomWithAnimationWithScale:(float)resultScale resultPosition:(CGPoint)resultPosition;
@end
    
