#import "MZGamePlaySceneLayerBase.h"
#import "MZGamePlayScene.h"
#import "MZLevelComponents.h"
#import "MZUtilitiesHeader.h"

@implementation MZGamePlaySceneLayerBase

@synthesize layerTypeInNSNumber;

#pragma mark - init

+(MZGamePlaySceneLayerBase *)layerWithLevelSettingDictionary:(NSDictionary *)aLevelSettingNSDictioanry parentScene:(MZGamePlayScene *)aParentScene
{
    return [[[self alloc] initWithLevelSettingDictionary: aLevelSettingNSDictioanry parentScene: aParentScene] autorelease];
}

-(id)initWithLevelSettingDictionary:(NSDictionary *)aLevelSettingNSDictioanry parentScene:(MZGamePlayScene *)aParentScene
{
    MZAssert( aLevelSettingNSDictioanry, @"aLevelSettingNSDictioanry is nil" );
    MZAssert( aParentScene, @"aParentScene is nil" );
    
    self = [super init];
    
    parentSceneRef = aParentScene;

    [self _initValues];
    [self _initWithLevelSettingDictionary: aLevelSettingNSDictioanry];
    
    return self;
}

-(void)dealloc
{
    parentSceneRef = nil;
    
    [super dealloc];
}

#pragma mark - properties

-(NSNumber *)layerTypeInNSNumber
{
    MZAssert( false, @"override me" );
    return nil;
}

#pragma mark - methods

-(void)pause
{

}

-(void)resume
{

}

-(void)update
{
    
}

-(void)beforeRelease
{

}

@end

#pragma mark

@implementation MZGamePlaySceneLayerBase (Protected)

#pragma mark - methods

-(void)_initValues
{

}

-(void)_initWithLevelSettingDictionary:(NSDictionary *)levelSettingDictionary
{
    
}

-(void)_initAfterGetLevelComponents
{

}

@end