#import "MZGamePlayHUD_Base.h"
#import "MZGamePlayHUDLayer.h"
#import "MZGamePlayScene.h"
#import "MZTime.h"
#import "MZLogMacro.h"

@implementation MZGamePlayHUD_Base

#pragma mark - init and dealloc

+(MZGamePlayHUD_Base *)gamePlayHUDWithTargetLayer:(MZGamePlayHUDLayer *)aTargetLayer parentScene:(MZGamePlayScene *)aParentScene
{
    return [[[self alloc] initWithTargetLayer: aTargetLayer parentScene: aParentScene] autorelease];
}

-(id)initWithTargetLayer:(MZGamePlayHUDLayer *)aTargetLayer parentScene:(MZGamePlayScene *)aParentScene
{
    MZAssert( aTargetLayer, @"aTargetLayer is nil" );
    MZAssert( aParentScene, @"aParentScene is nil" );    
    
    if( ( self = [super init] ) )
    {
        targetLayerRef = aTargetLayer;
        parentSceneRef = aParentScene;
        
        [self _init];
    }
    
    return self;
}

-(void)dealloc
{
    targetLayerRef = nil;
    parentSceneRef = nil;    
    [super dealloc];
}

#pragma mark - methods

-(void)update
{
    
}

-(void)beforeRelease
{
    MZAssert( false, @"override me" );
}

@end

@implementation MZGamePlayHUD_Base (Protected)

#pragma maek - init

-(void)_init
{
    
}

#pragma mark - methods 

//-(void)_removeFromLayer
//{
//
//}

@end