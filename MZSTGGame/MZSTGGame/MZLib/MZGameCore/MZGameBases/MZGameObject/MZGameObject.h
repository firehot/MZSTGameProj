#import "MZBehavior_Base.h"
#import "MZTypeDefine.h"
#import "MZCollision.h"
#import "CCTexture2D.h"
#import "ccTypes.h"

@class MZColor;
@class MZCCSpritesPool;
@class CCNode;
@class CCLayer;
@class CCSprite;
@class CCAction;

@interface MZGameObject : MZBehavior_Base <MZCollisionProtocol>
{
@private
    int depth;
    ccBlendFunc tempBlendFunc;
    CGPoint position;
    
    MZCCSpritesPool *spritesPoolRef;
    CCLayer *spriteParentLayerRef;
    CCSprite *spriteRef;
@protected
}

+(MZGameObject *)gameObject;

//
-(void)setPropertiesWithDictionary:(NSDictionary *)propertiesDictionary;

// sprite
-(void)setSpriteFromPool:(MZCCSpritesPool *)aSpritesPool characterType:(MZCharacterType)type;
-(void)setSprite:(CCSprite *)aSprite parentLayer:(CCLayer *)aParentLayer depth:(int)aDepth;
-(void)releaseSprite;

//
-(void)addCollisionCircle:(MZCircle *)circle;
-(void)drawCollision;
-(bool)isCollisionWithOtherGameObject:(MZGameObject *)otherGameObject;

//
-(void)updatePosition;

//
-(void)setFrameWithFrameName:(NSString *)frameName;
-(void)playAnimationWithAnimationName:(NSString *)animationName isRepeatForever:(bool)isRepeatForever;

//
-(bool)isInnerScreen;

//
-(void)setBlendFunc:(ccBlendFunc)blendFunc;
-(void)setTexParameters:(ccTexParams*)texParams;

//
-(CCAction *)runAction:(CCAction *)action;
-(void)stopAllActions;

@property (nonatomic, readwrite) bool visible;
@property (nonatomic, readwrite) bool flipX;
@property (nonatomic, readwrite) bool flipY;
@property (nonatomic, readwrite) GLubyte opacity;
@property (nonatomic, readonly) GLenum blendSrc;
@property (nonatomic, readonly) GLenum blendDest;
@property (nonatomic, readwrite) float scale;
@property (nonatomic, readwrite) float scaleX;
@property (nonatomic, readwrite) float scaleY;
@property (nonatomic, readwrite) float rotation;
@property (nonatomic, readwrite) CGPoint position;
@property (nonatomic, readonly) CGPoint standardPosition;
@property (nonatomic, readonly) CGPoint realPosition;
@property (nonatomic, readonly) CGPoint currentMovingVector;
@property (nonatomic, readonly) CGPoint spawnPosition;
@property (nonatomic, readonly) CGSize frameSize;
@property (nonatomic, readwrite) ccColor3B color;
@property (nonatomic, readonly) CCSprite *sprite;
@property (nonatomic, readwrite, retain) MZColor *collisionColor;
@property (nonatomic, readonly) MZCollision *collision;

@end

@interface MZGameObject (Protected)
@end

/*
 更名候選: MZCCSpriteObject
 */