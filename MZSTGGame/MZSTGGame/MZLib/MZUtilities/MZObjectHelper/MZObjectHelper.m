#import "MZObjectHelper.h"
#import "MZLogMacro.h"

@implementation MZObjectHelper

+(void)releaseObject:(NSObject **)targetObject
{
    if( (*targetObject) != nil )
        [(*targetObject) release];
}

+(void)releaseAndSetNilToObject:(NSObject **)targetObject
{
    if( (*targetObject) == nil ) return;
    
    [(*targetObject) release];
    (*targetObject) = nil;
}

+(void)releaseAndSetNilToObjectWithRetainCountEqualOne:(NSObject **)targetObject
{
    if( (*targetObject) == nil ) return;
    
    if( [(*targetObject) retainCount] != 1 )
    {
        NSLog( @"%@", (*targetObject) );
        NSLog( @"%d", [(*targetObject) retainCount] );
        NSLog( @"What???" );
    }
    
    MZAssert( [(*targetObject) retainCount] == 1, 
              @"releaseAndSetNil: Object(%@, retain count=%d) can not set to Nil",
              (*targetObject),
              [(*targetObject) retainCount] );
    
    if( (*targetObject) != nil )
        [(*targetObject) release];
    (*targetObject) = nil;
}

@end