#import "MZPlayer.h"
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
    [userControlPlayerStyle release];
    
    [super dealloc];
}

#pragma mark - properties (override)

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