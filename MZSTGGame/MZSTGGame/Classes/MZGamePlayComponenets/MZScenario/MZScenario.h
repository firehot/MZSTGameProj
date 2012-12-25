/*
    暫時報廢中 ...
*/

#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

@class MZEvent;
@class MZLevelComponents;

@interface MZScenario : NSObject 
{
    mzTime scenarioTimeCount;
    NSMutableArray *eventsQueue;
}

-(void)setEventsWithNSArray:(NSArray *)nsArray;
-(void)addEvent:(MZEvent *)event;
-(void)update;

@end

@interface MZScenario (Private)
@end