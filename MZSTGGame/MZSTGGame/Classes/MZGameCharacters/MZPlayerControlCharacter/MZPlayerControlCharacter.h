#import "MZCharacter.h"
#import "MZGamePlayLayer.h"

@class MZPlayerControlCharacterSetting;
@class MZUserControlPlayerStyleBase;

@interface MZPlayerControlCharacter : MZCharacter 
{
    MZPlayerControlCharacterSetting *playerControlCharacterSetting;
    MZUserControlPlayerStyleBase *userControlPlayerStyle;
}

-(void)touchBeganWithPosition:(CGPoint)touchPosition;
-(void)touchMovedWithPosition:(CGPoint)touchPosition;
-(void)touchEndedWithPosition:(CGPoint)touchPosition;
-(void)setSetting:(MZPlayerControlCharacterSetting *)aSetting;
@end