#import "MZEvent.h"
#import "MZEventsHeader.h"
#import "MZLevelComponents.h"
#import "MZLogMacro.h"

@implementation MZEvent

@synthesize occurTime;
@synthesize position;
@synthesize eventType;

#pragma mark - init and dealloc

+(MZEvent *)eventWithDictionary:(NSDictionary *)dictionary
{
    return [[[self alloc] initWithDictionary: dictionary] autorelease];
}

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    [self _initWithDictionary: dictionary];
    
    return self;
}

-(void)dealloc
{
    [eventType release];
    [super dealloc];
}

#pragma mark - methods

-(void)draw
{

}

-(void)forceToEnd
{
    MZAssert( false, @"override me" );
}

-(NSObject *)getResultObject
{
    MZAssert( false, @"override me" );
    return nil;
}

@end

#pragma mark

@implementation MZEvent (Protected)

#pragma mark - override

-(void)_update
{
    MZAssert( false, @"override me" );
}

#pragma mark - methods

-(void)_initWithDictionary:(NSDictionary *)dictionary
{
    MZAssert( false, @"override me" );
}

@end

#pragma mark

@implementation MZEvent (Private)
@end
