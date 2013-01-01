#import "MZTypeDefine.h"
#import "ccTypes.h"

@interface MZCharacterPartSetting : NSObject 
{

}

+(MZCharacterPartSetting *)setting;
+(MZCharacterPartSetting *)settingWithDictionary:(NSDictionary *)aDictionary name:(NSString *)aName;
-(id)initWithDictionary:(NSDictionary *)aDictionary name:(NSString *)aName;

@property (nonatomic, readwrite) GLenum blendFuncSrc;
@property (nonatomic, readwrite) GLenum blendFuncDest;
@property (nonatomic, readwrite) float scale;
@property (nonatomic, readwrite) CGPoint relativePosition;
@property (nonatomic, readwrite) ccColor3B color;
@property (nonatomic, readwrite, retain) NSString *name;
@property (nonatomic, readwrite, retain) NSString *frameName;
@property (nonatomic, readwrite, retain) NSString *animationName;
@property (nonatomic, readwrite, retain) NSMutableArray *collisions;

@end
 
@interface MZCharacterPartSetting (Private)
-(void)_setCollisionCircleWithNSArray:(NSArray *)nsArray;

@end