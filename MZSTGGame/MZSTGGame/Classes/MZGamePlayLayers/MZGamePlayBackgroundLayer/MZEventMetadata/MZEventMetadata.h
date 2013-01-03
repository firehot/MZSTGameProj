#import <Foundation/Foundation.h>

@class MZEventOccurFlag;

@interface MZEventMetadata : NSObject

+(MZEventMetadata *)metadataWithEventDefineName:(NSString *)aEventDefineName position:(CGPoint)aPosition;
+(MZEventMetadata *)metadataWithDictionary:(NSDictionary *)dictionary;
-(id)initWithEventDefineName:(NSString *)aEventDefineName position:(CGPoint)aPosition;

@property (nonatomic, readwrite) bool hasExecuted;
@property (nonatomic, readwrite) CGPoint position;
@property (nonatomic, readonly) NSString *eventDefineName;
@end
