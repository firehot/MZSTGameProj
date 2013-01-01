#import "MZCharacterPart.h"
#import "MZCharacterPartSetting.h"
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

@synthesize setting;
@synthesize parentCharacterRef;
@synthesize characterType;

#pragma mark - init and dealloc

+(MZCharacterPart *)part
{
    return [[[self alloc] init] autorelease];
}

-(void)dealloc
{    
    [setting release];

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

-(void)setSetting:(MZCharacterPartSetting *)aSetting
{
    MZAssert( self.hasSprite, @"must assign sprite first" );
    if( setting == aSetting ) return;
    if( setting != nil ) [setting release];

    setting = [aSetting retain];
    self.position = setting.relativePosition;
    self.scale = setting.scale;
    self.color = setting.color;

    [self _setCollisionBySetting];
}

-(MZCharacterPartSetting *)setting
{
    if( setting == nil )
        setting = [[MZCharacterPartSetting alloc] init];

    return setting;
}

-(void)setParentCharacterRef:(MZCharacter *)aParentCharacter
{
    self.parentRef = aParentCharacter;
}

-(MZCharacterType)characterType
{
    return parentCharacterRef.characterType;
}

#pragma mark - override

-(void)enable
{
    [super enable];
    
    ( setting.frameName )? 
    [self setFrameWithFrameName: setting.frameName] : 
    [self playAnimationWithAnimationName: setting.animationName isRepeatForever: true];
}

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
    for( MZCircle *circle in setting.collisions )
    {
        CGPoint center = CGPointMake( circle.center.x, circle.center.y );
        float radius = circle.radius;
        
        MZCircle *collisionCircle = [MZCircle circleWithCenter: center radius: radius];
        [self addCollisionCircle: collisionCircle];
    }
}

@end