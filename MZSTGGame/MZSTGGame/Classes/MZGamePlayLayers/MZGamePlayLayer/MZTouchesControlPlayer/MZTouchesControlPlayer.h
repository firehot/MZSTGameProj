#import <Foundation/Foundation.h>

@protocol MZPlayerTouchDelegate <NSObject>
-(void)touchBeganWithPosition:(CGPoint)position;
-(void)touchMovedWithPosition:(CGPoint)position;
-(void)touchEndedWithPosition:(CGPoint)position;
@end

@protocol MZTouchSpaceDelegate <NSObject>
-(CGPoint)convertTouchToNodeSpace:(UITouch *)touch;
@end

@interface MZTouchesControlPlayer : NSObject
{
    id<MZPlayerTouchDelegate> playerTouchDelegate;
    id<MZTouchSpaceDelegate> touchSpaceDelegate;
}

-(id)initWithPlayerTouch:(id<MZPlayerTouchDelegate>)aPlayerTouch touchSpace:(id<MZTouchSpaceDelegate>)aTouchSpace;
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

/*
rename 希望???
*/