#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

@class MZMotionSetting;

@interface MZModeSetting : NSObject 
{

}

+(MZModeSetting *)modeSettingWithNSDictionary:(NSDictionary *)nsDictionary;
-(id)initWithNSDictionary:(NSDictionary *)nsDictionary;
-(void)addMotionSetting:(MZMotionSetting *)motionSetting;

@property (nonatomic, readonly) bool isRunOnce;
@property (nonatomic, readonly) bool isRepeatForever;
@property (nonatomic, readonly) mzTime duration;
@property (nonatomic, readwrite, retain) NSString *name;
@property (nonatomic, readonly) NSMutableArray *motionSettings;
@property (nonatomic, readonly) NSMutableDictionary *characterPartControlSettingsDictionary;

@end