#define MZTypeBaseClassFunctionsHeader( class_name, init_func_name, type_enum ) \
\
+(class_name *)createWithClassType:( type_enum )classType; \
+(NSString *)classStringFromType:(MZTargetClassType)classType; \
+(class_name *)init_func_name;