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
    Class controlBaseClass;
    
    id<MZControlProtocol> currentControlRef;

    MZDictionaryArray *originControlsDictionaryArray;
    NSMutableArray *executingControlsArray;
}

+(MZControlUpdate *)controlUpdateWithBaseClass:(Class)aBaseClass;
-(id)initWithBaseClass:(Class)aBaseClass;

-(id<MZControlProtocol>)addWithKey:(id<NSCopying>)key;
-(id<MZControlProtocol>)add:(id<MZControlProtocol>)control key:(id<NSCopying>)key;

-(void)reset; // not test
-(void)update;

@property (nonatomic, readwrite) bool disableUpdate;

@property (nonatomic, readonly) Class controlBaseClass;
@property (nonatomic, readonly) id<MZControlProtocol> currentControl;
@property (nonatomic, readonly) MZDictionaryArray *controlsDictionaryArray;

@end


/*
 reset
 clear

 */