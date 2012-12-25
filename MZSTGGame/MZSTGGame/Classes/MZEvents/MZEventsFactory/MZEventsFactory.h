#import <Foundation/Foundation.h>

@class MZEvent;

@interface MZEventsFactory : NSObject
{

}

+(MZEventsFactory *)sharedInstance;
-(MZEvent *)eventByDcitionary:(NSDictionary *)eventDictionary;

@end
