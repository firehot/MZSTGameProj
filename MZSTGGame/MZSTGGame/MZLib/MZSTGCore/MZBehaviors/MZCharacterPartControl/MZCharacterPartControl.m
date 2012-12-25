#import "MZCharacterPartControl.h"
#import "MZUtilitiesHeader.h"
#import "MZSTGCharactersHeader.h"
#import "MZGameCharactersHeader.h"
#import "MZCharacterPartControlSetting.h"
#import "MZAttack_Base.h"
#import "MZAttackSetting.h"
#import "MZAttacksFactory.h"
#import "MZMotionsHeader.h"
#import "MZFaceToControl.h"
#import "MZSTGGameHelper.h"
#import "MZLevelComponentsHeader.h"

@interface MZCharacterPartControl (Private)
-(void)_initAttackSettingsQueue;
-(void)_initMotionsSettingsQueue;
-(void)_initFaceToControl;

-(void)_switchCurrentAttack;
-(void)_switchCurrentMotion;

-(void)_updateAttack;
-(void)_updateMotion;
-(void)_updateFaceTo;
@end

@implementation MZCharacterPartControl

@synthesize disableAttack;

#pragma mark - override

+(MZCharacterPartControl *)characterPartControlWithDelegate:(id<MZCharacterPartDelegate>)aDelegate
                                                    setting:(MZCharacterPartControlSetting *)aSetting;
{
    return [[[self alloc] initWithDelegate: aDelegate setting: aSetting] autorelease];
}

-(id)initWithDelegate:(id<MZCharacterPartDelegate>)aDelegate
              setting:(MZCharacterPartControlSetting *)aSetting;
{
    setting = [aSetting retain];
    characterPartDelegate = aDelegate;
    disableAttack = false;
    
    self = [super initWithDelegate: aDelegate];
    return self;
}

-(void)dealloc
{
    [MZSTGGameHelper destoryGameBase: &currentAttack];
    [MZSTGGameHelper destoryGameBase: &currentMotion];
    
    [setting release];
    [faceToControl release];
    [attackSettingsQueue release];
    [motionsSettingsQueue release];
    
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

@end

#pragma mark - methods

@implementation MZCharacterPartControl (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    [self _initFaceToControl];
    [self _initAttackSettingsQueue];
    [self _initMotionsSettingsQueue];
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
    if( setting.attackSettingsArray == nil ) 
        return;
    if( [setting.attackSettingsArray count] == 0 ) 
        return;
   
    if( attackSettingsQueue == nil )
        attackSettingsQueue = [[NSMutableArray alloc] initWithCapacity: 1];
    
    for( MZAttackSetting *attackSetting in setting.attackSettingsArray )
        [attackSettingsQueue push: attackSetting];
}

-(void)_initMotionsSettingsQueue
{
    if( setting.motionSettingsArray == nil )
        return;
    if( [setting.motionSettingsArray count] == 0 )
        return;
    
    if( motionsSettingsQueue == nil )
        motionsSettingsQueue = [[NSMutableArray alloc] initWithCapacity: 1];
    
    for( MZMotionSetting *motionSetting in setting.motionSettingsArray )
        [motionsSettingsQueue push: motionSetting];
}

-(void)_initFaceToControl
{
    faceToControl = [[MZFaceToControl alloc] initWithControlTarget: self
                                                            faceTo: setting.faceTo
                                                 previousDirection: mzp( 0, -1 )];
}

#pragma mark - methods

-(void)_switchCurrentAttack
{
    [MZSTGGameHelper destoryGameBase: &currentAttack];

    if( [attackSettingsQueue peek] != nil )
    {
        MZAttackSetting *nextAttackSetting = (MZAttackSetting *)[attackSettingsQueue pop];
        currentAttack = [[MZAttacksFactory sharedInstance] getAttackWithDelegate: characterPartDelegate setting: nextAttackSetting];

        [currentAttack retain];
        [currentAttack enable];
        
        if( !nextAttackSetting.isRunOnce )
            [attackSettingsQueue push: nextAttackSetting];
    }
}

-(void)_switchCurrentMotion
{
    [MZSTGGameHelper destoryGameBase: &currentMotion];
    
    if( [motionsSettingsQueue peek] != nil )
    {
        MZMotionSetting *nextMotionSetting = [motionsSettingsQueue pop];
        currentMotion = [[MZMotionsFactory sharedMZMotionsFactory] getMotionBySetting: nextMotionSetting controlTarget: controlDelegate];
        [currentMotion retain];
        [currentMotion enable];
        
        if( !nextMotionSetting.isRunOnce )
            [motionsSettingsQueue push: nextMotionSetting];
    }
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
    if( currentMotion == nil )
        [self _switchCurrentMotion];
    
    if( currentMotion != nil )
    {
        [currentMotion update];
        
        if( !currentMotion.isActive )
            [self _switchCurrentMotion];
    }
}

-(void)_updateFaceTo
{
    [faceToControl update];
    characterPartDelegate.visible = faceToControl.hasVaildValue;
}

@end