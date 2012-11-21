#import "MZCCCameraFunction_Zoom.h"
#import "MZCCCameraControl.h"
#import "CCLayer.h"
#import "CCActionInterval.h"

@implementation MZCCCameraFunction_Zoom

@synthesize useZoomAnimation;
@synthesize zoomValue, zoomAnimationTime;
@synthesize zoomRange;

#pragma mark - override

+(MZCCCameraFunction_Zoom *)cameraFunctionWithControlLayer:(CCLayer *)aControlLayer cameraControl:(MZCCCameraControl *)aCameraControl
{
    return [[[self alloc] initWithControlLayer: aControlLayer cameraControl: aCameraControl] autorelease];
}

#pragma mark - methods

-(void)enable
{
    [super enable];
    [self _zoomWithValue: zoomValue];
    [super disable];
}

@end

#pragma mark

@implementation MZCCCameraFunction_Zoom (Private)

#pragma mark - override

-(void)_initValues
{
    useZoomAnimation = true;
    zoomAnimationTime = 1.0;
    zoomRange.max = 20.0;
    zoomRange.min = 1.0;   
}

#pragma mark - methods

-(void)_zoomWithValue:(float)zoomValue_
{
    if( zoomValue != zoomValue_ )
        zoomValue = zoomValue_;
    
    if( zoomValue == 0 || 
       ( zoomValue > 0 && controlLayerRef.scale == zoomRange.max ) ||
       ( zoomValue < 0 && controlLayerRef.scale == zoomRange.min ) )
        return;
    
    float currentScale = controlLayerRef.scale;
    float resultScale = currentScale + zoomValue;
    
    if( resultScale > zoomRange.max ) resultScale = zoomRange.max;
    if( resultScale < zoomRange.min ) resultScale = zoomRange.min;
    
    CGPoint currentPosistionAtScaleOne = cameraControlRef.currentPosistionAtScaleOne;
    CGPoint resultPosition = CGPointMake( currentPosistionAtScaleOne.x*resultScale, currentPosistionAtScaleOne.y*resultScale );
    
    ( useZoomAnimation )? 
    [self _zoomWithAnimationWithScale: resultScale resultPosition: resultPosition] :
    [self _zoomWithNormalWithScale: resultScale resultPosition: resultPosition];
}


-(void)_zoomWithNormalWithScale:(float)resultScale resultPosition:(CGPoint)resultPosition
{
    controlLayerRef.scale = resultScale;
    controlLayerRef.position = resultPosition;
}

-(void)_zoomWithAnimationWithScale:(float)resultScale resultPosition:(CGPoint)resultPosition
{
    id moveTo = [CCMoveTo actionWithDuration: zoomAnimationTime position: resultPosition];
    id scaleTo = [CCScaleTo actionWithDuration: zoomAnimationTime scale: resultScale];
    id spawn = [CCSpawn actions: moveTo, scaleTo, nil];
    
    [controlLayerRef runAction: spawn];
}

@end
