#import "MZDictionaryArray.h"
#import "MZLogMacro.h"

@implementation MZDictionaryArray

@synthesize count;
@synthesize array;
@synthesize dictionary;

#pragma mark - init and dealloc

+(MZDictionaryArray *)dictionaryArray
{ return [[[self alloc] init] autorelease]; }

-(void)dealloc
{
    [array release];
    [dictionary release];
    [super dealloc];
}

#pragma mark - properties

-(int)count
{
    return ( array != nil )? [array count] : -1;
}

#pragma mark - methods

-(void)addObject:(id)object key:(id<NSCopying>)key
{
    if( array == nil || dictionary == nil )
    {
        if( array != nil ) [array release];
        if( dictionary != nil ) [dictionary release];

        array = [[NSMutableArray alloc] initWithCapacity: 0];
        dictionary = [[NSMutableDictionary alloc] initWithCapacity: 0];
    }

    [array addObject: object];
    [dictionary setObject: object forKey: key];
}

-(id)objectAtIndex:(int)index
{
    if( array == nil ) return nil;
    MZAssert( 0 <= index && index < [array count], @"index = %d, array count = %d", index, [array count] );

    return [array objectAtIndex: index];
}

-(id)objectForKey:(id)key
{
    if( dictionary == nil ) return nil;
    if( [[dictionary allKeys] containsObject: key] == false ) return nil;

    return [dictionary objectForKey: key];
}

-(bool)containKey:(id)key
{
    return ( dictionary != nil )? [[dictionary allKeys] containsObject: key] : false;
}

-(int)indexOfObject:(id)object
{
    if( array == nil || [array count] ) return -1;
    return [array indexOfObject: object];
}

@end
 