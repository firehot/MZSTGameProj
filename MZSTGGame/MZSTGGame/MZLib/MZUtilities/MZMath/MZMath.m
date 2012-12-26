#import "MZMath.h"

@implementation MZMath

+(bool)isPoint0:(CGPoint)p0 innerTriangleWithTopPoint1:(CGPoint)p1 point2:(CGPoint)p2 point3:(CGPoint)p3
{   
    MZFormula *p1p2Formula = [MZFormula formulaWithPoint1: p1 point2: p2];
	MZFormula *p2p3Formula = [MZFormula formulaWithPoint1: p2 point2: p3];
	MZFormula *p1p3Formula = [MZFormula formulaWithPoint1: p1 point2: p3];

	if( ( [p1p2Formula getResult:p0] * [p1p2Formula getResult:p3] ) > 0 )
	{
		if( ( [p2p3Formula getResult:p0] * [p2p3Formula getResult:p1] ) > 0 )
		{
			if( ( [p1p3Formula getResult:p0] * [p1p3Formula getResult:p2] ) > 0 )
			{
 				return true;
			}
		}
	}
	
	return false;
}

+(bool)isPoint:(CGPoint)point inCircle:(CGPoint)center radius:(float)radius
{
    return ( [MZMath distancePow2FromP1: center toPoint2: point] <= radius*radius )? true : false;
}

+(bool)isPointValid:(CGPoint)point
{
    if( [NSStringFromCGPoint( point ) isEqualToString: @"{nan, nan}"] )
        return false;
    return true;
}

+(int)randomIntInRangeMin:(int)min max:(int)max
{
    int length = max - min;
    return min + ( arc4random()%length );
}

+(float)radiansToDegree:(float)radians
{
	return radians * 180 / M_PI;
}

+(float)degreesFromRadians:(float)radians
{
	return radians * 180 / M_PI;
}

+(float)degreesToRadians:(float)degrees
{
	return degrees * M_PI / 180;
}

+(float)radiansFromDegrees:(float)degrees
{
	return degrees * M_PI / 180;
}

+(float)lengthOfVector:(CGPoint)vector
{
	return sqrt( pow( vector.x, 2 ) + pow( vector.y, 2 ) );
}

+(float)p1:(CGPoint)p1 dotP2:(CGPoint)p2
{
	return (p1.x * p2.x) + (p1.y * p2.y);
}

+(float)floatX:(float)x modFloatY:(float)y
{
	if( y == 0 )
		return 0;
	
	float _x = x;
	float _y = y;
	
	while( YES )
        if( _x > _y ) _x -= _y; else return _x;
}

+(float)degreesFromVector1:(CGPoint)vector1 toVector2:(CGPoint)vector2
{
	float v1Dotv2 = [MZMath p1: vector1 dotP2: vector2];
	float v1lenMulv2len = [MZMath lengthOfVector: vector1] * [MZMath lengthOfVector: vector2];
    
    if( v1lenMulv2len == 0 )
        return 0;
	
	float result = acos( v1Dotv2 / v1lenMulv2len );
	result = [MZMath radiansToDegree: result];
        
	return result;
}

+(float)degreesFromXAxisToVector:(CGPoint)vector
{
	if( vector.x == 0 )
	{
		if( vector.y > 0 ) return 90;
		if( vector.y < 0 ) return 270;
	}
	
	if( vector.y == 0 )
	{
		if( vector.x > 0 ) return 0;
		if( vector.x < 0 ) return 180;
	}

    float result = [MZMath degreesFromVector1: CGPointMake( 1, 0 ) toVector2: vector];
    return ( vector.y >= 0 )? result : 360 - result;
}

+(float)distancePow2FromP1:(CGPoint)p1 toPoint2:(CGPoint)p2
{
	return (p2.x-p1.x)*(p2.x-p1.x) + (p2.y-p1.y)*(p2.y-p1.y);
}

+(float)distanceFromP1:(CGPoint)p1 toPoint2:(CGPoint)p2
{
	return sqrtf( (p2.x-p1.x)*(p2.x-p1.x) + (p2.y-p1.y)*(p2.y-p1.y) );
}

+(CGPoint)unitVectorFromVector:(CGPoint)vector
{
	float length = [MZMath lengthOfVector:vector];
	return CGPointMake( vector.x / length, vector.y / length );
}

+(CGPoint)unitVectorFromPoint1:(CGPoint)p1 toPoint2:(CGPoint)p2
{
    float diffY = p2.y - p1.y;
    float diffX = p2.x - p1.x;
    
    if( diffY == 0 )
    {
        if( diffX > 0 )
            return CGPointMake( 1, 0 ) ;
        else if( diffX < 0 )
            return CGPointMake( -1, 0 );
        else
            return CGPointZero;
    }
    
	float length = sqrt( pow( diffX, 2) + pow( diffY, 2) );
	
	return CGPointMake( diffX/length, diffY/length );
}

+(CGPoint)unitVectorFromVector1:(CGPoint)v1 mapToDegrees:(float)degrees
{
	float radians = [MZMath degreesToRadians: degrees];
	
	float c = cos( radians );
	float s = sin( radians );
	
	CGPoint v2 = CGPointMake( v1.x*c - v1.y*s, v1.x*s + v1.y*c );
	CGPoint unitV2 = [MZMath unitVectorFromVector: v2];
	
	return unitV2;
}

+(CGPoint)unitVectorFromDegrees:(float)degrees
{
    float degrees_ = ((int)degrees)%360;
    
	if( degrees_ == 90 ) return CGPointMake( 0, 1 );
	if( degrees_ == 270 ) return CGPointMake( 0, -1 );
	if( degrees_ == 0 ) return CGPointMake( 1, 0 );
	if( degrees_ == 180 ) return CGPointMake( -1, 0 );
	
	float radians = [MZMath degreesToRadians: degrees];
	return CGPointMake( cos( radians ), sin( radians ) );
}

+(CGPoint)unitVectorFromRadians:(float)radians
{
	return CGPointMake( cos( radians ), sin( radians ) );
}
			   
@end
