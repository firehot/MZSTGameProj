#import <Foundation/Foundation.h>

@class MZControl_Base;
@class MZDictionaryArray;

@protocol MZControlProtocol <NSObject>
-(bool)isActive;
-(bool)isRunOnce;
-(void)reset;
-(void)enable;
-(void)update;
@end

@interface MZControlUpdate : NSObject
{
//    MZControl_Base *currentControlRef;
    id<MZControlProtocol> currentControlRef;

    MZDictionaryArray *originControlsDictionaryArray;
    NSMutableArray *executingControlsArray;
}

+(MZControlUpdate *)controlUpdate;

-(int)add:(id<MZControlProtocol>)control key:(id<NSCopying>)key;

-(void)reset; // not test
-(void)update;

@property (nonatomic, readwrite) bool disableUpdate;
@property (nonatomic, readonly) id<MZControlProtocol> currentControl;
@property (nonatomic, readonly) MZDictionaryArray *controlsDictionaryArray;

@end


/*
 reset
 clear

 */