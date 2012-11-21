#import "MZCharacter.h"

@class MZEventControlCharacterSetting;

@interface MZEventControlCharacter : MZCharacter 
{
    MZEventControlCharacterSetting *eventControlCharacterSetting;
}

+(MZEventControlCharacter *)characterWithLevelComponenets:(MZLevelComponents *)aLevelComponents;
-(void)setSetting:(MZEventControlCharacterSetting *)aSetting characterType:(MZCharacterType)aCharacterType;

@end