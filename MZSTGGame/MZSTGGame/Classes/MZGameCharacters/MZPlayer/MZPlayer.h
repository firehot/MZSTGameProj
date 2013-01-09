#import "MZCharacter.h"
#import "MZGamePlayLayer.h"
#import "MZTouchesControlPlayer.h"

@class MZUserControlPlayerStyleBase;

@interface MZPlayer : MZCharacter <MZPlayerTouchDelegate>
{
    MZUserControlPlayerStyleBase *userControlPlayerStyle;
}

+(MZPlayer *)player;

@end