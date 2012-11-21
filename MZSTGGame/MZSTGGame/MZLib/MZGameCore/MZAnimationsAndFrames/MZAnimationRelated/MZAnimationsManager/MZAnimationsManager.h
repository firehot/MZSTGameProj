#import <Foundation/Foundation.h>

@class CCAnimationCache;
@class CCSequence;
@class MZAnimation;

@interface MZAnimationsManager : NSObject
{
    NSMutableDictionary*animationControls;
    CCAnimationCache *sharedAnimationCacheRef;
}

+(MZAnimationsManager *)sharedAnimationsManager;
-(void)releaseAllAnimations;
-(void)addAnimationsFromPlistFile:(NSString *)plistName;
-(void)addAnimationsFromNSDictionary:(NSDictionary *)animationsSettingDictionary;
-(void)addAnimationWithNSDictionary:(NSDictionary *)nsDictionary name:(NSString *)name;
-(void)addAnimationWithAnimationName:(NSString *)animationName frameNamesArray:(NSArray *)frameNames intervalTime:(float)intervalTime;
-(MZAnimation *)getAnimationControlWithAnimationName:(NSString *)animationName;
@end

@interface MZAnimationsManager (Private)
-(NSArray *)_getFrameNamesWithNamePattern:(NSString *)namePattern 
                             extendedName:(NSString *)extendedName
                                    start:(int)start
                                      end:(int)end;
-(NSMutableArray *)_getAnimationFramesWithFrameNames:(NSArray *)frameNames;
@end
