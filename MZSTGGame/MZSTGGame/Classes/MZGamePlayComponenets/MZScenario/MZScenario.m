#import "MZScenario.h"
#import "MZEventsHeader.h"
#import "MZUtilitiesHeader.h"
#import "MZGameSettingsHeader.h"
#import "MZLevelComponentsHeader.h"
#import "MZTime.h"

@implementation MZScenario

#pragma mark - init and dealloc

-(void)dealloc
{
    [eventsQueue release];
    
    [super dealloc];
}

#pragma mark - methods

-(void)setEventsWithNSArray:(NSArray *)nsArray
{
    if( nsArray == nil ) 
        return;
    
    for( NSDictionary *eventNSDictionary in nsArray )
    {        
        MZEvent *event = [[MZEventsFactory sharedInstance] eventByDcitionary: eventNSDictionary];
        [self addEvent: event];
    }
}

-(void)addEvent:(MZEvent *)event
{
    if( eventsQueue == nil )
        eventsQueue = [[NSMutableArray alloc] init];
    
    [eventsQueue push: event];
}

-(void)update
{
    scenarioTimeCount += [MZTime sharedInstance].deltaTime;
    
    MZEventsExecutor *eventsExecutor = [MZLevelComponents sharedInstance].eventsExecutor;
    
    if( eventsQueue == nil || eventsExecutor == nil )
        return;
    
    while( [eventsQueue peek] && ((MZEvent *)[eventsQueue peek]).occurTime <= scenarioTimeCount )
    {
        if( [MZGameSetting sharedInstance].debug.showScenarioInfo )
            MZLog( @"Event occur at: %0.2f(scenario timeCount=%0.2f)", [MZTime sharedInstance].totalTime, scenarioTimeCount );
        
        [eventsExecutor executeEvent: (MZEvent *)[eventsQueue pop]];
    }
}

@end

#pragma mark

@implementation MZScenario (Private)
@end