#import "MZGameObject.h"
#import "MZTypeDefine.h"

@class MZCharacterPartSetting;

@class MZLevelComponents;

@interface MZCharacterPart : MZGameObject
{
    MZCharacterPartSetting *setting;
}

+(MZCharacterPart *)characterPartWithLevelComponenets:(MZLevelComponents *)aLevelComponents
                                              setting:(MZCharacterPartSetting *)aSetting
                                  parentCharacterType:(MZCharacterType)aParentCharacterType;
-(id)initWithLevelComponenets:(MZLevelComponents *)aLevelComponents
                      setting:(MZCharacterPartSetting *)aSetting
          parentCharacterType:(MZCharacterType)aParentCharacterType;
@property (nonatomic, readonly) MZCharacterType parentCharacterType;
@end

