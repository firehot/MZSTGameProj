#import "MZEventControlCharacter.h"
#import "MZEventControlCharacterSetting.h"
#import "MZModeSetting.h"
#import "MZCharacterPartControlSetting.h"
#import "MZLogMacro.h"

@implementation MZEventControlCharacter

#pragma mark - init and dealloc

+(MZEventControlCharacter *)characterWithLevelComponenets:(MZLevelComponents *)aLevelComponents
{
    return [[[self alloc] initWithLevelComponenets: aLevelComponents] autorelease];
}

-(void)dealloc
{
    [eventControlCharacterSetting release];
    [super dealloc];
}

#pragma mark - override

-(void)setSetting:(MZEventControlCharacterSetting *)aSetting characterType:(MZCharacterType)aCharacterType
{
    [super setSetting: aSetting characterType: aCharacterType];
    eventControlCharacterSetting = [(MZEventControlCharacterSetting *)setting retain];
}

@end