#import <Foundation/Foundation.h>

@class CCAnimation;
@class CCSequence;

@interface MZAnimation : NSObject 
{
    NSString *animationName;
    CCAnimation *animation;
}

+(MZAnimation *)animationControlWithAnimationName:(NSString *)aAnimationName animation:(CCAnimation *)aAnimation;
-(id)initWithAnimationName:(NSString *)aAnimationName animation:(CCAnimation *)aAnimation;
-(CCSequence *)getAnimationSequenceIsRepeatForever:(BOOL)isRepeatForever;

@property (nonatomic, readonly) int numberOfFrames;
@property (nonatomic, readonly) CGSize frameSize;
@property (nonatomic, readonly) NSString *animationName;
@property (nonatomic, readonly) CCAnimation *animation;

@end
