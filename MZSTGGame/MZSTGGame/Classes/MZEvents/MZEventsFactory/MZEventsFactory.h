#import <Foundation/Foundation.h>

@class MZLevelComponents;
@class MZEvent;

@interface MZEventsFactory : NSObject
{
    MZLevelComponents *levelComponentsRef;
}

+(MZEventsFactory *)sharedEventsFactory;
-(void)setOnLevelWithComponemts:(MZLevelComponents *)aLevelComponents;
-(void)removeFromLevel;
-(MZEvent *)eventByDcitionary:(NSDictionary *)eventDictionary;

@end
