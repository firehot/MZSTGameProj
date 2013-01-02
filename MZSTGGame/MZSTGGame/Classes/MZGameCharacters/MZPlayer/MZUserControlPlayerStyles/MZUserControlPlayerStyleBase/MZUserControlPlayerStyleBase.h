#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

@class MZPlayer;

@interface MZUserControlPlayerStyleBase : NSObject
{
    MZPlayer *playerControlCharacterRef;
}

-(id)initWithPlayerCharacter:(MZPlayer *)aPlayerControlCharacter;
-(void)touchBeganWithPosition:(CGPoint)touchPosition;
-(void)touchMovedWithPosition:(CGPoint)touchPosition;
-(void)touchEndedWithPosition:(CGPoint)touchPosition;
-(void)updateMove;
@end

@interface MZUserControlPlayerStyleBase (Private)
-(void)_initValues;
@end