#import <Foundation/Foundation.h>
#import "ccTypes.h"

@class CCDrawNode;

@interface MZCCDrawPrimitivesHelper : NSObject
+(void)drawRect:(CGRect)rect lineWidth:(GLfloat)lineWidth color:(ccColor4B)color;
+(CCDrawNode *)createNodeWithRect:(CGRect)rect lineWidth:(GLfloat)lineWidth color:(ccColor4F)color;
+(void)addToDrawNode:(CCDrawNode **)drawNode withRect:(CGRect)rect lineWidth:(GLfloat)lineWidth color:(ccColor4F)color;
+(void)addToDrawNode:(CCDrawNode **)drawNode withStdRect:(CGRect)stdRect lineWidth:(GLfloat)lineWidth color:(ccColor4F)color;
@end
