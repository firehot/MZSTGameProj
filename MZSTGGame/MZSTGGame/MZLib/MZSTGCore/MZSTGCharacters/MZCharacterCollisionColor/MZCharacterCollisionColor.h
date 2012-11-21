#import <Foundation/Foundation.h>
#import "MZCharacterTypeStrings.h"

@class MZColor;

@interface MZCharacterCollisionColor : NSObject 

+(MZCharacterCollisionColor *)sharedCharacterCollisionColor;
-(MZColor *)getCollisionColorByType:(MZCharacterType)type;

@property (nonatomic, readonly) MZColor *playerCollisionColor;
@property (nonatomic, readonly) MZColor *playerBulletCollisionColor;
@property (nonatomic, readonly) MZColor *enemyCollisionColor;
@property (nonatomic, readonly) MZColor *enemyBulletCollisionColor;

@end

@interface MZCharacterCollisionColor (Private)
-(id)_init;
@end