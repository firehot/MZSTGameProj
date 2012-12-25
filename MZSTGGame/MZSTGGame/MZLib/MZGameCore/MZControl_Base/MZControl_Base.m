#import "MZControl_Base.h"
#import "MZGameObject.h"
#import "MZObjectHelper.h"
#import "MZLogMacro.h"

@implementation MZControl_Base

@synthesize referenceTargetRef;

#pragma mark - init and dealloc

+(MZControl_Base *)controlWithTarget:(MZGameObject *)aControlTarget
{
    return [[[self alloc] initWithTarget: aControlTarget] autorelease];
}

-(id)initWithTarget:(MZGameObject *)aControlTarget;
{
    MZAssert( aControlTarget, @"aControlTarget is nil" );
    controlTargetRef = aControlTarget;
    
    self = [super init];
    
    return self;
}

-(void)dealloc
{
    controlTargetRef = nil;
    referenceTargetRef = nil;
    [super dealloc];
}

@end