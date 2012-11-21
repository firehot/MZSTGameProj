#import "MZMode.h"
#import "MZQueue.h"
#import "MZObjectHelper.h"
#import "MZModeSetting.h"
#import "MZCharacter.h"
#import "MZMotionSetting.h"
#import "MZMotion_Base.h"
#import "MZMotionsFactory.h"
#import "MZCharacterPartControlSetting.h"
#import "MZCharacterPartControl.h"
#import "MZSTGGameHelper.h"
#import "MZTime.h"
#import "MZLogMacro.h"

@interface MZMode (Private)
-(void)_initMotionSettingsQueue;
-(void)_initCharacterPartControlsSettingsArray;

-(void)_switchCurrentMotion;
-(void)_switchCurrentCharacterPartControls;

-(void)_updateMotion;
-(void)_updateCharacterPartControls;

-(MZMotion_Base *)_getNextMotionWithSetting:(MZMotionSetting *)nextMotionSetting controlTarget:(MZGameObject *)controlTarget;
@end

#pragma mark

@implementation MZMode

@synthesize disableAttack;
@synthesize motionSettingsQueue;
@synthesize currentMotion;

#pragma mark - init and dealloc

+(MZMode *)modeWithModeSetting:(MZModeSetting *)aSetting levelComponenets:(MZLevelComponents *)aLevelComponents controlTarget:(MZGameObject *)aControlTarget
{
    return [[[self alloc] initWithModeSetting: aSetting levelComponenets: aLevelComponents controlTarget: aControlTarget] autorelease];
}

-(id)initWithModeSetting:(MZModeSetting *)aSetting levelComponenets:(MZLevelComponents *)aLevelComponents controlTarget:(MZGameObject *)aControlTarget
{
    MZAssert( aSetting, @"Setting is nil" );
    setting = [aSetting retain];
    
    self = [super initWithLevelComponenets: aLevelComponents controlTarget: aControlTarget];
    if( self == nil ) return nil;
    
    disableAttack = false;
    
    return self;
}  

-(void)dealloc
{
    [MZSTGGameHelper destoryGameBase: &currentMotion];
    [characterPartControlSettingsArray release];
    [setting release];    
    [motionSettingsQueue release];
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

#pragma mark - methods

-(void)enable
{
    [super enable];
    [self _switchCurrentMotion];
    [self _switchCurrentCharacterPartControls];
}

@end

#pragma mark

@implementation MZMode (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    [self _initMotionSettingsQueue];
    [self _initCharacterPartControlsSettingsArray];
}

-(void)_checkActiveCondition
{      
    [super _checkActiveCondition];
    if( !setting.isRepeatForever && self.lifeTimeCount > setting.duration )
        [self disable];
}

-(void)_update
{
    [super _update];
    [self _updateMotion];
    [self _updateCharacterPartControls];
}

@end

#pragma mark

@implementation MZMode (Private)

#pragma mark - methods

-(void)_initMotionSettingsQueue
{
    MZAssert( motionSettingsQueue == nil, @"motionSettingsQueue must be nil" );
    motionSettingsQueue = [[NSMutableArray alloc] initWithCapacity: 1];
    
    if( setting.motionSettings != nil )
    {
        for( MZMotionSetting *motionSetting in setting.motionSettings )
            [motionSettingsQueue push: motionSetting];
    }
}

-(void)_initCharacterPartControlsSettingsArray
{
    MZAssert( characterPartControlSettingsArray == nil, @"characterPartControlSettingsArray must be nil" );
    characterPartControlSettingsArray = [[NSMutableArray alloc] initWithCapacity: 1];
        
    if( setting.characterPartControlSettingsDictionary != nil )
    {
        for( NSString *controlName in [setting.characterPartControlSettingsDictionary allKeys] )
        {
            MZCharacterPartControlSetting *characterPartControlSetting = [setting.characterPartControlSettingsDictionary objectForKey: controlName];
            [characterPartControlSettingsArray addObject: characterPartControlSetting];
        }
    }
}

-(void)_switchCurrentMotion
{
    CGPoint lastMovingVector = ( currentMotion != nil )? currentMotion.lastMovingVector : CGPointZero;
    [MZSTGGameHelper destoryGameBase: &currentMotion];
    
    if( [motionSettingsQueue peek] != nil )
    {
        MZMotionSetting *nextMotionSetting = (MZMotionSetting *)[motionSettingsQueue pop];
        
        if( nextMotionSetting.isUsingPreviousMovingVector )
        {
            nextMotionSetting.movingVector = lastMovingVector;
        }

        currentMotion = [self _getNextMotionWithSetting: nextMotionSetting controlTarget: controlTargetRef];
        [currentMotion retain];
        [currentMotion enable];
                      
        if( !nextMotionSetting.isRunOnce )
        {
            [motionSettingsQueue push: nextMotionSetting];
        }
    }
}

-(void)_switchCurrentCharacterPartControls
{
    if( currentCharacterPartControls != nil )
    {
        [currentCharacterPartControls release];
    }
    
    currentCharacterPartControls = [[NSMutableArray alloc] initWithCapacity: 1];
    
    if( characterPartControlSettingsArray != nil )
    {
        for( MZCharacterPartControlSetting *characterPartControlSetting in characterPartControlSettingsArray )
        {        
            MZCharacterPart *controlCharacterPart = (MZCharacterPart *)[controlTargetRef getChildWithName: characterPartControlSetting.controlPartName];
            if( controlCharacterPart == nil ) continue;

            MZCharacterPartControl *characterPartControl = [MZCharacterPartControl characterControlPartWithSetting: characterPartControlSetting
                                                                                                  levelComponenets: levelComponentsRef
                                                                                                     characterPart: controlCharacterPart];
            characterPartControl.disableAttack = disableAttack;
            [characterPartControl enable];
            [currentCharacterPartControls addObject: characterPartControl];
        }
    }
}

-(void)_updateMotion
{   
    if( currentMotion == nil ) [self _switchCurrentMotion];
    
    if( currentMotion != nil )
    {
        [currentMotion update];
        
        if( !currentMotion.isActive )
            [self _switchCurrentMotion];
    }
}

-(void)_updateCharacterPartControls
{
    if( currentCharacterPartControls == nil ) [self _switchCurrentCharacterPartControls];
    
    if( currentCharacterPartControls != nil )
    {
        for( MZCharacterPartControl *characterPartControl in currentCharacterPartControls )
        {
            [characterPartControl update];
        }
    }
}

-(MZMotion_Base *)_getNextMotionWithSetting:(MZMotionSetting *)nextMotionSetting controlTarget:(MZGameObject *)controlTarget
{
    if( nextMotionSetting.isReferenceLeader )
    {
        MZAssert( [controlTarget isKindOfClass: [MZCharacter class]], @"Object Reference to leader must be MZCharacter" );
        MZCharacter *controlTargetCharacter = (MZCharacter *)controlTarget;
        
        if( controlTargetCharacter.leaderCharacterRef != nil )
        {
            return [[MZMotionsFactory sharedMZMotionsFactory] getReferenceToLeaderLinearMotionWithSetting: nextMotionSetting
                                                                                            controlTarget: controlTarget];
        }
    }
    
    return [[MZMotionsFactory sharedMZMotionsFactory] getMotionBySetting: nextMotionSetting controlTarget: controlTargetRef];
}

@end