#import <Foundation/Foundation.h>
#import "CCTexture2D.h"

@interface MZGameSetting_System : NSObject

-(id)initWithNSDictionary:(NSDictionary *)nsDictionary;

@property (nonatomic, readwrite) bool isEditMode;
@property (nonatomic, readonly) float fps;
@property (nonatomic, readonly) CCTexture2DPixelFormat texture2DPixelFormat;
@property (nonatomic, readonly) CGRect playRange;

@end
