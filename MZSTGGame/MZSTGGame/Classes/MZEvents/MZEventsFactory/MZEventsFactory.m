#import "MZEventsFactory.h"
#import "MZEventsHeader.h"
#import "MZLogMacro.h"

@implementation MZEventsFactory

#pragma mark - init and dealloc

MZEventsFactory *sharedEventsFactory_ = nil;

+(MZEventsFactory *)sharedInstance
{
    if( sharedEventsFactory_ == nil )
        sharedEventsFactory_ = [[MZEventsFactory alloc] init];
    
    return sharedEventsFactory_;
}

-(void)dealloc
{    
    [sharedEventsFactory_ release];
    sharedEventsFactory_ = nil;
    
    [super dealloc];
}

#pragma mark - methods

-(MZEvent *)eventByDcitionary:(NSDictionary *)eventDictionary
{
    NSString *eventType = [eventDictionary objectForKey: @"type"];
    MZAssert( eventType != nil, @"Event Type can not be nil" );    
    
    NSString *eventClassName = [NSString stringWithFormat: @"MZEvent_%@", eventType];
    MZEvent *event = [NSClassFromString( eventClassName ) eventWithDictionary: eventDictionary];
    
    MZAssert( event, @"event is nil (name=%@)", eventClassName );

    return event;
}

@end