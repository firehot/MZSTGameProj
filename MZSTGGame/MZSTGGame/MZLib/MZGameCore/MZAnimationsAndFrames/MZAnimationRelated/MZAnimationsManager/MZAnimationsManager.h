
@class CCAnimationCache;
@class CCSequence;
@class MZAnimation;

@interface MZAnimationsManager : NSObject
{
    NSMutableDictionary*animationControls;
    CCAnimationCache *sharedAnimationCacheRef;
}

+(MZAnimationsManager *)sharedInstance;
-(void)releaseAllAnimations;
-(void)addAnimationsFromPlistFile:(NSString *)plistName;
-(void)addAnimationsFromNSDictionary:(NSDictionary *)animationsSettingDictionary;
-(void)addAnimationWithNSDictionary:(NSDictionary *)nsDictionary name:(NSString *)name;
-(void)addAnimationWithAnimationName:(NSString *)animationName frameNamesArray:(NSArray *)frameNames intervalTime:(float)intervalTime;
-(MZAnimation *)getAnimationControlWithAnimationName:(NSString *)animationName;
@end