#import "MZGameConfig.h"

//NSString *NSStringFromBool(bool b)
//{
//    return [NSString stringWithFormat:( @"%@" ), ( b )? @"true" : @"false"];
//}

#define NSStringFromBool( boolValue ) [NSString stringWithFormat: @"%@", ( boolValue )? @"true" : @"false"]

#define MZLog( desc, ... ) NSLog( @"%s: %@", __FUNCTION__, [NSString stringWithFormat:( desc ), ##__VA_ARGS__] )

// 其實這些都是 Game 用 Log 的說 ... 

#ifdef DEBUG
#define MZLodingLog( level, desc, ... ) \
if( MZ_LOG_LOADING_STATE >= level ) MZLog( desc, ##__VA_ARGS__ )
#else
#define MZLodingLog(condition, desc, ...)
#endif

#ifdef DEBUG
#define MZCharacterCreateLog( level, desc, ... ) \
if( MZ_LOG_CHARACTER_CREATE != 0 && ( MZ_LOG_CHARACTER_CREATE == level || MZ_LOG_CHARACTER_CREATE == 3 ) ) MZLog( desc, ##__VA_ARGS__ )
#else
#define MZCharacterCreateLog(condition, desc, ...)
#endif


#ifdef DEBUG
#define MZAssert( condition, desc, ...) \
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

#ifdef DEBUG
#define MZAssertFasle( desc, ... ) MZAssert( false, desc, ##__VA_ARGS__ )
#else
#define MZAssertFasle( desc, ... )
#endif

#ifdef DEBUG
#define MZAssertSingleton( singletonClass ) MZAssert( singletonClass == nil, @"I am singleton pattern!!!!, you suck to init me twice" )
#else
#define MZAssertSingleton( singletonClass )
#endif