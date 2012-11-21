#import "MZBehavior_Base.h"
#import "MZLevelComponents.h"
#import "MZObjectHelper.h"
#import "MZTime.h"
#import "MZLogMacro.h"

@implementation MZBehavior_Base

@synthesize isActive;
@synthesize lifeTimeCount;
@synthesize childrenDictionary;
@synthesize parentRef;

#pragma mark - init and dealloc

+(MZBehavior_Base *)behaviorWithLevelComponenets:(MZLevelComponents *)aLevelComponents
{
    return [[[self alloc] initWithLevelComponenets: aLevelComponents] autorelease];
}

-(id)initWithLevelComponenets:(MZLevelComponents *)aLevelComponents
{
    MZAssert( aLevelComponents, @"aLevelComponents is nil" );
    levelComponentsRef = aLevelComponents;
    
    if( ( self = [super init] ) )
    {
        [self _initValues];
    }
    
    return self;
}

-(void)dealloc
{
    [self disable];
    
    [childrenDictionary release];
    
    levelComponentsRef = nil;
    parentRef = nil;
    
    [super dealloc];
}

#pragma mark - properites

-(float)lifeTimeCount
{
    return [MZTime sharedInstance].totalTime - timeAtEnable;
}

#pragma mark - methods

-(void)setPropertiesWithDictionary:(NSDictionary *)propertiesDictionary
{

}

-(void)addChild:(MZBehavior_Base *)child name:(NSString *)name
{
    if( childrenDictionary == nil )
        childrenDictionary = [[NSMutableDictionary alloc] initWithCapacity: 1];
    
    MZAssert( [childrenDictionary objectForKey: name] == nil, @"already has child (name=%@)", name );
    [childrenDictionary setObject: child forKey: name];
    child.parentRef = self;
}

-(MZBehavior_Base *)getChildWithName:(NSString *)childName
{
//    MZAssert( [childrenDictionary objectForKey: childName], @"child(name=%@) is nil", childName ); // 暫時不能加
    return [childrenDictionary objectForKey: childName];
}

-(void)enable
{
    isActive = true;
    timeAtEnable = [MZTime sharedInstance].totalTime;
    
    for( MZBehavior_Base *child in [childrenDictionary allValues] )
        [child enable];
}

-(void)disable
{
    isActive = false;
    
    for( MZBehavior_Base *child in [childrenDictionary allValues] )
        [child disable];
}

-(void)update
{
    if( lifeTimeCount == 0 )
        [self _firstUpdate];
    
    lifeTimeCount += [MZTime sharedInstance].deltaTime;
    
    [self _checkActiveCondition];
    
    if( !isActive )
        return;
    
    [self _update];
}

@end

#pragma mark

@implementation MZBehavior_Base (Protected)

#pragma mark - methods

-(void)_initValues
{

}

-(void)_releaseValues
{
//    [MZObjectHelper releaseAndSetNilToObject: &childrenDictionary];
}

-(void)_checkActiveCondition
{

}

-(void)_firstUpdate 
{

}

-(void)_update
{
    for( MZBehavior_Base *child in [childrenDictionary allValues] )
        [child update];
}

@end