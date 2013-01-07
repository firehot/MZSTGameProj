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
-(void)_initAttackSettingsQueue;
-(void)_initFaceToControl;

-(void)_switchCurrentAttack;

-(void)_updateAttack;
-(void)_updateMotion;
-(void)_updateFaceTo;
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

    [MZSTGGameHelper destoryGameBase: &currentAttack];

    [faceToControl release];
    [attackSettingsQueue release];
    
    characterPartDelegate = nil;
    
    [super dealloc];
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
    if( moveControlUpdate == nil ) moveControlUpdate = [[MZControlUpdate alloc] init];

    MZMove_Base *move = [MZMove_Base createWithClassType: classType];
    move.moveDelegate = characterPartDelegate;

    [moveControlUpdate add: move key: name];

    return move;
}

@end

#pragma mark - methods

@implementation MZCharacterPartControl (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    [self _initFaceToControl];
    [self _initAttackSettingsQueue];
}

-(void)_update
{    
    [super _update];
    [self _updateAttack];
    [self _updateMotion];
    [self _updateFaceTo];
}

@end

#pragma mark

@implementation MZCharacterPartControl (Private)

#pragma mark - init

-(void)_initAttackSettingsQueue
{
//    if( attackSettingsQueue == nil )
//        attackSettingsQueue = [[NSMutableArray alloc] initWithCapacity: 1];
//    
//    for( MZAttackSetting *attackSetting in setting.attackSettingsArray )
//        [attackSettingsQueue push: attackSetting];
}

-(void)_initFaceToControl
{
//    faceToControl = [[MZFaceToControl alloc] initWithControlTarget: self
//                                                            faceTo: setting.faceTo
//                                                 previousDirection: mzp( 0, -1 )];
}

#pragma mark - methods

-(void)_switchCurrentAttack
{
//    [MZSTGGameHelper destoryGameBase: &currentAttack];
//
//    if( [attackSettingsQueue peek] != nil )
//    {
//        MZAttackSetting *nextAttackSetting = (MZAttackSetting *)[attackSettingsQueue pop];
//        currentAttack = [[MZAttacksFactory sharedInstance] getAttackWithDelegate: characterPartDelegate setting: nextAttackSetting];
//
//        [currentAttack retain];
//        [currentAttack enable];
//        
//        if( !nextAttackSetting.isRunOnce )
//            [attackSettingsQueue push: nextAttackSetting];
//    }
}

-(void)_updateAttack
{
    if( disableAttack ) return;
    
    if( currentAttack == nil )
        [self _switchCurrentAttack];
    
    if( currentAttack != nil )
    {                
        [currentAttack update];
        
        if( !currentAttack.isActive )
            [self _switchCurrentAttack];
    }
}

-(void)_updateMotion
{
    if( moveControlUpdate != nil ) [moveControlUpdate update];
}

-(void)_updateFaceTo
{
    [faceToControl update];
    characterPartDelegate.visible = faceToControl.hasVaildValue;
}

@end