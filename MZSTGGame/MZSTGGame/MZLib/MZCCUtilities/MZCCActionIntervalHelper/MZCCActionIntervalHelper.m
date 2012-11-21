#import "MZCCActionIntervalHelper.h"
#import "MZCCDisplayHelper.h"

#pragma mark

@implementation MZCCActionIntervalHelper

#pragma mark - methods

+(CCMoveTo *)moveToWithDuraton:(ccTime)duration standardPosition:(CGPoint)standardPosition
{
    CGPoint realPosition = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: standardPosition];
    return [CCMoveTo actionWithDuration: duration position: realPosition];
}

+(CCMoveBy *)moveByWithDuraton:(ccTime)duration standardPosition:(CGPoint)standardPosition
{
    CGPoint realPosition = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: standardPosition];
    return [CCMoveBy actionWithDuration: duration position: realPosition];
}

+(CCSpawn *)actionToThinWithSize:(CGSize)size scale:(float)scale diff:(float)diff stdPosition:(CGPoint)stdPosition stepTime:(float)stepTime
{   
    CCScaleTo *stepScale = [CCScaleTo actionWithDuration: stepTime scaleX: scale - diff scaleY: scale + diff];
    CCMoveTo *stepMove = [MZCCActionIntervalHelper moveToWithDuraton: stepTime
                                                    standardPosition: mzp( stdPosition.x, stdPosition.y + size.height*diff )];
    return [CCSpawn actions: stepScale, stepMove, nil];
}

+(CCSpawn *)actionToFatWithSize:(CGSize)size scale:(float)scale diff:(float)diff stdPosition:(CGPoint)stdPosition stepTime:(float)stepTime
{   
    CCScaleTo *stepScale = [CCScaleTo actionWithDuration: stepTime scaleX: scale + diff scaleY: scale - diff];
    CCMoveTo *stepMove = [MZCCActionIntervalHelper moveToWithDuraton: stepTime
                                                    standardPosition: mzp( stdPosition.x, stdPosition.y - size.height*diff )];
    return [CCSpawn actions: stepScale, stepMove, nil];
}

+(CCSpawn *)actionToNormalWithScale:(float)scale stdPosition:(CGPoint)stdPosition stepTime:(float)stepTime
{
    CCScaleTo *step3Scale = [CCScaleTo actionWithDuration: stepTime scale: scale];
    CCMoveTo *step3Move = [MZCCActionIntervalHelper moveToWithDuraton: stepTime standardPosition: mzp( stdPosition.x, stdPosition.y )];
    return [CCSpawn actions: step3Scale, step3Move, nil];
}


@end