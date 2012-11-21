#import "MZEventMetadata.h"
#import "MZUtilitiesHeader.h"
#import "MZEventOccurFlag.h"

@implementation MZEventMetadata

@synthesize hasExecuted;
@synthesize position;
@synthesize eventDefineName;

#pragma mark - init and dealloc

+(MZEventMetadata *)metadataWithEventDefineName:(NSString *)aEventDefineName position:(CGPoint)aPosition
{
    return [[[self alloc] initWithEventDefineName: aEventDefineName position: aPosition] autorelease];
}

+(MZEventMetadata *)metadataWithDictionary:(NSDictionary *)dictionary
{
    NSString *eventDefineName = [dictionary objectForKey: @"eventDefineName"];
    CGPoint position = CGPointFromString( [dictionary objectForKey: @"position"] );
    
    return [[[self alloc] initWithEventDefineName: eventDefineName position: position] autorelease];
}

-(id)initWithEventDefineName:(NSString *)aEventDefineName position:(CGPoint)aPosition
{
    MZAssert( aEventDefineName, @"aEventDefineName is nil" );

    self = [super init];

    hasExecuted = false;
    eventDefineName = [aEventDefineName retain];
    position = aPosition;

    return self;
}

-(void)dealloc
{
    [eventDefineName release];
    [super dealloc];
}

@end
