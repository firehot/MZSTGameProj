#import "MZCCSpritesPool.h"
#import "MZGameCoreHeader.h"
#import "MZGameSettingsHeader.h"
#import "MZLogMacro.h"
#import "MZGLHelper.h"
#import "cocos2d.h"

@interface MZCCSpritesPool (Private)

-(void)_initSpritesPoolWithPoolSettingDictionary:(NSDictionary *)poolSettingDictionary;

-(CCSpriteBatchNode *)_getNewSpriteBatchNodeWithSettingDictionary:(NSDictionary *)settingDictionary;
-(void)_releaseSpritesInArray:(NSArray *)spritesArray;

-(void)_setInvaildStateToSprite:(CCSprite *)sprite;
-(bool)_isInvaildStateOfSprite:(CCSprite *)sprite;

@end

#pragma mark

@implementation MZCCSpritesPool

#pragma mark - init and dealloc

-(id)initWithPoolSettingDictionary:(NSDictionary *)aPoolSettingDictionary layer:(CCLayer *)aLayer;
{
    MZAssert( aPoolSettingDictionary, @"poolSettingDictionary is nil" );
    MZAssert( aLayer, @"aLayer is nil" );
    
    self = [super init];
    if( self == nil ) return nil;
    
    layerRef = aLayer;
    [self _initSpritesPoolWithPoolSettingDictionary: aPoolSettingDictionary];
    
    return self;
}

-(void)dealloc
{
    for( CCSpriteBatchNode *batchNode in [spritesPoolDictionary allValues] ) 
    {
        for( CCSprite *s in [batchNode children] ) [s stopAllActions];
        [layerRef removeChild: batchNode cleanup: false];
    }
    
    [spritesPoolDictionary release];
    
    [super dealloc];
}

#pragma mark - methods

-(CCSprite *)getSpriteByType:(MZCharacterType)characterType
{   
    CCSpriteBatchNode *spriteBatchNode = [spritesPoolDictionary objectForKey: [NSNumber numberWithInt: characterType]];
    MZAssert( spriteBatchNode, @"spriteBatchNode is nil" );
    
    for( CCSprite *sprite in [spriteBatchNode children] )
    {
        if( [self _isInvaildStateOfSprite: sprite] )
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
    
    [self _setInvaildStateToSprite: sprite];
}

#pragma mark - test

+(NSDictionary *)__testBatchNodeSettingWithNumber:(int)number textureName:(NSString *)textureName usingBlend:(bool)usingBlend
{
    NSMutableDictionary *setting = [NSMutableDictionary dictionaryWithCapacity: 0];
    [setting setObject: textureName forKey: @"TextureName"];
    [setting setObject: [NSNumber numberWithInt: number] forKey: @"Number"];
    
    if( usingBlend )
    {
        [setting setObject: @"GL_ONE" forKey: @"BlendSrc"];
        [setting setObject: @"GL_ONE" forKey: @"BlendDst"];
    }
    
    return setting;
}

@end

#pragma mark

@implementation MZCCSpritesPool (Private)

#pragma mark - init

-(void)_initSpritesPoolWithPoolSettingDictionary:(NSDictionary *)poolSettingDictionary
{
    NSDictionary *batchNodeSettingsDictionary = [poolSettingDictionary objectForKey: @"BatchNodeSetting"];
    NSArray *addOrderArray = [poolSettingDictionary objectForKey: @"AddOrder"];
    
    spritesPoolDictionary = [[NSMutableDictionary alloc] initWithCapacity: 1];
    
    for( int i = 0; i < [addOrderArray count]; i++ )
    {
        NSNumber *characterType = [addOrderArray objectAtIndex: i];
        MZAssert( [batchNodeSettingsDictionary objectForKey: characterType], @"Can not found number of type in batchNodeSettingsDictionary" );
        
        NSDictionary *batchNodeSettingDictionary = [batchNodeSettingsDictionary objectForKey: characterType];
        
        CCSpriteBatchNode *spriteBatchNode = [self _getNewSpriteBatchNodeWithSettingDictionary: batchNodeSettingDictionary];
        
        ( [MZGameSetting sharedInstance].debug.drawCollisionRange )?
        [layerRef addChild: spriteBatchNode z: -1] : [layerRef addChild: spriteBatchNode];
        
        [spritesPoolDictionary setObject: spriteBatchNode forKey: characterType];
    }
}

#pragma mark - methods

-(CCSpriteBatchNode *)_getNewSpriteBatchNodeWithSettingDictionary:(NSDictionary *)settingDictionary
{
    int numbers = [[settingDictionary objectForKey: @"Number"] intValue];
    NSString *textureName = [settingDictionary objectForKey: @"TextureName"];
    
    CCTexture2D *texture = [[MZFramesManager sharedFramesManager] textureByName: textureName];
    
    CCSpriteBatchNode *spriteBatchNode = [CCSpriteBatchNode batchNodeWithTexture: texture capacity: numbers];
    
    if( [settingDictionary objectForKey: @"BlendSrc"] && [settingDictionary objectForKey: @"BlendDst"] )
    {
        ccBlendFunc blendFunc = (ccBlendFunc)
        {
            [MZGLHelper glBlendEnumFromString: [settingDictionary objectForKey: @"BlendSrc"]],
            [MZGLHelper glBlendEnumFromString: [settingDictionary objectForKey: @"BlendDst"]]
        };
        
        spriteBatchNode.blendFunc = blendFunc;
    }
		 
    for( int i = 0; i < numbers; i++ )
    {
        CCSprite *sprite = [CCSprite spriteWithTexture: spriteBatchNode.texture];
        sprite.visible = false;
        sprite.position = MZ_INVAILD_POINT;
        [spriteBatchNode addChild: sprite];
    }
    
    return spriteBatchNode;
}

-(void)_releaseSpritesInArray:(NSArray *)spritesArray
{
    MZAssert( layerRef, @"layerRef is nil, can not release sprites" );
    
    for( CCSprite *sprite in spritesArray )
        [layerRef removeChild: sprite cleanup: false];
}

-(void)_setInvaildStateToSprite:(CCSprite *)sprite
{
    sprite.visible = false;
    sprite.position = MZ_INVAILD_POINT;
}

-(bool)_isInvaildStateOfSprite:(CCSprite *)sprite
{
    return ( sprite.position.x == MZ_INVAILD_POINT.x );
}

@end