#import "MZCharacter.h"
#import "MZLevelComponentsHeader.h"
#import "MZBehaviorsHeader.h"
#import "MZColor.h"
#import "MZUtilitiesHeader.h"
#import "MZSTGGameHelper.h"
#import "MZQueue.h"
#import "MZCCSpritesPool.h"

@interface MZCharacter (Private)
@end

@implementation MZCharacter

@synthesize disableAttack;
@synthesize currentHealthPoint;
@synthesize spawnPosition;
@synthesize characterType;
@synthesize partSpritesPoolRef;
@synthesize currentMovingVector;

@synthesize partsDictionary;

#pragma mark - init and dealloc

+(MZCharacter *)character
{
    return [[[self alloc] init] autorelease];
}

-(void)dealloc
{
    [partsDictionary release];

    partSpritesPoolRef = nil;

    [super dealloc];
}

#pragma mark - properties

-(void)setDisableAttack:(bool)aDisableAttack
{
    disableAttack = aDisableAttack;
}

-(CGPoint)currentMovingVector
{
    return mzpZero; // 等 mode 搬過來再說
//    return currentMode.currentMotion.currentMovingVector;
}

#pragma mark - methods

-(MZCharacterPart *)addPartWithName:(NSString *)aName
{
    MZAssert( characterType != kMZCharacterType_Unknow, @"must set characterType first" );
    MZAssert( partSpritesPoolRef != nil, @"must set partSpritesPoolRef first" );

    MZCharacterPart *part = [MZCharacterPart part];
    [part setSpritesFromPool: partSpritesPoolRef];
    part.parentRef = self;

    if( partsDictionary == nil ) partsDictionary = [[NSMutableDictionary alloc] initWithCapacity: 1];

    [partsDictionary setObject: part forKey: aName];
    [self addChild: part name: aName];

    return  part;
}

-(void)initDefaultMode
{
    MZAssert( partsDictionary, @"partsDictionary must be ctreated first" );
}

-(bool)isCollisionWithOtherCharacter:(MZCharacter *)otherCharacter
{   
    return [self isCollisionWithOtherGameObject: otherCharacter];
}

@end

#pragma mark

@implementation MZCharacter (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    
    currentHealthPoint = 1;
    disableAttack = false;
    characterType = kMZCharacterType_None;
}

-(void)_checkActiveCondition
{
    [super _checkActiveCondition];
    
    if( currentHealthPoint <= 0 )
        [self disable];

    if( ![self isInnerScreen] )
        [self disable];
}

-(void)_update
{
    [super _update];
}

@end

#pragma mark

@implementation MZCharacter (Private)
#pragma mark - methods
@end