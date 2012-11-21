#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class CCSpriteFrame;

@interface MZFrame : NSObject
{

}
+(MZFrame *)frameControlWithFrameName:(NSString *)aFrameName;
-(id)initWithWithFrameName:(NSString *)aFrameName;

@property (nonatomic, readonly) CGSize frameSize;
@property (nonatomic, readonly) NSString *frameName;
@property (nonatomic, readonly) CCSpriteFrame *frame;

@end
