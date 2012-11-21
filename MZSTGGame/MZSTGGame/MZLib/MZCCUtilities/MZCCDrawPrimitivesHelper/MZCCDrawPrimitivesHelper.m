#import "MZCCDrawPrimitivesHelper.h"
#import "MZCCDisplayHelper.h"
#import "MZCGPointMacro.h"
#import "CCDrawingPrimitives.h"
#import "CCDrawNode.h"

@implementation MZCCDrawPrimitivesHelper

+(void)drawRect:(CGRect)rect lineWidth:(GLfloat)lineWidth color:(ccColor4B)color
{
    float x = rect.origin.x;
    float y = rect.origin.y;
    float width = rect.size.width;
    float height = rect.size.height;
    
    CGPoint downLeft = mzp( x, y );
    CGPoint downRight = mzp( x + width , y );
    CGPoint topLeft = mzp( x, y + height );
    CGPoint topRight = mzp( x + width , y + height );
    
    glLineWidth( lineWidth );
    ccDrawColor4B( color.r, color.g, color.b, color.a );
    
    ccDrawLine( downLeft, downRight );
    ccDrawLine( downRight, topRight );
    ccDrawLine( topRight, topLeft );
    ccDrawLine( topLeft, downLeft );
    
    ccDrawColor4B( 255, 255, 255, 255 );
    glLineWidth( 1 );
}

+(CCDrawNode *)createNodeWithRect:(CGRect)rect lineWidth:(GLfloat)lineWidth color:(ccColor4F)color
{
    CGPoint p[] = {
        rect.origin,
        mzpAdd( rect.origin, mzp( rect.size.width, 0 ) ),
        mzpAdd( rect.origin, mzp( rect.size.width, rect.size.height ) ),
        mzpAdd( rect.origin, mzp( rect.size.width, 0 ) )
    };

    CCDrawNode *drawNode = [CCDrawNode node];
    [drawNode drawPolyWithVerts: p count: 4 fillColor: ccc4f( 0, 0, 0, 0 ) borderWidth: lineWidth borderColor: color];

    return drawNode;
}

+(void)addToDrawNode:(CCDrawNode **)drawNode withRect:(CGRect)rect lineWidth:(GLfloat)lineWidth color:(ccColor4F)color
{
    if( (*drawNode) == nil ) return;

    CGPoint p[] = {
        rect.origin,
        mzpAdd( rect.origin, mzp( rect.size.width, 0 ) ),
        mzpAdd( rect.origin, mzp( rect.size.width, rect.size.height ) ),
        mzpAdd( rect.origin, mzp( 0, rect.size.height ) )
    };

    [(*drawNode) drawPolyWithVerts: p count: 4 fillColor: ccc4f( 0, 0, 0, 0 ) borderWidth: lineWidth borderColor: color];
}

+(void)addToDrawNode:(CCDrawNode **)drawNode withStdRect:(CGRect)stdRect lineWidth:(GLfloat)lineWidth color:(ccColor4F)color
{
    CGPoint realOrigin = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: stdRect.origin];
    float deviceScale = [MZCCDisplayHelper sharedInstance].deviceScale;
    CGRect realRect = CGRectMake( realOrigin.x, realOrigin.y, stdRect.size.width*deviceScale, stdRect.size.height*deviceScale );
    
    [MZCCDrawPrimitivesHelper addToDrawNode: drawNode withRect: realRect lineWidth: lineWidth*deviceScale color: color];
}

@end
