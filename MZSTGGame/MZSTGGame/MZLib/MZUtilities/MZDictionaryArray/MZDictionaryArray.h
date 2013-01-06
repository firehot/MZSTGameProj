#import <Foundation/Foundation.h>

@interface MZDictionaryArray : NSObject
{
@private
    NSMutableArray *array;
    NSMutableDictionary *dictionary;
}

-(void)addObject:(id)object key:(id<NSCopying>)key;

-(id)objectAtIndex:(int)index;
-(id)objectForKey:(id)key;

-(bool)containKey:(id)key;
-(int)indexOfObject:(id)object;

@property (nonatomic, readonly) int count;
@property (nonatomic, readonly) NSMutableArray *array;
@property (nonatomic, readonly) NSMutableDictionary *dictionary;


@end
