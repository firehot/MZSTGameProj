#import <Foundation/Foundation.h>

@interface MZCharacterSetting : NSObject 
{

}

+(MZCharacterSetting *)settingWithDictionary:(NSDictionary *)nsDictionary;
-(id)initWithDictionary:(NSDictionary *)nsDictionary;

@property (nonatomic, readonly) int healthPoint;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSMutableDictionary *characterPartSettingsDictionary;
@property (nonatomic, readonly) NSMutableArray *modeSettings;

@end