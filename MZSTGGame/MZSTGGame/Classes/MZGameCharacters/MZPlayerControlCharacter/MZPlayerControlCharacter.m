#import "MZPlayerControlCharacter.h"
#import "MZPlayerControlCharacterSetting.h"
#import "MZUserControlPlayerStyleHeader.h"
#import "MZObjectHelper.h"
#import "MZGameSettingsHeader.h"

@implementation MZPlayerControlCharacter

#pragma mark - init and dealloc

+(MZPlayerControlCharacter *)characterWithLevelComponenets:(MZLevelComponents *)aLevelComponents
{
    return [[[self alloc] initWithLevelComponenets: aLevelComponents] autorelease];
}

-(void)dealloc
{
    [playerControlCharacterSetting release];
    [userControlPlayerStyle release];
    
    [super dealloc];
}

#pragma mark - override

-(void)setSetting:(MZPlayerControlCharacterSetting *)aSetting
{
    [super setSetting: aSetting characterType: kMZCharacterType_Player];
    playerControlCharacterSetting = [(MZPlayerControlCharacterSetting *)setting retain];
}

#pragma mark - methods

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

@end

#pragma mark

@implementation MZPlayerControlCharacter (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    userControlPlayerStyle = [[MZUserControlPlayerStyle_RelativeMove alloc] initWithPlayerCharacter: self];
    self.disableAttack = true;
}

-(void)_update
{
    [super _update];
    [userControlPlayerStyle updateMove];
}

@end