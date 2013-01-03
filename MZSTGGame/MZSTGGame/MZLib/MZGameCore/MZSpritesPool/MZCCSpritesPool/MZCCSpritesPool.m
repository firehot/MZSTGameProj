#import "MZCCSpritesPool.h"
#import "MZGameCoreHeader.h"
#import "MZUtilitiesHeader.h"
#import "cocos2d.h"

@interface MZCCSpritesPool (Private)
-(bool)_isSpriteActive:(CCSprite *)sprite;
-(void)_setSpriteInactive:(CCSprite *)sprite;
@end

#pragma mark

@implementation MZCCSpritesPool

@synthesize framesManager = framesManagerRef;

#pragma mark - init and dealloc

+(MZCCSpritesPool *)poolWithTexture:(CCTexture2D *)aTexture
                      framesManager:(MZFramesManager *)aFramesManager
                              layer:(CCLayer *)aLayer
                             number:(int)aNumber
                          blendFunc:(ccBlendFunc)aBlendFunc

{
    return [[[self alloc] initWithTexture: aTexture framesManager: aFramesManager layer: aLayer number: aNumber blendFunc: aBlendFunc] autorelease];
}

-(id)initWithTexture:(CCTexture2D *)aTexture
       framesManager:(MZFramesManager *)aFramesManager
               layer:(CCLayer *)aLayer
              number:(int)aNumber
           blendFunc:(ccBlendFunc)aBlendFunc

{
    MZAssert( aTexture != nil, @"aTexture is nil" );
    MZAssert( aLayer != nil, @"aLayer is nil" );
    
    self = [super init];
    
    number = aNumber;
    framesManagerRef = aFramesManager;
    blendFunc = aBlendFunc;
    layerRef = aLayer;
    
    CCTexture2D *texture = aTexture;
    spriteBatchNode = [CCSpriteBatchNode batchNodeWithTexture: texture capacity: number];
    [spriteBatchNode retain];
    spriteBatchNode.blendFunc = blendFunc;
    
    spritesList = [[NSMutableArray alloc] initWithCapacity: number];
    for( int i = 0; i < number; i++ )
    {
        CCSprite *sprite = [CCSprite spriteWithTexture: spriteBatchNode.texture];
        sprite.visible = false;
        sprite.position = MZ_INVAILD_POINT;
        
        [spriteBatchNode addChild: sprite];
        [spritesList addObject: sprite];
    }
    
    [layerRef addChild: spriteBatchNode];
    
    return self;
}

-(void)dealloc
{
    [spritesList release];
    [layerRef removeChild: spriteBatchNode];
    [spriteBatchNode release];
    
    layerRef = nil;
    framesManagerRef = nil;
    
    [super dealloc];
}

#pragma mark - methods

-(CCSprite *)getSprite
{
    for( int i = 0; i < [spritesList count]; i++ )
    {
        CCSprite *sprite = [spritesList objectAtIndex: i];
        if( [self _isSpriteActive: sprite] )
        {
            sprite.scale = 1.0;
            sprite.color = ccc3( 255, 255, 255 );
            sprite.rotation = 0;
            sprite.visible = true;
            
            return sprite;
        }
    }
    
    MZAssert( false, @"can not found invaild sprite, max=%d", number );
    return nil;
}

-(void)returnSprite:(CCSprite *)sprite
{
    [sprite stopAllActions];
    [sprite removeAllChildrenWithCleanup: false]; // 理應不會發生
    
    [self _setSpriteInactive: sprite];
}

@end

#pragma mark

@implementation MZCCSpritesPool (Private)

-(bool)_isSpriteActive:(CCSprite *)sprite
{
    return ( sprite.position.x == MZ_INVAILD_POINT.x );
}

-(void)_setSpriteInactive:(CCSprite *)sprite
{
    sprite.visible = false;
    sprite.position = MZ_INVAILD_POINT;
}

@end
