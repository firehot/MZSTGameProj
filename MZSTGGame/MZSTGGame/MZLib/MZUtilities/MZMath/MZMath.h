#import <Foundation/Foundation.h>
#import "MZFormula.h"

@interface MZMath : NSObject

+(bool)isPoint0:(CGPoint)p0 innerTriangleWithTopPoint1:(CGPoint)p1 point2:(CGPoint)p2 point3:(CGPoint)p3;
+(bool)isPoint:(CGPoint)point inCircle:(CGPoint)center radius:(float)radius;
+(bool)isPointValid:(CGPoint)point;

+(int)randomIntInRangeMin:(int)min max:(int)max;

+(float)radiansToDegree:(float)radians;
+(float)degreesFromRadians:(float)radians;
+(float)degreesToRadians:(float)degrees;
+(float)radiansFromDegrees:(float)degrees;

+(float)lengthOfVector:(CGPoint)vector;

+(float)p1:(CGPoint)p1 dotP2:(CGPoint)p2;

+(float)floatX:(float)x modFloatY:(float)y;

+(float)degreesFromVector1:(CGPoint)vector1 toVector2:(CGPoint)vector2;
+(float)degreesFromXAxisToVector:(CGPoint)vector;
+(float)distancePow2FromP1:(CGPoint)p1 toPoint2:(CGPoint)p2;
+(float)distanceFromP1:(CGPoint)p1 toPoint2:(CGPoint)p2;

+(CGPoint)unitVectorFromVector:(CGPoint)vector;
+(CGPoint)unitVectorFromPoint1:(CGPoint)p1 toPoint2:(CGPoint)p2;
+(CGPoint)unitVectorFromVector1:(CGPoint)v1 mapToDegrees:(float)degrees;
+(CGPoint)unitVectorFromDegrees:(float)degrees;
+(CGPoint)unitVectorFromRadians:(float)radians;

@end
