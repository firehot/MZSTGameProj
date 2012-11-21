#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

@class MZLevelComponents;

@interface MZBehavior_Base : NSObject
{
@private
    float timeAtEnable;
    float lifeTimeCount;
@protected
    NSMutableDictionary *childrenDictionary;
    MZLevelComponents *levelComponentsRef;
    MZBehavior_Base *parentRef;
}

+(MZBehavior_Base *)behaviorWithLevelComponenets:(MZLevelComponents *)aLevelComponents;
-(id)initWithLevelComponenets:(MZLevelComponents *)aLevelComponents;

-(void)setPropertiesWithDictionary:(NSDictionary *)propertiesDictionary;

-(void)addChild:(MZBehavior_Base *)child name:(NSString *)name;
-(MZBehavior_Base *)getChildWithName:(NSString *)childName;

-(void)enable;
-(void)disable;

-(void)update;

@property (nonatomic, readonly) bool isActive;
@property (nonatomic, readonly) float lifeTimeCount;
@property (nonatomic, readonly) NSMutableDictionary *childrenDictionary;
@property (nonatomic, assign, readwrite) MZBehavior_Base *parentRef;

@end

@interface MZBehavior_Base (Protected)
-(void)_initValues;
-(void)_checkActiveCondition;
-(void)_firstUpdate;
-(void)_update;
@end