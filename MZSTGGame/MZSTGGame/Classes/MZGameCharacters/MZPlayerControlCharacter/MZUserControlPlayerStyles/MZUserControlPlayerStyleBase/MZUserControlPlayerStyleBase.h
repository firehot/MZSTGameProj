#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

@class MZPlayerControlCharacter;

@interface MZUserControlPlayerStyleBase : NSObject
{
    MZPlayerControlCharacter *playerControlCharacterRef;
}

-(id)initWithPlayerCharacter:(MZPlayerControlCharacter *)aPlayerControlCharacter;
-(void)touchBeganWithPosition:(CGPoint)touchPosition;
-(void)touchMovedWithPosition:(CGPoint)touchPosition;
-(void)touchEndedWithPosition:(CGPoint)touchPosition;
-(void)updateMove;
@end

@interface MZUserControlPlayerStyleBase (Private)
-(void)_initValues;
@end