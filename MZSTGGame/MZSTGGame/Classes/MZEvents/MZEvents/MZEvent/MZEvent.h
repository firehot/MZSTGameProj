#import "MZBehavior_Base.h"
#import "MZTypeDefine.h"

@class MZLevelComponents;

@interface MZEvent : MZBehavior_Base
{
    CGPoint position;
}

+(MZEvent *)eventWithLevelComponents:(MZLevelComponents *)aLevelComponents nsDictionary:(NSDictionary *)nsDictionary;
-(id)initWithLevelComponents:(MZLevelComponents *)aLevelComponents nsDictionary:(NSDictionary *)nsDictionary;
-(void)draw;
-(void)forceToEnd;
-(NSObject *)getResultObject;

@property (nonatomic, assign, readwrite) float occurTime;
@property (nonatomic, assign, readwrite) CGPoint position;
@property (nonatomic, readonly) NSString *eventType;

@end

@interface MZEvent (Protected)
-(void)_initWithDictionary:(NSDictionary *)dictionary;
@end

