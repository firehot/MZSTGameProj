#define MZLog( desc, ... ) NSLog( @"%s: %@", __FUNCTION__, [NSString stringWithFormat:( desc ), ##__VA_ARGS__] )

#ifdef DEBUG
#define MZAssert(condition, desc, ...) \
    if( !( condition ) ) \
    { \
        NSLog( @"*** Assertion failure in %s: %@", __FUNCTION__, [NSString stringWithFormat:(desc), ##__VA_ARGS__] ); \
        [[NSAssertionHandler currentHandler] handleFailureInFunction: [NSString stringWithUTF8String: __FUNCTION__] \
        file: [NSString stringWithUTF8String: __FILE__] \
        lineNumber: __LINE__ \
        description: [NSString stringWithFormat:(desc), ##__VA_ARGS__], ##__VA_ARGS__]; \
    }\
    do{}while( !( condition ) )
#else
#define MZAssert(condition, desc, ...)
#endif