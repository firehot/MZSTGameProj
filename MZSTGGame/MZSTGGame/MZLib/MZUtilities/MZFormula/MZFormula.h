/*
 2011.12.14: 增加代 x 得 y, y 得 x, 修正部份邏輯
 */

#import <Foundation/Foundation.h>

// ax + by + c = 0
@interface MZFormula : NSObject 
{
	float a;
	float b;
	float c;
}

+(MZFormula *)formulaWithPoint1:(CGPoint)p1 point2:(CGPoint)p2;
-(id)initWithPoint1:(CGPoint)p1 point2:(CGPoint)p2;
-(float)getResult:(CGPoint)p;
-(float)getResultWithX:(float)x y:(float)y;
-(float)getXWithY:(float)y;
-(float)getYWithX:(float)x;

@property (nonatomic, readonly) bool isDoNotCare;
@property (nonatomic, readwrite, assign) float a;
@property (nonatomic, readwrite, assign) float b;
@property (nonatomic, readwrite, assign) float c;

@end
