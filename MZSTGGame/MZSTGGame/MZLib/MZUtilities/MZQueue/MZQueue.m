#import "MZQueue.h"

@implementation NSMutableArray (MZQueue) 

-(id)pop
{
    if( [self count] <= 0 )
        return nil;
    
    id firstObject = [[[self objectAtIndex: 0] retain] autorelease];
    if( firstObject )
        [self removeObjectAtIndex: 0];
    return firstObject;
}

-(id)peek
{
    if( [self count] <= 0 )
        return nil;
    
    id firstObject = [[[self objectAtIndex: 0] retain] autorelease];
    return firstObject;
}

-(void)push:(id)obj
{
    [self addObject: obj];
}

@end
