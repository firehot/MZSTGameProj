#import <Foundation/Foundation.h>
#import "ccTypes.h"

@class CCLayer;
@class CCSpriteBatchNode;
@class CCSprite;
@class CCTexture2D;
@class MZFramesManager;

@interface MZCCSpritesPool : NSObject
{
    int number;
    ccBlendFunc blendFunc;
    NSMutableArray *spritesList;
    CCSpriteBatchNode *spriteBatchNode;
    
    CCLayer *layerRef;
    MZFramesManager *framesManagerRef;
}

+(MZCCSpritesPool *)poolWithTexture:(CCTexture2D *)aTexture
                      framesManager:(MZFramesManager *)aFramesManager
                              layer:(CCLayer *)aLayer
                             number:(int)aNumber
                          blendFunc:(ccBlendFunc)aBlendFunc;
-(id)initWithTexture:(CCTexture2D *)aTexture
       framesManager:(MZFramesManager *)aFramesManager
               layer:(CCLayer *)aLayer
              number:(int)aNumber
           blendFunc:(ccBlendFunc)aBlendFunc;

-(CCSprite *)getSprite;
-(void)returnSprite:(CCSprite *)sprite;

@property (nonatomic, readonly) MZFramesManager *framesManager;

@end

/*
 投入其他的尋找有效 Sprite 方法?
*/
