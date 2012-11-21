#import <Foundation/Foundation.h>

@class MZPlayerControlCharacter;
@class MZGamePlayLayer;

@interface MZTouchesControlPlayer : NSObject
{
    MZPlayerControlCharacter *playerControlCharacterRef;
    MZGamePlayLayer *gamePlayLayerRef;
}

-(id)initWithPlayerControlCharacter:(MZPlayerControlCharacter *)aPlayerControlCharacter gamePlayLayerRef:(MZGamePlayLayer *)aGamePlayLayer;
-(void)touchesBegan:(NSSet *)touches event:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches event:(UIEvent *)event;
-(void)touchesEnded:(NSSet *)touches event:(UIEvent *)event;

@property (nonatomic, readonly) int touchesCount;

@end

@interface MZTouchesControlPlayer (Private)
-(void)_doValidTouchesEnded:(NSSet *)touches event:(UIEvent *)event;
-(void)_doPlayerTouchesAllEnded:(NSSet *)touches event:(UIEvent *)event;
-(void)_doPlayerTouchesNotAllEnded:(NSSet *)touches event:(UIEvent *)event;
-(UITouch *)_getActiveTouchWhenTouchesEnded:(NSSet *)touches event:(UIEvent *)event;
@end
