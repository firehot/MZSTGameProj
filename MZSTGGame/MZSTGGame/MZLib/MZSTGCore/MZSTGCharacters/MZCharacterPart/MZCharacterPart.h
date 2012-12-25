#import "MZGameObject.h"
#import "MZTypeDefine.h"

@class MZCharacterPartSetting;

@class MZLevelComponents;

@interface MZCharacterPart : MZGameObject
{
    MZCharacterPartSetting *setting;
}

+(MZCharacterPart *)characterPartWithSetting:(MZCharacterPartSetting *)aSetting parentCharacterType:(MZCharacterType)aParentCharacterType;
-(id)initWithSetting:(MZCharacterPartSetting *)aSetting parentCharacterType:(MZCharacterType)aParentCharacterType;
@property (nonatomic, readonly) MZCharacterType parentCharacterType;
@end

