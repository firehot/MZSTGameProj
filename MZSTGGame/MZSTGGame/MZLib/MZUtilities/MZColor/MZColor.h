#import <Foundation/Foundation.h>

@interface MZColor : NSObject
+(MZColor *)colorWithRed:(int)aRed green:(int)aGreen blue:(int)aBlue;
-(id)initWithRed:(int)aRed green:(int)aGreen blue:(int)aBlue;
@property (nonatomic, readwrite) int red;
@property (nonatomic, readwrite) int green;
@property (nonatomic, readwrite) int blue;
@end
