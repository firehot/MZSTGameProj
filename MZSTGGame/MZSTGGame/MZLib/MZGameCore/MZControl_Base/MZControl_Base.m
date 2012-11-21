#import "MZControl_Base.h"
#import "MZGameObject.h"
#import "MZObjectHelper.h"
#import "MZLogMacro.h"

@implementation MZControl_Base

@synthesize referenceTargetRef;

#pragma mark - init and dealloc

+(MZControl_Base *)controlWithLevelComponenets:(MZLevelComponents *)aLevelComponents controlTarget:(MZGameObject *)aControlTarget
{
    return [[[self alloc] initWithLevelComponenets: aLevelComponents controlTarget: aControlTarget] autorelease];
}

-(id)initWithLevelComponenets:(MZLevelComponents *)aLevelComponents controlTarget:(MZGameObject *)aControlTarget
{
    MZAssert( aControlTarget, @"aControlTarget is nil" );
    controlTargetRef = aControlTarget;
    
    self = [super initWithLevelComponenets: aLevelComponents];
    
    return self;
}

-(void)dealloc
{
    controlTargetRef = nil;
    referenceTargetRef = nil;
    [super dealloc];
}

@end