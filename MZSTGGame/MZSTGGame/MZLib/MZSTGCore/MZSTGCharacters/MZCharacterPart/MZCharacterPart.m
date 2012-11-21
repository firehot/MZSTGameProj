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

@synthesize parentCharacterType;

#pragma mark - init and dealloc

+(MZCharacterPart *)characterPartWithLevelComponenets:(MZLevelComponents *)aLevelComponents
                                              setting:(MZCharacterPartSetting *)aSetting
                                  parentCharacterType:(MZCharacterType)aParentCharacterType
{
    return [[[self alloc] initWithLevelComponenets: aLevelComponents setting: aSetting parentCharacterType: aParentCharacterType] autorelease];
}

-(id)initWithLevelComponenets:(MZLevelComponents *)aLevelComponents
                      setting:(MZCharacterPartSetting *)aSetting
          parentCharacterType:(MZCharacterType)aParentCharacterType
{
    MZAssert( aLevelComponents, @"aLevelComponents is nil" );
    MZAssert( aSetting, @"aSetting is nil" );
    
    setting = [aSetting retain];
    parentCharacterType = aParentCharacterType;
    
    self = [super initWithLevelComponenets: aLevelComponents];

    return self;
}

-(void)dealloc
{    
    [self releaseSprite];
    [setting release];
    [super dealloc];
}

#pragma mark - properties (override)

-(CGPoint)currentMovingVector
{
    return ((MZGameObject *)parentRef).currentMovingVector;
}

#pragma mark - methods

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

-(void)_initValues
{
    [super _initValues];
    
    MZAssert( setting != nil, @"Setting is nil" );
    
    [self setSpriteFromPool: levelComponentsRef.spritesPool characterType: parentCharacterType];
    
    self.position = setting.relativePosition;
    self.scale = setting.scale;
    self.color = setting.color;
    
    [self _setCollisionBySetting];
}

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