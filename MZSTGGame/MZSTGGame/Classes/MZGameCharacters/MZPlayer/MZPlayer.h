#import "MZCharacter.h"
#import "MZGamePlayLayer.h"
#import "MZTouchesControlPlayer.h"

@class MZPlayerSetting;
@class MZUserControlPlayerStyleBase;

@interface MZPlayer : MZCharacter <MZPlayerTouchDelegate>
{
    MZPlayerSetting *playerSetting;
    MZUserControlPlayerStyleBase *userControlPlayerStyle;
}

+(MZPlayer *)player;
-(void)setSetting:(MZPlayerSetting *)aSetting;

@end