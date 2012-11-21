#import "MZCCCameraFunction_Rotated.h"
#import "CCCamera.h"

@implementation MZCCCameraFunction_Rotated

#pragma mark - override

+(MZCCCameraFunction_Rotated *)cameraFunctionWithControlLayer:(CCLayer *)aControlLayer cameraControl:(MZCCCameraControl *)aCameraControl
{
    return [[[self alloc] initWithControlLayer: aControlLayer cameraControl: aCameraControl] autorelease];
}

-(void)enable
{
    [super enable];
    cameraActionTimeCount = 0;
}

@end

#pragma mark

@implementation MZCCCameraFunction_Rotated (Private)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    cameraActionTimeCount = 0;
}

-(void)_updateWithDeltaTime:(mzTime)dt
{
    // please refacory below ... 
    
    cameraActionTimeCount += dt;
    
    float rotateActionTotalTime = 1.0; // 我是未來的 class 參數喔
    
    if( cameraActionTimeCount <= rotateActionTotalTime / 2 )
    {
        // x: 0 -> 1
        // y: 1 -> 0
        float halfOfRotateActionTotalTime = rotateActionTotalTime / 2;
        float upX, upY, upZ;
        [cameraRef upX: &upX upY: &upY upZ: &upZ];
        [cameraRef setUpX: cameraActionTimeCount/halfOfRotateActionTotalTime upY: 1-(cameraActionTimeCount/halfOfRotateActionTotalTime) upZ: upZ];
    }
    else
    {
        // x: 1 -> 0
        // y: 0 -> -1
        float halfOfRotateActionTotalTime = rotateActionTotalTime / 2;
        float halfOfCameraActionTimeCount = cameraActionTimeCount - halfOfRotateActionTotalTime; // 新的 count 量
        
        // 旋轉中間有頓點, 原因不明????
        
        float upX, upY, upZ;
        [cameraRef upX: &upX upY: &upY upZ: &upZ];
        //        NSLog( @"%0.2f, %0.2f, %0.2f", upX, upY, upZ );
        [cameraRef setUpX: 1-(halfOfCameraActionTimeCount/halfOfRotateActionTotalTime) upY: 0-(halfOfCameraActionTimeCount/halfOfRotateActionTotalTime) upZ: upZ]; 
    }
    
    if( cameraActionTimeCount >= rotateActionTotalTime )
    {
        float upX, upY, upZ;
        [cameraRef upX: &upX upY: &upY upZ: &upZ];
        //        NSLog( @"%0.2f, %0.2f, %0.2f", upX, upY, upZ );
        [cameraRef setUpX: 0 upY: -1 upZ: 0];
        
        [self disable];
    }
}

@end