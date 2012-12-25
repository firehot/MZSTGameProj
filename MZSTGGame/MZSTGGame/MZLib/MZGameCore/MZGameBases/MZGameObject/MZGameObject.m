#import "MZGameObject.h"
#import "MZObjectHelper.h"
#import "MZLevelComponentsHeader.h"
#import "MZAnimationHeader.h"
#import "MZGameSettingsHeader.h"
#import "MZColor.h"
#import "MZCollision.h"
#import "MZCCDisplayHelper.h"
#import "MZCGPointMacro.h"
#import "MZTypeDefine.h"
#import "MZLogMacro.h"
#import "MZCCUtilitiesHeader.h"
#import "MZGLHelper.h"
#import "CCSprite.h"

@interface MZGameObject (Private)
-(bool)_isSpriteFrameInnerScreen;
@end

@implementation MZGameObject

#pragma mark - init and dealloc

@synthesize visible;
@synthesize flipX;
@synthesize flipY;
@synthesize opacity;
@synthesize blendSrc;
@synthesize blendDest;
@synthesize scale;
@synthesize scaleX;
@synthesize scaleY;
@synthesize rotation;
@synthesize position;
@synthesize standardPosition;
@synthesize spawnPosition;
@synthesize realPosition;
@synthesize currentMovingVector;
@synthesize frameSize;
@synthesize sprite = spriteRef;
@synthesize color;
@synthesize collisionColor;
@synthesize collision;

+(MZGameObject *)gameObjectWithLevelComponenets:(MZLevelComponents *)aLevelComponents
{
    return [[[self alloc] initWithLevelComponenets: aLevelComponents] autorelease];
}

-(id)initWithLevelComponenets:(MZLevelComponents *)aLevelComponents
{
    self = [super initWithLevelComponenets: aLevelComponents];
    return self;
}

-(void)dealloc
{
    [self releaseSprite];
    [collisionColor release];
    [collision release];
    
    [super dealloc];
}

#pragma mark - MZCollisionProtocol

-(CGPoint)getRealPosition
{
    return spriteRef.position;
}

#pragma mark - properties

-(void)setOpacity:(GLubyte)aOpacity
{
    opacity = aOpacity;
    if( spriteRef ) spriteRef.opacity = aOpacity;
}

-(GLubyte)opacity
{
//    return spriteRef.opacity;
    return opacity;
}

-(GLenum)blendSrc
{
    return spriteRef.blendFunc.src;
}

-(void)setVisible:(bool)aVisible
{
    visible = aVisible;
    if( spriteRef ) spriteRef.visible = aVisible;
    for( MZGameObject *child in [childrenDictionary allValues] ) child.visible = aVisible;
}

-(bool)visible
{
    return visible;
}

-(void)setFlipX:(bool)aFlipX
{
    if( spriteRef ) spriteRef.flipX = aFlipX;
    flipX = aFlipX;
}

-(bool)flipX
{
    return flipX;
}

-(void)setFlipY:(bool)aFlipY
{
    if( spriteRef ) spriteRef.flipY = aFlipY;
    flipY = aFlipY;
}

-(bool)flipY
{
    return flipY;
}

-(void)setScale:(float)aScale
{
    scale = aScale;
    if( spriteRef ) spriteRef.scale = aScale; 
}

-(float)scale
{
    return scale; 
}

-(void)setScaleX:(float)aScaleX 
{
    scaleX = aScaleX;
    if( spriteRef ) spriteRef.scaleX = aScaleX; 
}

-(float)scaleX
{
    return scaleX; 
}

-(void)setScaleY:(float)aScaleY
{
    if( spriteRef ) spriteRef.scaleY = aScaleY; 
}

-(float)scaleY 
{
    return scaleY;
}

-(void)setRotation:(float)aRotation 
{ 
    if( spriteRef ) spriteRef.rotation = aRotation;
    for( MZGameObject *child in [childrenDictionary allValues] )
        child.rotation = aRotation;
}

-(float)rotation
{
    return rotation; 
}

-(void)setPosition:(CGPoint)aPosition 
{    
    position = aPosition;
    [self updatePosition];
    
    for( MZGameObject *child in [childrenDictionary allValues] )
        [child updatePosition];
}

-(CGPoint)position 
{
    return position;
}

-(CGPoint)realPosition
{
//    return spriteRef.position;
    return [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: position];
}

-(void)setColor:(ccColor3B)aColor
{
//    MZAssert( spriteRef, @"spriteRef is nil" );
    color = aColor;
    if( spriteRef ) spriteRef.color = aColor;
}

-(ccColor3B)color
{
//    MZAssert( spriteRef, @"spriteRef is nil" );
//    return spriteRef.color;
    return color;
}

#pragma mark - override

-(void)addChild:(MZBehavior_Base *)child name:(NSString *)name
{
    ((MZGameObject *)child).collisionColor = collisionColor;
    [super addChild: child name: name];
}

#pragma mark - methods

-(void)setPropertiesWithDictionary:(NSDictionary *)propertiesDictionary
{
    MZAssert( spriteRef, @"spriteRef must be assign first" );
    
    CGPoint position_ = CGPointFromString( [propertiesDictionary objectForKey: @"position"] );
    NSString *textureName_ = [propertiesDictionary objectForKey: @"textureName"];
    float scaleX_ = ( [propertiesDictionary objectForKey: @"scaleX"] )? [[propertiesDictionary objectForKey: @"scaleX"] floatValue] : 1.0;
    float scaleY_ = ( [propertiesDictionary objectForKey: @"scaleY"] )? [[propertiesDictionary objectForKey: @"scaleY"] floatValue] : 1.0;
    float scale_ = ( [propertiesDictionary objectForKey: @"scale"] )? [[propertiesDictionary objectForKey: @"scale"] floatValue] : 1.0;
    float rotation_ = ( [propertiesDictionary objectForKey: @"rotation"] )? [[propertiesDictionary objectForKey: @"rotation"] floatValue] : 0.0;
    int opacity_ = ( [propertiesDictionary objectForKey: @"opacity"] )? [[propertiesDictionary objectForKey: @"opacity"] intValue]: 255;
    bool flipX_ = ( [propertiesDictionary objectForKey: @"flipX"] )? [[propertiesDictionary objectForKey: @"flipX"] boolValue]: false;
    bool flipY_ = ( [propertiesDictionary objectForKey: @"flipY"] )? [[propertiesDictionary objectForKey: @"flipY"] boolValue]: false;
    ccColor3B color_ = [MZCCColorHelper color3BFromString: [propertiesDictionary objectForKey: @"color"]];

    GLenum blendFuncSrc_ = ( [propertiesDictionary objectForKey: @"blendFuncSrc"] )?
    [MZGLHelper glBlendEnumFromString: [propertiesDictionary objectForKey: @"blendFuncSrc"]] : [MZGLHelper defaultBlendFuncSrc];
    GLenum blendFuncDest_ = ( [propertiesDictionary objectForKey: @"blendFuncDest"] )?
    [MZGLHelper glBlendEnumFromString: [propertiesDictionary objectForKey: @"blendFuncDest"]] : [MZGLHelper defaultBlendFuncDest];

    [self setFrameWithFrameName: textureName_];
    self.scaleX = scaleX_;
    self.scaleY = scaleY_;
    if( scaleX_ == 1 && scaleY_ == 1 ) self.scale = scale_;
    self.rotation = rotation_;
    self.opacity = opacity_;
    self.color = color_;
    self.position = position_;
    self.flipX = flipX_;
    self.flipY = flipY_;
    [self setBlendFunc: (ccBlendFunc){ blendFuncSrc_, blendFuncDest_ }];
}

-(void)setSpriteFromPool:(MZCCSpritesPool *)aSpritesPool characterType:(MZCharacterType)type
{
    MZAssert( spriteRef == nil, @"spriteRef is not nil, please remove it first" );
    MZAssert( spritesPoolRef == nil, @"spritesPoolRef is not nil, please remove it first" );
    
    MZAssert( aSpritesPool, @"aSpritesPool is nil" );
    
    spritesPoolRef = aSpritesPool;
    spriteRef = [spritesPoolRef getSpriteByType: type];
}

-(void)setSprite:(CCSprite *)aSprite parentLayer:(CCLayer *)aParentLayer
{
    MZAssert( spriteRef == nil, @"spriteRef is not nil, please remove it first" );
    MZAssert( spriteParentLayerRef == nil, @"spriteParentLayerRef is not nil, please remove it first" );
    
    MZAssert( aSprite, @"aSprite is nil" );
    MZAssert( aParentLayer, @"aParentLayer is nil" );
    
    spriteParentLayerRef = aParentLayer;
    spriteRef = aSprite;
    
    if( [[spriteParentLayerRef children] containsObject: spriteRef] == false )
    {
        [spriteParentLayerRef addChild: spriteRef];
    }
}

-(void)releaseSprite
{
    if( spriteRef != nil )
    {
        [spriteRef stopAllActions];
        
        MZAssert( ( spritesPoolRef == nil ^ spriteParentLayerRef == nil ), @"unknow sprite come from" );
        
        if( spritesPoolRef )
        {
            [spritesPoolRef returnSprite: spriteRef];
            spritesPoolRef = nil;
        }
        else if( spriteParentLayerRef )
        {
            [spriteParentLayerRef removeChild: spriteRef cleanup: false];
            spriteParentLayerRef = nil;
        }
        
        spriteRef = nil;
    }
    
    for( MZGameObject *child in [childrenDictionary allValues] )
        [child releaseSprite];
}

-(void)addCollisionCircle:(MZCircle *)circle
{
    if( collision == nil )
        collision = [[MZCollision alloc] initWithCollisionTarget: self];
    
    [collision addCircularCollision: circle];
}

-(void)drawCollision
{    
    [collision drawRangeWithMZColor: collisionColor];
    
    for( MZGameObject *child in [childrenDictionary allValues] )
        [child drawCollision];
}

-(bool)isCollisionWithOtherGameObject:(MZGameObject *)otherGameObject
{
    // 希望能升級為 protocol
    if( [collision isCollisionWithOther: otherGameObject.collision] )
        return true;
    
    for( MZGameObject *selfChild in [childrenDictionary allValues] )
    {
        for( MZGameObject *otherChild in [otherGameObject.childrenDictionary allValues] )
        {
            if( [selfChild.collision isCollisionWithOther: otherChild.collision] )
                return true;
        }
    }
    
    return false;
}

-(void)updatePosition
{
    CGPoint parentStandardPosition = ( parentRef != nil )? ((MZGameObject *)parentRef).standardPosition : CGPointZero;
    standardPosition = mzpAdd( parentStandardPosition, position );
    
    if( spriteRef ) spriteRef.position = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: standardPosition];
}

-(void)setFrameWithFrameName:(NSString *)frameName
{
    MZAssert( spriteRef, @"spriteRef is nil" );
    
    MZFrame *frameControl = [[MZFramesManager sharedInstance] frameByName: frameName];
    MZAssert( frameControl, @"FrameControl(%@) is nil", frameName );
    
    frameSize = frameControl.frameSize;
    [spriteRef setDisplayFrame: frameControl.frame];
    spriteRef.blendFunc = tempBlendFunc;
}

-(void)playAnimationWithAnimationName:(NSString *)animationName isRepeatForever:(bool)isRepeatForever
{
    MZAssert( spriteRef, @"spriteRef is nil" );
    
    MZAnimation *animationControl = [[MZAnimationsManager sharedInstance] getAnimationControlWithAnimationName: animationName];
    MZAssert( animationControl, @"AnimationControl(%@), is nil", animationName );
    
    frameSize = animationControl.frameSize; 
    [spriteRef setDisplayFrameWithAnimationName: animationName index: 0];
    [spriteRef runAction: [animationControl getAnimationSequenceIsRepeatForever: isRepeatForever]];
    spriteRef.blendFunc = tempBlendFunc;
}

-(bool)isInnerScreen
{    
    if( [self _isSpriteFrameInnerScreen] )
        return true;
    
    for( MZGameObject *child in [childrenDictionary allValues] )
    {
        if( [child isInnerScreen] )
            return true;
    }
    
    return false;
}

-(void)setBlendFunc:(ccBlendFunc)blendFunc
{
    MZAssert( spritesPoolRef == nil, @"sprite is come from pool, blendFunc can't assign" );
    
    tempBlendFunc = blendFunc;
    spriteRef.blendFunc = (ccBlendFunc){ blendFunc.src, blendFunc.dst };
}

-(void)setTexParameters:(ccTexParams*)texParams
{
    MZAssert( spriteRef, @"spriteRef must not nil" );
    MZAssert( spriteRef.texture, @"spriteRef.texture must not nil" );
    
    [spriteRef.texture setTexParameters: texParams];
}

-(CCAction *)runAction:(CCAction *)action
{
    return [spriteRef runAction: action];
}

-(void)stopAllActions
{
    [spriteRef stopAllActions];
}

@end

#pragma mark

@implementation MZGameObject (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    
    frameSize = CGSizeZero;
    tempBlendFunc = (ccBlendFunc){ [MZGLHelper defaultBlendFuncSrc], [MZGLHelper defaultBlendFuncDest] };
}

@end

#pragma mark

@implementation MZGameObject (Private)

#pragma mark - init

-(bool)_isSpriteFrameInnerScreen
{
    CGSize screenSize = [MZGameSetting sharedInstance].system.playRange.size;
    CGSize halfFrameSize = CGSizeMake( frameSize.width/2,frameSize.height/2 );
    
    CGPoint currentPosition = self.standardPosition;
    if( currentPosition.x + halfFrameSize.width < 0 || 
       currentPosition.x - halfFrameSize.width > screenSize.width ||
       currentPosition.y + halfFrameSize.height < 0 ||
       currentPosition.y - halfFrameSize.height > screenSize.height )
        return false;
    
    return true;
}

@end