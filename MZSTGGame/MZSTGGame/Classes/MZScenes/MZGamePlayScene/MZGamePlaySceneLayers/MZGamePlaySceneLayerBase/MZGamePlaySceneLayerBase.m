#import "MZGamePlaySceneLayerBase.h"
#import "MZGamePlayScene.h"
#import "MZLevelComponents.h"
#import "MZUtilitiesHeader.h"

@implementation MZGamePlaySceneLayerBase

@synthesize layerTypeInNSNumber;

#pragma mark - init

+(MZGamePlaySceneLayerBase *)layerWithLevelSettingDictionary:(NSDictionary *)aLevelSettingDictioanry parentScene:(MZGamePlayScene *)aParentScene
{
    return [[[self alloc] initWithLevelSettingDictionary: aLevelSettingDictioanry parentScene: aParentScene] autorelease];
}

-(id)initWithLevelSettingDictionary:(NSDictionary *)aLevelSettingDictioanry parentScene:(MZGamePlayScene *)aParentScene
{
    MZAssert( aLevelSettingDictioanry, @"aLevelSettingNSDictioanry is nil" );
    MZAssert( aParentScene, @"aParentScene is nil" );
    
    self = [super init];
    
    parentSceneRef = aParentScene;

    [self _initValues];
    [self _initWithLevelSettingDictionary: aLevelSettingDictioanry];
    
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