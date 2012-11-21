#import "MZCCCameraControl.h"
#import "CCLayer.h"
#import "MZCCCameraFunctionHeader.h"
#import "MZLogMacro.h"

@implementation MZCCCameraControl

@synthesize currentPosistionAtScaleOne;

#pragma mark - init and dealloc 

+(MZCCCameraControl *)cameraControlWithCCLayer:(CCLayer *)aControlLayer
{
    return [[[self alloc] initWithCCLayer: aControlLayer] autorelease];
}

-(id)initWithCCLayer:(CCLayer *)aControlLayer
{
    if( ( self = [super init] ) )
    {
        MZAssert( aControlLayer.scale == 1, @"Please don't change scale when use camera control" );
        MZAssert( CGPointEqualToPoint( aControlLayer.position, CGPointZero ), @"Please don't change position when use camera control" );

        controlLayer = [aControlLayer retain];
        currentPosistionAtScaleOne = controlLayer.position;
        
        [self _initFounctions];
    }
    
    return self;
}

-(void)dealloc
{
    [controlLayer release];
    [functionsDictionary release];
    
    [super dealloc];
}

#pragma mark - methods

-(void)zoomWithValue:(float)zoomValue
{
    MZCCCameraFunction_Zoom *zoom = (MZCCCameraFunction_Zoom *)[functionsDictionary objectForKey: @"zoom"];
    zoom.zoomValue = zoomValue;
    [zoom enable];
}

-(void)rotated
{
    MZCCCameraFunction_Rotated *rotated = (MZCCCameraFunction_Rotated *)[functionsDictionary objectForKey: @"rotated"];
    [rotated enable];
}

-(void)updateWithDeltaTime:(mzTime)dt
{
    for( MZCCCameraFunction_Base *function in [functionsDictionary allValues] )
        [function updateWithDeltaTime: dt];
}

@end

#pragma mark

@implementation MZCCCameraControl (Private)

#pragma mark - init

-(void)_initFounctions
{
    functionsDictionary = [[NSMutableDictionary alloc] initWithCapacity: 1];
    
    MZCCCameraFunction_Zoom *zoom = [MZCCCameraFunction_Zoom cameraFunctionWithControlLayer: controlLayer cameraControl: self];
    [functionsDictionary setObject: zoom forKey: @"zoom"];
    
    MZCCCameraFunction_Rotated *rotated = [MZCCCameraFunction_Rotated cameraFunctionWithControlLayer: controlLayer cameraControl: self];
    [functionsDictionary setObject: rotated forKey: @"rotated"];    
}

@end