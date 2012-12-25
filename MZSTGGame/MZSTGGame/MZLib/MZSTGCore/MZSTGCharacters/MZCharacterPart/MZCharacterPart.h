#import "MZGameObject.h"
#import "MZTypeDefine.h"
#import "MZCharacterPartControl.h"
#import "MZAttack_Base.h"

@class MZCharacterPartSetting;

@class MZLevelComponents;

@interface MZCharacterPart : MZGameObject <MZCharacterPartDelegate, MZAttackDelegate>
{
    MZCharacterPartSetting *setting;
}

+(MZCharacterPart *)characterPartWithSetting:(MZCharacterPartSetting *)aSetting parentCharacterType:(MZCharacterType)aParentCharacterType;
-(id)initWithSetting:(MZCharacterPartSetting *)aSetting parentCharacterType:(MZCharacterType)aParentCharacterType;
@property (nonatomic, readonly) MZCharacterType parentCharacterType;
@end

