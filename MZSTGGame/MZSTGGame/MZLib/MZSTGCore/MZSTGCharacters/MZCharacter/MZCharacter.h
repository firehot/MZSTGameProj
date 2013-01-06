#import "MZGameObject.h"
#import "MZTypeDefine.h"
#import "MZCharacterTypeStrings.h"

@class MZCharacterPart;
@class MZCCSpritesPool;

@interface MZCharacter : MZGameObject
{
    NSMutableDictionary *partsDictionary;
}

+(MZCharacter *)character;

-(MZCharacterPart *)addPartWithName:(NSString *)aName;

-(bool)isCollisionWithOtherCharacter:(MZCharacter *)otherCharacter;

#pragma mark - settings

@property (nonatomic, readwrite) MZCharacterType characterType;
@property (nonatomic, readwrite, assign) MZCCSpritesPool *partSpritesPoolRef;
@property (nonatomic, readwrite) bool disableAttack;

#pragma mark - states

@property (nonatomic, readwrite) int currentHealthPoint;

@end