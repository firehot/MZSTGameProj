#import <Foundation/Foundation.h>
#import "MZCharacterTypeStrings.h"

@class MZLevelComponents;
@class MZCharacter;
@class MZCharacterSetting;
@class MZPlayerControlCharacter;
@class MZEventControlCharacter;
@class MZColor;

@interface MZCharactersFactory : NSObject 
{    
    NSMutableDictionary *playerControlCharactersSettingDictionary;
    NSMutableDictionary *enemiesSettingDictionary;
    NSMutableDictionary *bulletsSettingDictionary;
}

+(MZCharactersFactory *)sharedInstace;
-(void)removeFromLevel; // can not remove now ...
-(void)addSettingWithCharacterType:(MZCharacterType)characterType settingDictionary:(NSDictionary *)settingDictionary;
-(void)addSettingWithCharacterType:(MZCharacterType)characterType fromPlistFile:(NSString *)plistFileName;
-(MZCharacter *)getCharacterByType:(MZCharacterType)characterType settingName:(NSString *)settingName;
@end
