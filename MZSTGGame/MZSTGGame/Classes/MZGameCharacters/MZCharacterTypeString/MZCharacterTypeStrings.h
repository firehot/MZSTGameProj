#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

@interface MZCharacterTypeStrings : NSObject

+(MZCharacterTypeStrings *)sharedInstance;
-(MZCharacterType)getMZCharacterTypeEnumByString:(NSString *)string;
-(NSString *)getCharacterTypeDescByType:(MZCharacterType)type;
-(NSString *)getCharacterClassNameByType:(MZCharacterType)type;
-(NSString *)getCharacterSettingClassNameByType:(MZCharacterType)type;

@property (nonatomic, readonly) NSString *player;
@property (nonatomic, readonly) NSString *enemy;
@property (nonatomic, readonly) NSString *playerBullet;
@property (nonatomic, readonly) NSString *enemyBullet;
@property (nonatomic, readonly) NSString *background;

@end
