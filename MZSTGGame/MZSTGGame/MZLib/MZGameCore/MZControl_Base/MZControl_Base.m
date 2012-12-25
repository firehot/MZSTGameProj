#import "MZControl_Base.h"
#import "MZGameObject.h"
#import "MZObjectHelper.h"
#import "MZLogMacro.h"

@implementation MZControl_Base

//@synthesize referenceTargetRef;

#pragma mark - init and dealloc

+(MZControl_Base *)controlWithDelegate:(id<MZControlDelegate>)aControlDelegate
{
    return [[[self alloc] initWithDelegate: aControlDelegate] autorelease];
}

-(id)initWithDelegate:(id<MZControlDelegate>)aControlDelegate
{
    self = [super init];

    controlDelegate = aControlDelegate;
    
    return self;
}

-(void)dealloc
{
//    controlTargetRef = nil;
    controlDelegate = nil;
//    referenceTargetRef = nil;
    [super dealloc];
}

@end