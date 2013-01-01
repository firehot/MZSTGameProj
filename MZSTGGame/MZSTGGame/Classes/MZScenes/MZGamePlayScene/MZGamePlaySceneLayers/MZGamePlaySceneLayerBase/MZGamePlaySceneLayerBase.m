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

-(int)addSpritesPool:(MZCCSpritesPool *)spritesPool key:(int)key
{
    if( spritesPoolByActorTypeDictionary == nil )
        spritesPoolByActorTypeDictionary = [[NSMutableDictionary alloc] initWithCapacity: 0];
    
    [spritesPoolByActorTypeDictionary setObject: spritesPool forKey: [NSNumber numberWithInt: key]];
    
    return [[spritesPoolByActorTypeDictionary allValues] count];
}

-(MZCCSpritesPool *)spritesPoolByKey:(int)key
{
    if( spritesPoolByActorTypeDictionary == nil )
        return nil;
    
    NSNumber *nsKey = [NSNumber numberWithInt: key];
    MZAssert( [spritesPoolByActorTypeDictionary objectForKey: nsKey], @"Key=%d, not exist", key );
    
    return spritesPoolByActorTypeDictionary[[NSNumber numberWithInt: key]];
}

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
    [spritesPoolByActorTypeDictionary release]; // is safe??? maybe character not remove LOL
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