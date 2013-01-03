#import "MZLoadingScene.h"
#import "MZSTGSettingsHeader.h"
#import "MZSceneTypeDefine.h"
#import "MZScenesHeader.h"
#import "MZScenesFactory.h"
#import "MZLogMacro.h"
#import "cocos2d.h"

#pragma mark - MZLoadingScene

@implementation MZLoadingScene

-(id)init
{
    self = [super init];
    if( self == nil ) return nil;
    
    [self addChild: [MZLoadingLayer node]];
    
    return self;
}

@end

#pragma mark - MZLoadingLayer

@interface MZLoadingLayer (Private)
-(void)_gotoNext:(mzTime)dt;
@end

#pragma mark

@implementation MZLoadingLayer

-(id)init
{
    if( (self = [super init]) )
    {
        [self schedule: @selector( _gotoNext: )];
        MZLog( @"" );
    }
    
    return self;
}

-(void)dealloc
{
    [super dealloc];
}

@end

#pragma mark

@implementation MZLoadingLayer (Private)

-(void)_gotoNext:(mzTime)dt
{
	[self unschedule: @selector( _gotoNext: )];
    MZSceneType nextScene = [MZScenesFlowController sharedScenesFlowController].nextScene;
    CCDirector *directior = [CCDirector sharedDirector];
    
    CCScene *scene = [[MZScenesFactory sharedInstance] sceneWithType: nextScene];
    [directior replaceScene: scene];
    
//    [CCTransitionTurnOffTiles transitionWithDuration: 0.5f scene: scene]
}

@end