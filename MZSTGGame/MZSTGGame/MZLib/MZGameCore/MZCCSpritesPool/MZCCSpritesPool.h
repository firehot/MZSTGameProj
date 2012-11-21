#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"
#import "ccTypes.h"

@class CCSprite;
@class CCLayer;

@interface MZCCSpritesPool : NSObject
{
    NSMutableDictionary *spritesPoolDictionary;
    CCLayer *layerRef;
}

-(id)initWithPoolSettingDictionary:(NSDictionary *)aPoolSettingDictionary layer:(CCLayer *)aLayer;
-(CCSprite *)getSpriteByType:(MZCharacterType)characterType;
-(void)returnSprite:(CCSprite *)sprite;

+(NSDictionary *)__testBatchNodeSettingWithNumber:(int)number textureName:(NSString *)textureName usingBlend:(bool)usingBlend;

@end
