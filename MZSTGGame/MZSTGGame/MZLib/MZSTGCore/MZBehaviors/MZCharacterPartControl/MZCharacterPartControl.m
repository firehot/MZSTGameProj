#import "MZCharacterPartControl.h"
#import "MZUtilitiesHeader.h"
#import "MZSTGCharactersHeader.h"
#import "MZGameCharactersHeader.h"
#import "MZAttack_Base.h"
#import "MZAttackSetting.h"
#import "MZAttacksFactory.h"
#import "MZMotionsHeader.h"
#import "MZFaceToControl.h"
#import "MZSTGGameHelper.h"
#import "MZLevelComponentsHeader.h"
#import "MZControlUpdate.h"

@interface MZCharacterPartControl (Private)
-(void)_updateMotion;
@end

@implementation MZCharacterPartControl

@synthesize disableAttack;
@synthesize characterPartDelegate;

#pragma mark - override

+(MZCharacterPartControl *)characterPartControl
{
    return [[[self alloc] init] autorelease];
}

-(id)init
{
    self = [super init];

    disableAttack = false;

    return self;
}

-(void)dealloc
{
    [moveControlUpdate release];
    [attackControlUpdate release];
    
    characterPartDelegate = nil;
    
    [super dealloc];
}

#pragma mark - properties

-(void)setCharacterPartDelegate:(id<MZCharacterPartControlDelegate>)aCharacterPartDelegate
{
    characterPartDelegate = aCharacterPartDelegate;
    self.visible = true;
}

#pragma mark - MZFaceToControlProtocol

-(void)setVisible:(bool)aVisible
{
    characterPartDelegate.visible = aVisible;
}

-(bool)visible
{
    return characterPartDelegate.visible;
}

-(void)setRotation:(float)aRotation
{
    characterPartDelegate.rotation = aRotation;
}

-(float)rotation
{
    return characterPartDelegate.rotation;
}

-(CGPoint)standardPosition
{
    return characterPartDelegate.standardPosition;
}

-(CGPoint)currentMovingVector
{
    return characterPartDelegate.currentMovingVector;
}

-(CGPoint)targetPosition
{
    // 暫時的方法 ...
    return [MZLevelComponents sharedInstance].player.position;
}

#pragma mark - methods

-(MZMove_Base *)addMoveWithName:(NSString *)name moveType:(MZMoveClassType)classType
{
    MZAssert( characterPartDelegate != nil, @"characterPartDelegate is nil" );
    if( moveControlUpdate == nil ) moveControlUpdate = [[MZControlUpdate alloc] initWithBaseClass: [MZMove_Base class]];

    MZMove_Base *move = [MZMove_Base createWithClassType: classType];
    move.moveDelegate = characterPartDelegate;

    [moveControlUpdate add: move key: name];

    return move;
}

@end

#pragma mark - methods

@implementation MZCharacterPartControl (Protected)

#pragma mark - override

-(void)_update
{    
    [super _update];
    [self _updateMotion];
}

@end

#pragma mark

@implementation MZCharacterPartControl (Private)

#pragma mark - init

#pragma mark - methods

-(void)_updateMotion
{
    if( moveControlUpdate != nil ) [moveControlUpdate update];
}

@end