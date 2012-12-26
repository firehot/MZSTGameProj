#import <Foundation/Foundation.h>
#import "ccTypes.h"

@class CCLayer;
@class CCSpriteBatchNode;
@class CCSprite;

@interface MZCCSpritesPool : NSObject
{
    int number;
    ccBlendFunc blendFunc;
    NSString *textureName;
    NSMutableArray *spritesList;
    CCSpriteBatchNode *spriteBatchNode;
    
    CCLayer *layerRef;
}

-(id)initWithTextureName:(NSString *)aTextureName layer:(CCLayer *)aLayer number:(int)aNumber blendFunc:(ccBlendFunc)aBlendFunc;

-(CCSprite *)getSprite;
-(void)returnSprite:(CCSprite *)sprite;

@end

/*
 投入其他的尋找有效 Sprite 方法?
*/
