#import "MZScenesFlowController.h"
#import "MZLogMacro.h"
#import "MZCCScenesFactory.h"
#import "cocos2d.h"

@implementation MZScenesFlowController

@synthesize nextScene;

MZScenesFlowController *sharedScenesFlowController_ = nil;

#pragma mark - init

+(MZScenesFlowController *)sharedScenesFlowController
{
    if( sharedScenesFlowController_ == nil )
        sharedScenesFlowController_ = [[MZScenesFlowController alloc] init];
    
    return sharedScenesFlowController_;
}

-(id)init
{
    MZAssert( sharedScenesFlowController_ == nil, @"i am singleton" );
    
    self = [super init];
    return self;
}

-(void)dealloc
{
    [sharedScenesFlowController_ release];
    sharedScenesFlowController_ = nil;
    
    [super dealloc];
}

#pragma mark - methods

-(void)fastSwitchToScene:(MZSceneType)sceneType
{
    nextScene = sceneType;
    [[CCDirector sharedDirector] replaceScene: [[MZCCScenesFactory sharedScenesFactory] sceneWithType: kMZSceneType_Release]];
}

@end
