#import "MZTypeDefine.h"

@interface MZCharacterSetting : NSObject
{

}

+(MZCharacterSetting *)settingWithDictionary:(NSDictionary *)nsDictionary;
-(id)initWithDictionary:(NSDictionary *)nsDictionary;

@property (nonatomic, readwrite) int healthPoint;
@property (nonatomic, readwrite) MZCharacterType characterType;
@property (nonatomic, readwrite, retain) NSString *name;
@property (nonatomic, readwrite, retain) NSMutableDictionary *characterPartSettingsDictionary;
@property (nonatomic, readwrite, retain) NSMutableArray *modeSettings;

@end