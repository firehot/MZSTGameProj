#import "MZCharacter.h"

@class MZEventControlCharacterSetting;

@interface MZEventControlCharacter : MZCharacter 
{
    MZEventControlCharacterSetting *eventControlCharacterSetting;
}

+(MZEventControlCharacter *)character;
-(void)setSetting:(MZEventControlCharacterSetting *)aSetting characterType:(MZCharacterType)aCharacterType;

@end