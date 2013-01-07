#import "MZGameObject.h"
#import "MZTypeDefine.h"
#import "MZCharacterPartControl.h"
#import "MZAttack_Base.h"

@class MZCharacter;

@interface MZCharacterPart : MZGameObject <MZCharacterPartControlDelegate, MZAttackDelegate>
{
    MZCharacter *parentCharacterRef;
}

+(MZCharacterPart *)part;

@property (nonatomic, readwrite, assign) MZCharacter *parentCharacterRef;
@property (nonatomic, readonly) MZCharacterType characterType;
@end

