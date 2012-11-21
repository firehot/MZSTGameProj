#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

@class MZMotionSetting;

@interface MZCharacterPartControlSetting : NSObject 
{
    
}

+(MZCharacterPartControlSetting *)settingWithDictionary:(NSDictionary *)aDictionary controlName:(NSString *)aControlName;
-(id)initWithDictionary:(NSDictionary *)aDictionary controlName:(NSString *)aControlName;

@property (nonatomic, readwrite) MZFaceToType faceTo;
@property (nonatomic, readonly) NSString *controlName;
@property (nonatomic, readonly) NSString *controlPartName;
@property (nonatomic, readonly) NSMutableArray *attackSettingsArray;
@property (nonatomic, readonly) NSMutableArray *motionSettingsArray;

@end