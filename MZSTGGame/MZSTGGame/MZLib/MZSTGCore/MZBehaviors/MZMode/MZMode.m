#import "MZMode.h"
#import "MZQueue.h"
#import "MZObjectHelper.h"
#import "MZModeSetting.h"
#import "MZCharacter.h"
#import "MZMotionSetting.h"
#import "MZMove_Base.h"
#import "MZMotionsFactory.h"
#import "MZCharacterPartControlSetting.h"
#import "MZCharacterPartControl.h"
#import "MZSTGGameHelper.h"
#import "MZTime.h"
#import "MZUtilitiesHeader.h"
#import "MZLogMacro.h"

@interface MZMode (Private)
-(void)_initMotionSettingsQueue;
-(void)_initCharacterPartControlsSettingsArray;

-(void)_switchCurrentMotion;
-(void)_switchCurrentCharacterPartControls;

-(void)_updateMotion;
-(void)_updateCharacterPartControls;

-(MZMove_Base *)_getNextMotionWithSetting:(MZMotionSetting *)nextMotionSetting;
@end

#pragma mark

@implementation MZMode

@synthesize disableAttack;
@synthesize motionSettingsQueue;
@synthesize currentMotion;

#pragma mark - init and dealloc

+(MZMode *)modeWithDelegate:(id<MZModeDelegate>)aDelegate setting:(MZModeSetting *)aSetting
{
    return [[[self alloc] initWithDelegate: aDelegate setting: aSetting] autorelease];
}

-(id)initWithDelegate:(id<MZModeDelegate>)aDelegate setting:(MZModeSetting *)aSetting
{
    self = [super initWithDelegate: aDelegate];

    setting = ( aSetting != nil )? [aSetting retain] : nil;
    modeDelegate = aDelegate;
    disableAttack = false;
    
    return self;
}

+(MZMode *)mode
{ return [[self init] autorelease]; }

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

#pragma mark - override

-(void)enable
{
    [super enable];
    [self _switchCurrentMotion];
    [self _switchCurrentCharacterPartControls];
}

#pragma mark - methods

-(MZMove_Base *)addMoveWithName:(NSString *)name moveType:(MZMoveClassType)classType;
{
    if( movesDictionaryArray == nil) movesDictionaryArray = [[MZDictionaryArray alloc] init];;

// working
//MZMove_Base *move =

//    [movesDictionaryArray ]
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

        currentMotion = [self _getNextMotionWithSetting: nextMotionSetting];
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
            MZCharacterPart *characterPart = [modeDelegate getChildWithName: characterPartControlSetting.controlPartName];

            if( characterPart == nil ) continue;

            MZCharacterPartControl *characterPartControl = [MZCharacterPartControl                                                 characterPartControlWithDelegate: characterPart setting: characterPartControlSetting ];
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

-(MZMove_Base *)_getNextMotionWithSetting:(MZMotionSetting *)nextMotionSetting
{
    if( nextMotionSetting.isReferenceLeader )
    {
//        if( controlTargetCharacter.leaderCharacterRef != nil )
//        {
            return [[MZMotionsFactory sharedMZMotionsFactory] getReferenceToLeaderLinearMotionWithSetting: nextMotionSetting
                                                                                            controlTarget: (MZGameObject *)modeDelegate];
//        }
    }
    
    return [[MZMotionsFactory sharedMZMotionsFactory] getMotionBySetting: nextMotionSetting controlTarget: (MZGameObject *)modeDelegate];
}

@end