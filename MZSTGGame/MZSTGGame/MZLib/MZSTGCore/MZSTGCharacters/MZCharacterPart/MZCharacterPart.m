#import "MZCharacterPart.h"
#import "MZGamePlayLayer.h"
#import "MZCharacter.h"
#import "MZGameSettingsHeader.h"
#import "MZObjectHelper.h"
#import "MZCGPointMacro.h"
#import "MZLevelComponentsHeader.h"
#import "MZLogMacro.h"
#import "cocos2d.h"

@interface MZCharacterPart (Private)
-(void)_setCollisionBySetting;
@end

#pragma mark

@implementation MZCharacterPart

@synthesize parentCharacterRef;
@synthesize characterType;

#pragma mark - init and dealloc

+(MZCharacterPart *)part
{
    return [[[self alloc] init] autorelease];
}

-(void)dealloc
{
    parentCharacterRef = nil;
    
    [super dealloc];
}

#pragma mark - properties (override)

-(CGPoint)currentMovingVector
{
    return ((MZGameObject *)parentRef).currentMovingVector;
}

-(void)setParentRef:(MZBehavior_Base *)aParent
{
    MZAssert( [aParent isKindOfClass: [MZCharacter class]], @"must be MZCharacter class" );

    [super setParentRef: aParent];
    parentCharacterRef = (MZCharacter *)aParent;
}

#pragma mark - properties

-(void)setParentCharacterRef:(MZCharacter *)aParentCharacter
{
    self.parentRef = aParentCharacter;
}

-(MZCharacterType)characterType
{
    // working ... ..
    // 這裡傳回了 none
    if( parentCharacterRef.characterType  == kMZCharacterType_None )
        MZLog( @"E" );

    return parentCharacterRef.characterType;
}

#pragma mark - override

@end

#pragma mark

@implementation MZCharacterPart (Protected)
#pragma mark - override
@end

#pragma mark

@implementation MZCharacterPart (Private)

#pragma mark - methods (private)

-(void)_setCollisionBySetting
{
//    for( MZCircle *circle in setting.collisions )
//    {
//        CGPoint center = CGPointMake( circle.center.x, circle.center.y );
//        float radius = circle.radius;
//        
//        MZCircle *collisionCircle = [MZCircle circleWithCenter: center radius: radius];
//        [self addCollisionCircle: collisionCircle];
//    }
}

@end