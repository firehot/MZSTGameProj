#import <Foundation/Foundation.h>
#import "ccTypes.h"
#import "CCActionInterval.h"

@class CCMoveTo;
@class CCMoveBy;
@class CCSpawn;

@interface MZCCActionIntervalHelper : NSObject

// CCMove support
+(CCMoveTo *)moveToWithDuraton:(ccTime)duration standardPosition:(CGPoint)standardPosition;
+(CCMoveBy *)moveByWithDuraton:(ccTime)duration standardPosition:(CGPoint)standardPosition;

// to Normal, Thin, Fat actions. size is original size
+(CCSpawn *)actionToNormalWithScale:(float)scale stdPosition:(CGPoint)stdPosition stepTime:(float)stepTime;
+(CCSpawn *)actionToThinWithSize:(CGSize)size scale:(float)scale diff:(float)diff stdPosition:(CGPoint)stdPosition stepTime:(float)stepTime;
+(CCSpawn *)actionToFatWithSize:(CGSize)size scale:(float)scale diff:(float)diff stdPosition:(CGPoint)stdPosition stepTime:(float)stepTime;

@end
