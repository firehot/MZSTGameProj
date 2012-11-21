#import "MZTypeDefine.h"
#import "ccTypes.h"

@interface MZCharacterPartSetting : NSObject 
{

}

+(MZCharacterPartSetting *)characterPartSettingWithDictionary:(NSDictionary *)aDictionary name:(NSString *)aName;
-(id)initWithDictionary:(NSDictionary *)aDictionary name:(NSString *)aName;

@property (nonatomic, readonly) GLenum blendFuncSrc;
@property (nonatomic, readonly) GLenum blendFuncDest;
@property (nonatomic, readonly) float scale;
@property (nonatomic, readonly) CGPoint relativePosition;
@property (nonatomic, readonly) ccColor3B color;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *frameName;
@property (nonatomic, readonly) NSString *animationName;
@property (nonatomic, readonly) NSMutableArray *collisions;

@end
 
@interface MZCharacterPartSetting (Private)
-(void)_setCollisionCircleWithNSArray:(NSArray *)nsArray;

@end