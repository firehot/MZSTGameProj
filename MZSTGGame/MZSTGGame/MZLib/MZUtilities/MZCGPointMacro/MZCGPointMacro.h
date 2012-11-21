#define mzInvaildPoint CGPointMake( -9999, -9999 )

typedef struct
{
    int x;
    int y;
}MZPointi;

static inline CGPoint mzp(const GLfloat p1, const GLfloat p2)
{
    return CGPointMake( p1, p2 );
}

static inline CGPoint mzpAdd(const CGPoint p1, const CGPoint p2)
{
	return mzp( p1.x + p2.x, p1.y + p2.y );
}

static inline CGPoint mzpSub(const CGPoint p1, const CGPoint p2)
{
	return mzp( p1.x - p2.x, p1.y - p2.y );
}

static inline CGPoint mzpMul(const CGPoint p, const CGFloat s)
{
	return mzp( p.x*s, p.y*s );
}

static inline CGPoint mzpDiv(const CGPoint p, const CGFloat s)
{
	return mzp( p.x/s, p.y/s );
}

static inline MZPointi MZPointiMake(CGPoint point)
{
    MZPointi p;
    p.x = (int)(point.x + 0.5);
    p.y = (int)(point.y + 0.5);

    return p;
}

static inline CGPoint CGPointiFromPoint(CGPoint point)
{
    CGPoint p;
    p.x = (int)(point.x + 0.5);
    p.y = (int)(point.y + 0.5);
    
    return p;
}

static inline NSString *NSStringFromMZPointi(MZPointi point)
{
    return [NSString stringWithFormat: @"{%d,%d}", point.x, point.y];
}