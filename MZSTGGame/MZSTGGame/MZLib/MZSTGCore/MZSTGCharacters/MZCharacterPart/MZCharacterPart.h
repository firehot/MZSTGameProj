#import "MZGameObject.h"
#import "MZTypeDefine.h"
#import "MZCharacterPartControl.h"
#import "MZAttack_Base.h"

@class MZCharacterPartSetting;
@class MZCharacter;

@interface MZCharacterPart : MZGameObject <MZCharacterPartControlDelegate, MZAttackDelegate>
{
    MZCharacter *parentCharacterRef;

    MZCharacterPartSetting *setting;
}

+(MZCharacterPart *)part;

@property (nonatomic, readwrite, retain) MZCharacterPartSetting *setting;
@property (nonatomic, readwrite, assign) MZCharacter *parentCharacterRef;
@property (nonatomic, readonly) MZCharacterType characterType;
@end

