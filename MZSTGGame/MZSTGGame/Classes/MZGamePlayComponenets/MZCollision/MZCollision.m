#import "MZCollision.h"
#import "cocos2d.h"
#import "MZUtilitiesHeader.h"
#import "MZColor.h"
#import "MZCCDisplayHelper.h"

#define LINE_WIDTH 2.0

@implementation MZCircle

@synthesize radius;
@synthesize center;

#pragma mark - init and dealloc

+(MZCircle *)circleWithCenter:(CGPoint)aCenter radius:(float)aRadius
{
    return [[[self alloc] initWithCenter: aCenter radius: aRadius] autorelease];
}

-(id)initWithCenter:(CGPoint)aCenter radius:(float)aRadius
{
    if( (self=[super init]) )
    {
        radius = aRadius;
        center = aCenter;
    }
    
    return self;
}

-(void)dealloc
{
    [super dealloc];
}

@end

@interface MZCollision (Private)
-(CGPoint)_getCircleRealPositionWithCircle:(MZCircle *)circle collisionTarget:(id<MZCollisionProtocol>)aCollisionTarget;
@end

@implementation MZCollision

@synthesize collisionTargetRef;
@synthesize collisionParts=collisions;

#pragma mark - init and dealloc

+(MZCollision *)collisionWithCollisionTarget:(id<MZCollisionProtocol>)aCollisionTarget
{
    return [[[self alloc] initWithCollisionTarget: aCollisionTarget] autorelease];
}

-(id)initWithCollisionTarget:(id<MZCollisionProtocol>)aCollisionTarget
{
    MZAssert( aCollisionTarget, @"aCollisionTarget is nil" );
    
    if( ( self = [super init] ) )
    {
        collisionTargetRef = aCollisionTarget;
    }
    
    return self;
}

-(void)dealloc
{
    collisionTargetRef = nil;
    [collisions release];
    [super dealloc];
}

#pragma mark - methods

-(void)addCircularCollision:(MZCircle *)circle
{
     if( collisions == nil )
         collisions = [[NSMutableArray alloc] init];
    
    circle.radius *= [MZCCDisplayHelper sharedInstance].deviceScale;
    
    [collisions addObject: circle];
}

-(void)drawRangeWithMZColor:(MZColor *)color
{
    if( collisions == nil )
        return;
    
    for( MZCircle *circle in collisions )
    {
        CGPoint targetRealPosition = [collisionTargetRef getRealPosition];
        CGPoint realCenter = CGPointMake( circle.center.x+targetRealPosition.x, circle.center.y+targetRealPosition.y );
        
        glLineWidth( LINE_WIDTH*[MZCCDisplayHelper sharedInstance].deviceScale );
        ccDrawColor4B( color.red, color.green, color.blue, 255 );
        ccDrawCircle( realCenter, circle.radius, 360, 30, NO );
    }  
}

-(bool)isCollisionWithOther:(MZCollision *)otherCollision
{   
    for( MZCircle *otherCircle in otherCollision.collisionParts )
    {
        CGPoint otherCircleRealPosition = [self _getCircleRealPositionWithCircle: otherCircle
                                                                 collisionTarget: otherCollision.collisionTargetRef];
        for( MZCircle *selfCircle in self.collisionParts )
        {
            CGPoint selfCircleRealPosition = [self _getCircleRealPositionWithCircle: selfCircle
                                                                    collisionTarget: self.collisionTargetRef];
            
            float realDistancePow2 = [MZMath distancePow2FromP1: selfCircleRealPosition toPoint2: otherCircleRealPosition];
        
            float collisionDistancePow2 = otherCircle.radius + selfCircle.radius;
            collisionDistancePow2 = collisionDistancePow2*collisionDistancePow2;
            
            if( realDistancePow2 < collisionDistancePow2 )
            {
                return true;
            }
        }
    }

    return false;
}

@end

@implementation MZCollision (Private)

#pragma mark - methods (private)

-(CGPoint)_getCircleRealPositionWithCircle:(MZCircle *)circle collisionTarget:(id<MZCollisionProtocol>)aCollisionTarget
{
    CGPoint targetRealPosition = [aCollisionTarget getRealPosition];
    return CGPointMake( circle.center.x+targetRealPosition.x, circle.center.y+targetRealPosition.y );
}

@end
