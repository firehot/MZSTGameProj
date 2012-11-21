#import "MZFormula.h"

@implementation MZFormula

@synthesize isDoNotCare;
@synthesize a;
@synthesize b;
@synthesize c;

#pragma mark - init and dealloc

+(MZFormula *)formulaWithPoint1:(CGPoint)p1 point2:(CGPoint)p2
{
    return [[[self alloc] initWithPoint1: p1 point2: p2] autorelease];
}

-(id)initWithPoint1:(CGPoint)p1 point2:(CGPoint)p2
{
	if( ( self = [super init] ) )
	{
		b = 1;
        a = ( p1.x == p2.x )? 0 : ( p1.y - p2.y )/( p2.x - p1.x );
		c = -a*p1.x - ( b*p1.y );
	}
    
	return self;
}

#pragma mark - methods

-(float)getResult:(CGPoint)p;
{
	return (a*p.x) + (b*p.y) + c;
}

-(float)getResultWithX:(float)x y:(float)y
{
    return a*x + b*y + c;
}

-(float)getXWithY:(float)y
{
    isDoNotCare = ( a == 0 )? true : false;    
    return -( b*y + c ) / a;
}

-(float)getYWithX:(float)x
{
    isDoNotCare = ( b == 0 )? true : false;
    return -( a*x + c ) / b;
}

@end
