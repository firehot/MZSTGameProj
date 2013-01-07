#import "MZMode.h"
#import "MZQueue.h"
#import "MZObjectHelper.h"
#import "MZCharacter.h"
#import "MZMotionSetting.h"
#import "MZMove_Base.h"
#import "MZMotionsFactory.h"
#import "MZCharacterPartControl.h"
#import "MZSTGGameHelper.h"
#import "MZTime.h"
#import "MZUtilitiesHeader.h"
#import "MZLogMacro.h"

@interface MZMode (Private)
@end

#pragma mark

@implementation MZMode

@synthesize modeDelegate;

@synthesize disableMove;
@synthesize disableAttack;

#pragma mark - init and dealloc

+(MZMode *)mode
{ return [[[self alloc] init] autorelease]; }

-(void)dealloc
{
    [movesUpdate release];
    [characterPartControlUpdatesDictionary release];
    [currentCharacterPartControls release];
    [super dealloc];
}

#pragma mark - properties

-(void)setDisableAttack:(bool)aDisableAttack
{
    disableAttack = aDisableAttack;
    for( MZCharacterPartControl *control in currentCharacterPartControls )
        control.disableAttack = disableAttack;
}

#pragma mark - override

#pragma mark - methods

-(MZMove_Base *)addMoveWithName:(NSString *)name moveType:(MZMoveClassType)classType
{
    MZMove_Base *move = [MZMove_Base createWithClassType: classType];
    move.moveDelegate = modeDelegate;

    if( movesUpdate == nil ) movesUpdate = [[MZControlUpdate alloc] init];
    [movesUpdate add: move key: name];

    return move;
}

-(MZMove_Base *)moveByName:(NSString *)name
{
    return [movesUpdate.controlsDictionaryArray.dictionary objectForKey: name];
}

-(void)addPartControlUpdateWithPart:(MZControlUpdate *)partControlUpdate name:(NSString *)name;
{
    MZAssert( partControlUpdate != nil,  @"part is nil" );
    // how to check partControlUpdate contain is not partControl???

    if( characterPartControlUpdatesDictionary == nil ) characterPartControlUpdatesDictionary = [[NSMutableDictionary alloc] init];
    [characterPartControlUpdatesDictionary  setObject: partControlUpdate forKey: name];
}

@end

#pragma mark

@implementation MZMode (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
}

-(void)_update
{
    [super _update];
    if( movesUpdate != nil ) [movesUpdate update];
    if( characterPartControlUpdatesDictionary != nil )
    {
        for(MZControlUpdate *pUpdate in characterPartControlUpdatesDictionary.allValues )
            [pUpdate update];
    }
}

@end

#pragma mark

@implementation MZMode (Private)
#pragma mark - methods
@end