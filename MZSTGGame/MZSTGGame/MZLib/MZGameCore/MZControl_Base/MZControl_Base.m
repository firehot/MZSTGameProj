#import "MZControl_Base.h"
#import "MZGameObject.h"
#import "MZObjectHelper.h"
#import "MZLogMacro.h"

@implementation MZControl_Base

@synthesize isRunOnce;

#pragma mark - init and dealloc

+(MZControl_Base *)controlWithDelegate:(id<MZControlDelegate>)aControlDelegate
{
    return [[[self alloc] initWithDelegate: aControlDelegate] autorelease];
}

-(id)initWithDelegate:(id<MZControlDelegate>)aControlDelegate
{
    self = [super init];

    controlDelegate = aControlDelegate;
    isRunOnce = false;
    
    return self;
}

-(void)dealloc
{
    controlDelegate = nil;
    [super dealloc];
}

@end