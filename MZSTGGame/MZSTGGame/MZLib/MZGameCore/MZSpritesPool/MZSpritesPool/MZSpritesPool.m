#import "MZSpritesPool.h"
#import "MZGameCoreHeader.h"
#import "MZUtilitiesHeader.h"
#import "cocos2d.h"

@interface MZSpritesPool (Private)
-(bool)_isSpriteActive:(CCSprite *)sprite;
-(void)_setSpriteInactive:(CCSprite *)sprite;
@end

#pragma mark

@implementation MZSpritesPool

#pragma mark - init and dealloc

-(id)initWithTextureName:(NSString *)aTextureName layer:(CCLayer *)aLayer number:(int)aNumber blendFunc:(ccBlendFunc)aBlendFunc
{
    MZAssert( aTextureName, @"aTextureName is nil" );
    MZAssert( aLayer, @"aLayer is nil" );
    
    self = [super init];
    
    number = aNumber;
    blendFunc = aBlendFunc;
    textureName = aTextureName;
    [textureName retain];
    layerRef = aLayer;
    
    CCTexture2D *texture = [[MZFramesManager sharedInstance] textureByName: textureName];
    MZAssert( texture != nil, @"texture can't found(%@)", textureName );
    
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
    
    [textureName release];
    
    layerRef = nil;
    
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
    
    MZAssert( false, @"can not found invaild sprite" );
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

@implementation MZSpritesPool (Private)

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
