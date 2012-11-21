#import "MZAnimation.h"
#import "MZUtilitiesHeader.h"
#import "cocos2d.h"

@implementation MZAnimation

@synthesize numberOfFrames;
@synthesize frameSize;
@synthesize animationName;
@synthesize animation;

#pragma mark - init and dealloc

+(MZAnimation *)animationControlWithAnimationName:(NSString *)aAnimationName animation:(CCAnimation *)aAnimation
{
    return [[[self alloc] initWithAnimationName: aAnimationName animation: aAnimation] autorelease];
}

-(id)initWithAnimationName:(NSString *)aAnimationName animation:(CCAnimation *)aAnimation
{    
    if( (self = [super init]) ) 
    {
        animationName = [aAnimationName retain];
        animation = [aAnimation retain];
        
        numberOfFrames = [animation.frames count];
        
        CCAnimationFrame *animationFrame = [animation.frames objectAtIndex: 0];
        frameSize = animationFrame.spriteFrame.originalSizeInPixels;        
    }
    
    return self;
}

-(void)dealloc
{
    [animationName release];
    [animation release];
    [super dealloc];
}

#pragma mark - methods

-(CCSequence *)getAnimationSequenceIsRepeatForever:(BOOL)isRepeatForever
{
	CCAnimation *getAnimation = animation;
    
    MZAssert( getAnimation != nil, @"Animation lost(%@)", animationName );

	CCAnimate *getAnimate = [CCAnimate actionWithAnimation: getAnimation];
	
	CCSequence *sequence = nil;
	if( isRepeatForever )
	{
		CCAction *action = [CCRepeatForever actionWithAction: getAnimate];
		sequence = [CCSequence actions: (CCFiniteTimeAction *)action, nil];
	}
	else
	{
		sequence = [CCSequence actions: getAnimate, nil];
	}
	
    MZAssert( sequence != nil, @"Create animation sequence fail(%@)", animationName );
    
	return sequence;
}

@end
