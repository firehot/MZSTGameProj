#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

@class MZEvent;

typedef enum
{
    kMZEventDuplicateProcessType_AddNormal,
    kMZEventDuplicateProcessType_RemoveAlreadyExisted,
    kMZEventDuplicateProcessType_DenyNew,
    
}MZEventDuplicateProcessType;

@interface MZEventsExecutor : NSObject 
{
    NSMutableArray *prepareToAddEventsTempArray;
    NSMutableArray *onExecutingEventsArray;
    NSMutableArray *doNotResetEventClassesArray;
}

-(void)addDoNotResetEventClass:(Class)eventClass;
-(void)executeEvent:(MZEvent *)event;
-(void)executeEventWithTypeString:(NSString *)eventTypeString
                     nsDictionary:(NSDictionary *)nsDictionary
             duplicateProcessType:(MZEventDuplicateProcessType)duplicateProcessType;
-(void)reset;
-(void)draw;
-(void)update;
-(int)disableAllEventsWithClass:(Class)targetEventClass;
-(int)disableAllEventsWithClasses:(NSArray *)targetEventClasses;
-(bool)anyEventOnExecutingWithTargetClass:(Class)eventClass;
-(bool)anyEventOnExecutingWithTargetClasses:(NSArray *)eventClasses;
-(int)numberOfEventsOnExecutingWithTargetClass:(Class)eventClass;

@end