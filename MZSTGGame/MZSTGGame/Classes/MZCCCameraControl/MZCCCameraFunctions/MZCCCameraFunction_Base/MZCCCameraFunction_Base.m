#import "MZCCCameraFunction_Base.h"
#import "MZCCCameraControl.h"
#import "MZLogMacro.h"
#import "CCLayer.h"
#import "CCCamera.h"

@implementation MZCCCameraFunction_Base

#pragma mark - init and dealloc

+(MZCCCameraFunction_Base *)cameraFunctionWithControlLayer:(CCLayer *)aControlLayer cameraControl:(MZCCCameraControl *)aCameraControl
{
    return [[[self alloc] initWithControlLayer: aControlLayer cameraControl: aCameraControl] autorelease];
}

-(id)initWithControlLayer:(CCLayer *)aControlLayer cameraControl:(MZCCCameraControl *)aCameraControl
{
    MZAssert( aControlLayer, @"aControlLayer is nil" );
    MZAssert( aCameraControl, @"aCameraControl is nil" );    
    
    if( ( self = [super init] ) )
    {        
        controlLayerRef = aControlLayer;
        cameraControlRef = aCameraControl;
        
        cameraRef = controlLayerRef.camera;
        
        [self _initValues];
    }
    
    return self;
}

-(void)dealloc
{
    controlLayerRef = nil;
    cameraControlRef = nil;
    cameraRef = nil;
    
    [super dealloc];
}

#pragma mark - methods

-(void)enable
{
    isActive = true;
}

-(void)disable
{
    isActive = false;    
}

-(void)updateWithDeltaTime:(mzTime)dt
{
    if( isActive )
        [self _updateWithDeltaTime: dt];
}

@end

#pragma mark

@implementation MZCCCameraFunction_Base (Private)

#pragma mark - init

-(void)_initValues
{
    isActive = false;
}

#pragma mark - methods

-(void)_updateWithDeltaTime:(mzTime)dt
{

}

@end