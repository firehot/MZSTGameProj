#import "MZEventsHeader.h"
#import "MZLevelComponentsHeader.h"
#import "MZGameSettingsHeader.h"
#import "MZUtilitiesHeader.h"

@interface MZEventsExecutor (Private)
-(void)_updateExecutingEvents;
-(void)_removeTerminalEvents;
-(void)_addPrepareToAddEvents;
-(MZEvent *)_getEventWithString:(NSString *)eventTypeString nsDictionary:(NSDictionary *)nsDictionary;
@end

#pragma mark

@implementation MZEventsExecutor

#pragma mark - init and dealloc

-(id)init
{
    self = [super init];
        
    onExecutingEventsArray = [[NSMutableArray alloc] initWithCapacity: 1];
    prepareToAddEventsTempArray = [[NSMutableArray alloc] initWithCapacity: 1];

    return self;
}

-(void)dealloc
{
    for( MZEvent *event in onExecutingEventsArray )
        [event disable];
    [onExecutingEventsArray release];
    
    [prepareToAddEventsTempArray release];
    [doNotResetEventClassesArray release];
    
    [super dealloc];
}

#pragma mark - methods

-(void)addDoNotResetEventClass:(Class)eventClass
{
    if( doNotResetEventClassesArray == nil )
        doNotResetEventClassesArray = [[NSMutableArray alloc] initWithCapacity: 1];
    
    [doNotResetEventClassesArray addObject: eventClass];
}

-(void)executeEvent:(MZEvent *)event
{
    [event enable];
    
    if( event.isActive )
        [prepareToAddEventsTempArray addObject: event];
}

-(void)executeEventWithTypeString:(NSString *)eventTypeString
                     nsDictionary:(NSDictionary *)nsDictionary
             duplicateProcessType:(MZEventDuplicateProcessType)duplicateProcessType
{
    switch( duplicateProcessType )
    {
        case kMZEventDuplicateProcessType_AddNormal:
        {
            [self executeEvent: [self _getEventWithString: eventTypeString nsDictionary: nsDictionary]];
        }
            break;
            
        case kMZEventDuplicateProcessType_RemoveAlreadyExisted:
        {
            Class newEventClass = NSClassFromString( [NSString stringWithFormat: @"MZEvent_%@", eventTypeString] );
            int disableCount = [self disableAllEventsWithClass: newEventClass];
            [self executeEvent: [self _getEventWithString: eventTypeString nsDictionary: nsDictionary]];
            
            if( [MZGameSetting sharedInstance].debug.showEventInfo )
                MZLog( @"add new event(%@), disable older count=%d", eventTypeString, disableCount );
        }
            break;
            
        case kMZEventDuplicateProcessType_DenyNew:
        {
            Class newEventClass = NSClassFromString( [NSString stringWithFormat: @"MZEvent_%@", eventTypeString] );
            int existedCount = [self numberOfEventsOnExecutingWithTargetClass: newEventClass];
            if( existedCount == 0 )
            {
                [self executeEvent: [self _getEventWithString: eventTypeString nsDictionary: nsDictionary]];            
            }
            else
            {
                if( [MZGameSetting sharedInstance].debug.showEventInfo )
                    MZLog( @"denny new event(%@), existed count=%d", eventTypeString, existedCount );
            }
        }
            break;
            
        default:
            break;
    }
}

-(void)reset
{
    for( int i = [onExecutingEventsArray count] - 1; i >= 0; i-- )
    {
        MZEvent *event = [onExecutingEventsArray objectAtIndex: i];
        
        bool doRemove = true;
        
        for( Class doNotResetEvent in doNotResetEventClassesArray )
        {
            if( [event class] == doNotResetEvent )
            {
                doRemove = false;
                break;
            }
        }
        
        if( doRemove )
            [onExecutingEventsArray removeObjectAtIndex: i];
    }
}

-(void)draw
{
    for( MZEvent *event in onExecutingEventsArray )
        [event draw];
}

-(void)update
{    
    [self _updateExecutingEvents];
    [self _removeTerminalEvents];
    [self _addPrepareToAddEvents];
}

-(int)disableAllEventsWithClass:(Class)targetEventClass
{
    int disableCount = 0;
    
    for( MZEvent *event in onExecutingEventsArray )
    {
        if( [event class] == targetEventClass ) 
        {
            disableCount++;
            [event disable];
        }
    }
    
    if( [MZGameSetting sharedInstance].debug.showEventInfo )
        MZLog( @"class=%@, count=%d", NSStringFromClass( targetEventClass ), disableCount );
    
    return disableCount;
}

-(int)disableAllEventsWithClasses:(NSArray *)targetEventClasses
{
    int disableCount = 0;
    
    for( MZEvent *event in onExecutingEventsArray )
    {
        for( Class targetEventClass in targetEventClasses )
        {
            if( [event class] == targetEventClass ) 
            {                
                disableCount++;
                [event disable];
            }
        }
    }
    
    if( [MZGameSetting sharedInstance].debug.showEventInfo )
        MZLog( @"classes=%@, count=%d", targetEventClasses, disableCount );
    
    return disableCount;
}

-(bool)anyEventOnExecutingWithTargetClass:(Class)eventClass
{
    for( MZEvent *executingEvent in onExecutingEventsArray )
    {
        if( [executingEvent class] == eventClass )
            return true;
    }
    
    return false;
}

-(bool)anyEventOnExecutingWithTargetClasses:(NSArray *)eventClasses
{
    for( MZEvent *executingEvent in onExecutingEventsArray )
    {
        for( Class eventClass in eventClasses )
        {
            if( [executingEvent class] == eventClass )
            {
                if( [MZGameSetting sharedInstance].debug.showEventInfo )
                    MZLog( @"%@ is on excuting", eventClass );
                return true;
            }
        }
    }
    
    return false;
}

-(int)numberOfEventsOnExecutingWithTargetClass:(Class)eventClass
{
    int numberOfOnExecutingEvent = 0;
    for( MZEvent *executingEvent in onExecutingEventsArray )
    {
        if( [executingEvent class] == [eventClass class] )
            numberOfOnExecutingEvent++;
    }
    
    return numberOfOnExecutingEvent;
}

@end

#pragma mark

@implementation MZEventsExecutor (Private)

#pragma mark - methods

-(void)_updateExecutingEvents
{        
    for( MZEvent *event in onExecutingEventsArray )
    {                     
        [event update];
    }
}

-(void)_removeTerminalEvents
{
    for( int i = [onExecutingEventsArray count] - 1; i >= 0; i-- )
    {
        MZEvent *event = [onExecutingEventsArray objectAtIndex: i];
        if( !event.isActive )
        {
            if( [MZGameSetting sharedInstance].debug.showEventInfo )
                MZLog( @"remove %@", NSStringFromClass( [event class] ) );
            
            [event disable];
            [onExecutingEventsArray removeObject: event];
        }
    }
}

-(void)_addPrepareToAddEvents
{
    if( [prepareToAddEventsTempArray count] <= 0 )
        return;
    
    for( MZEvent *prepareToAddEvent in prepareToAddEventsTempArray )
        [onExecutingEventsArray addObject: prepareToAddEvent];
    
    [prepareToAddEventsTempArray removeAllObjects];
}

-(MZEvent *)_getEventWithString:(NSString *)eventTypeString nsDictionary:(NSDictionary *)nsDictionary
{
    NSString *className = [NSString stringWithFormat: @"MZEvent_%@", eventTypeString];
    MZEvent *event = [NSClassFromString( className ) eventWithDictionary: nsDictionary];
    
    MZAssert( event, @"can not create new event with type string(%@)", eventTypeString );
    
    return event;
}

@end