#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

@interface MZCharacterDynamicSetting : NSObject
@property (nonatomic, readwrite) int strength;
@property (nonatomic, readwrite) CGPoint absolutePosition;
@property (nonatomic, readwrite) MZFaceToType faceTo;
@end
