#import <Foundation/Foundation.h>
#import "MZCharacterSetting.h"

@interface MZEnemySetting : MZCharacterSetting
{

}

+(MZEnemySetting *)settingWithDictionary:(NSDictionary *)settingDictionary;

@property(nonatomic, readonly) NSMutableArray *motionSettings; // delete
@property(nonatomic, readonly) NSMutableArray *attackSettings; // delete

@end

/*
 未來, 改用 Mode 來包 
 NSMutableArray *motionSettings;
 NSMutableArray *attackSettings;
*/