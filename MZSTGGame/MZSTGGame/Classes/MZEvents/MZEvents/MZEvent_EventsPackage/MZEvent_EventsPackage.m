#import "MZEvent_EventsPackage.h"
#import "MZLevelComponentsHeader.h"
#import "MZEventsHeader.h"

@interface MZEvent_EventsPackage (Private)
-(void)_executeSubEvents;
@end

#pragma mark

@implementation MZEvent_EventsPackage

#pragma mark - override

-(void)dealloc
{
    [includedEventsSettingArray release];
    [super dealloc];
}

-(void)enable
{
    [super enable];
    [self _executeSubEvents];
    [self disable];
}

@end

#pragma mark

@implementation MZEvent_EventsPackage (Protected)

#pragma mark - override

-(void)_initWithDictionary:(NSDictionary *)nsDictionary
{
    self.position = CGPointFromString( [nsDictionary objectForKey: @"Position"] );
    includedEventsSettingArray = [[nsDictionary objectForKey: @"Events"] retain];
}

@end

#pragma mark

@implementation MZEvent_EventsPackage (Private)

#pragma mark - methods

-(void)_executeSubEvents
{
    for( NSDictionary *eventSettingDictionary in includedEventsSettingArray )
    {        
        MZEvent *event = [[MZEventsFactory sharedEventsFactory] eventByDcitionary: eventSettingDictionary];
        [levelComponentsRef.eventsExecutor executeEvent: event];
    }
}

@end