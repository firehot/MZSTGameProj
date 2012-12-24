#import <Foundation/Foundation.h>

@class MZColor;

@protocol MZCollisionProtocol <NSObject>
-(CGPoint)getRealPosition;
@end

@interface MZCircle : NSObject
{
    float radius;
    CGPoint center;
}

+(id)circleWithCenter:(CGPoint)aCenter radius:(float)aRadius;
-(id)initWithCenter:(CGPoint)aCenter radius:(float)aRadius;

@property (nonatomic, readwrite) float radius;
@property (nonatomic, readwrite) CGPoint center;
@end

@interface MZCollision : NSObject 
{
    id<MZCollisionProtocol> collisionTargetRef;
    NSMutableArray *collisions;
}

+(MZCollision *)collisionWithCollisionTarget:(id<MZCollisionProtocol>)aCollisionTarget;
-(id)initWithCollisionTarget:(id<MZCollisionProtocol>)aCollisionTarget;
-(void)addCircularCollision:(MZCircle *)circle;
-(void)drawRangeWithMZColor:(MZColor *)color;
-(bool)isCollisionWithOther:(MZCollision *)otherCollision;

@property (nonatomic, readonly) id<MZCollisionProtocol> collisionTargetRef;
@property (nonatomic, readonly) NSMutableArray *collisionParts;

@end
