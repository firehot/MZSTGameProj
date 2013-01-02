#import "MZPlayer.h"
#import "MZPlayerSetting.h"
#import "MZUserControlPlayerStyleHeader.h"
#import "MZObjectHelper.h"
#import "MZGameSettingsHeader.h"
#import "MZLogMacro.h"

@implementation MZPlayer

#pragma mark - init and dealloc

+(MZPlayer *)player
{
    return [[[self alloc] init] autorelease];
}

-(void)dealloc
{
    [playerSetting release];
    [userControlPlayerStyle release];
    
    [super dealloc];
}

#pragma mark - properties (override)

-(void)setSetting:(MZCharacterSetting *)aSetting
{
    MZAssert( [aSetting isKindOfClass: [MZPlayerSetting class]], @"aSetting is not MZPlayerSetting class" );
    
    if( playerSetting == aSetting ) return;
    if( playerSetting != nil ) [playerSetting release];
    
    playerSetting = (MZPlayerSetting *)aSetting;
    [playerSetting retain];
}
                     
-(MZPlayerSetting *)setting
{
    if( playerSetting == nil ) playerSetting = [[MZPlayerSetting alloc] init];
    return playerSetting;
}

#pragma mark - MZPlayerTouchDelegate

-(void)touchBeganWithPosition:(CGPoint)touchPosition
{
    [userControlPlayerStyle touchBeganWithPosition: touchPosition];
    self.disableAttack = ( [MZGameSetting sharedInstance].system.isEditMode )? true : false;
}

-(void)touchMovedWithPosition:(CGPoint)touchPosition
{
    [userControlPlayerStyle touchMovedWithPosition: touchPosition];
}

-(void)touchEndedWithPosition:(CGPoint)touchPosition
{
    [userControlPlayerStyle touchEndedWithPosition: touchPosition];
    self.disableAttack = true;
}

#pragma mark - methods


@end

#pragma mark

@implementation MZPlayer (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    userControlPlayerStyle = [[MZUserControlPlayerStyle_RelativeMove alloc] initWithPlayerCharacter: self];
    self.disableAttack = true;
    self.characterType = kMZCharacterType_Player;
}

-(void)_update
{
    [super _update];
    [userControlPlayerStyle updateMove];
}

@end