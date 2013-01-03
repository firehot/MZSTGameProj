#import "MZBgFeatureControl_Nebula.h"
#import "MZGameCoreHeader.h"
#import "MZUtilitiesHeader.h"
#import "MZCCUtilitiesHeader.h"
#import "MZCCSpritesPool.h"
#import "MZTypeDefine.h"
#import "MZGamePlayBackgroundLayer.h"
#import "cocos2d.h"

@interface MZBgFeatureControl_Nebula (Private)
-(void)_updateUsingStatePushUpAlg;
-(void)_setNewLayer;
-(void)_pushUpUnderLayerStateWithLayerIndex:(int)layerIndex;
-(CGRect)_getRandomTextureRect;
@end

#pragma mark

@implementation MZBgFeatureControl_Nebula

#pragma mark - init and dealloc

-(void)dealloc
{
    for( CCSprite *s in nebulaSpritesArray )
        [spritesPool returnSprite: s];
    [nebulaSpritesArray release];
    [spritesPool release];
    
    [super dealloc];
}

@end

#pragma mark

@implementation MZBgFeatureControl_Nebula (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    
    NEBULA_TIME_PER_LAYER = 3.0;
    
    NSDictionary *batchNodeSettingsDictionary =
    [NSDictionary dictionaryWithObjectsAndKeys:
     [MZCCSpritesPool __testBatchNodeSettingWithNumber: 10 textureName: @"nebula.png"  usingBlend: false],
     [NSNumber numberWithInt: kMZCharacterType_Background],
     nil];
    
    NSArray *addOrder = [NSArray arrayWithObjects: [NSNumber numberWithInt: kMZCharacterType_Background], nil];
    
    NSDictionary *poolSettingDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                           batchNodeSettingsDictionary, @"BatchNodeSetting",
                                           addOrder, @"AddOrder",
                                           nil];
    
    // 其實不該這邊初始化的說 ...
    spritesPool = [[MZCCSpritesPool alloc] initWithPoolSettingDictionary: poolSettingDictionary layer: parentLayerRef];
    nebulaSpritesArray = [[NSMutableArray alloc] initWithCapacity: 0];
    for( int i = 0; i < 3; i++ )
    {
        CCSprite *nebulaSprite = [spritesPool getSpriteByType: kMZCharacterType_Background];
        nebulaSprite.position = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: CGPointMake( 160, 240 )];
//        nebulaSprite.scaleX = [MZCCDisplayHelper sharedDisplayHelper].realScreenSize.width/nebulaSprite.contentSize.width;
//        nebulaSprite.scaleY = [MZCCDisplayHelper sharedDisplayHelper].realScreenSize.height/nebulaSprite.contentSize.height;
        nebulaSprite.color = ccc3( 125, 125, 125 );
        
        [nebulaSpritesArray addObject: nebulaSprite];
    }
}

-(void)_update
{
    [super _update];
    [self _updateUsingStatePushUpAlg];
}

@end

#pragma mark

@implementation MZBgFeatureControl_Nebula (Private)

#pragma mark - methods

-(void)_updateUsingStatePushUpAlg
{
    if( nebulaSpritesArray == nil ) return;
    
    layerSpawnTimeCount -= [MZTime sharedInstance].deltaTime;
    
    if( layerSpawnTimeCount <= 0 )
    {
        for( int i = [nebulaSpritesArray count] - 1; i >= 0; i-- )
        {
            ( i == 0 )? [self _setNewLayer] : [self _pushUpUnderLayerStateWithLayerIndex: i];
        }
        
        layerSpawnTimeCount += NEBULA_TIME_PER_LAYER;
    }
}

-(void)_setNewLayer
{
    float startScale = 1.5;
    float toLayer1Scale = 2.0;
    
    CCSprite *currentLayer = [nebulaSpritesArray objectAtIndex: 0];
    [currentLayer stopAllActions];
    
    currentLayer.scale = startScale;
    currentLayer.visible = true;
    currentLayer.opacity = 0;
    currentLayer.textureRect = [self _getRandomTextureRect];
    
    CCFadeIn *fadeIn = [CCFadeIn actionWithDuration: NEBULA_TIME_PER_LAYER];
    CCScaleTo *scaleToOne = [CCScaleTo actionWithDuration: NEBULA_TIME_PER_LAYER scale: toLayer1Scale];
    
    [currentLayer runAction: [CCSpawn actions: fadeIn, scaleToOne, nil]];
}

-(void)_pushUpUnderLayerStateWithLayerIndex:(int)layerIndex
{
    float toLayer2Scale = 2.5;
    float toLayer3Scale = 3.0;
    
    MZAssert( 0 < layerIndex && layerIndex < [nebulaSpritesArray count] , @"layerIndex(%d) is illegal", layerIndex );
    
    CCSprite *underLayer = [nebulaSpritesArray objectAtIndex: layerIndex - 1];
    if( underLayer.visible == false ) return;
    
    CCSprite *currentLayer = [nebulaSpritesArray objectAtIndex: layerIndex];
    
    currentLayer.visible = underLayer.visible;
    currentLayer.textureRect = underLayer.textureRect;
    currentLayer.opacity = underLayer.opacity;
    currentLayer.scale = underLayer.scale;
    
    int opacity = ( layerIndex == 2 )? 0 : 127; // 待修改 ...
    float scale = ( layerIndex == 2 )? toLayer3Scale : toLayer2Scale;
    
    CCFadeTo *fadeOut = [CCFadeTo actionWithDuration: NEBULA_TIME_PER_LAYER opacity: opacity/*underLayer.opacity/2*/];
    CCScaleTo *scaleUp = [CCScaleTo actionWithDuration: NEBULA_TIME_PER_LAYER scale: scale/*currentLayer.scale + 0.5*/];
    CCSpawn *action = [CCSpawn actions: fadeOut, scaleUp, nil];
    
    [currentLayer stopAllActions];
    [currentLayer runAction: action];
}

-(CGRect)_getRandomTextureRect
{
    return CGRectMake( 0, 0, 256, 256 );
    //    return CGRectMake( arc4random()%200, arc4random()%200, 100, 100 );
}

@end

