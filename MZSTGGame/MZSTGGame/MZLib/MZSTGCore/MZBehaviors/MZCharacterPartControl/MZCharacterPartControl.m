#import "MZCharacterPartControl.h"
#import "MZUtilitiesHeader.h"
#import "MZSTGCharactersHeader.h"
#import "MZGameCharactersHeader.h"
#import "MZAttack_Base.h"
#import "MZMotionsHeader.h"
#import "MZFaceToControl.h"
#import "MZSTGGameHelper.h"
#import "MZLevelComponentsHeader.h"
#import "MZControlUpdate.h"

@interface MZCharacterPartControl (Private)
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

-(MZAttack_Base *)addAttackWithName:(NSString *)name attackType:(MZAttackClassType)classType
{
    MZAssert( characterPartDelegate != nil, @"characterPartDelegate is nil" );
    if( attackControlUpdate == nil ) attackControlUpdate = [[MZControlUpdate alloc] initWithBaseClass: [MZAttack_Base class]];

    MZAttack_Base *attack = [MZAttack_Base createWithClassType: classType];
    attack.attackDelegate = characterPartDelegate;

    [attackControlUpdate add: attack key: name];

    return attack;
}

@end

#pragma mark - methods

@implementation MZCharacterPartControl (Protected)

#pragma mark - override

-(void)_update
{    
    [super _update];
    if( moveControlUpdate != nil ) [moveControlUpdate update];
    if( attackControlUpdate != nil ) [attackControlUpdate update];
}

@end

#pragma mark

@implementation MZCharacterPartControl (Private)
@end