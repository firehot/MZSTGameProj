#import "MZGamePlayHUD_Buttons.h"
#import "MZGamePlayHUDLayer.h"
#import "MZCCDisplayHelper.h"
#import "MZScenesFlowController.h"
#import "MZGamePlayScene.h"
#import "cocos2d.h"

@interface MZGamePlayHUD_Buttons (Private)
-(void)_initButtons;

-(void)_onTest1Click:(id)sender;
-(void)_onTest2Click:(id)sender;
@end

@implementation MZGamePlayHUD_Buttons

#pragma mark - override

-(void)beforeRelease
{
    [targetLayerRef removeChild: buttonsMenu cleanup: false]; [buttonsMenu release];
}

@end

@implementation MZGamePlayHUD_Buttons (Protected)

#pragma mark - override

-(void)_init
{
    [super _init];
    [self _initButtons];
}

@end

@implementation MZGamePlayHUD_Buttons (Private)

#pragma mark - init 

-(void)_initButtons
{
    CCMenuItem *test1 = [CCMenuItemImage itemWithNormalSprite: [CCSprite spriteWithSpriteFrameName: @"TestPic.png"]
                                               selectedSprite: [CCSprite spriteWithSpriteFrameName: @"TestPic.png"]
                                                       target: self
                                                     selector: @selector( _onTest1Click: )];
    test1.position = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: CGPointMake( 50, 30 )];
    test1.scale = 0.7;
    
    CCMenuItem *test2 = [CCMenuItemImage itemWithNormalSprite: [CCSprite spriteWithSpriteFrameName: @"TestPic.png"]
                                               selectedSprite: [CCSprite spriteWithSpriteFrameName: @"TestPic.png"]
                                                       target: self
                                                     selector: @selector( _onTest2Click: )];
    test2.position = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: CGPointMake( 320-50, 30 )];
    test2.scale = 0.7;
    
    buttonsMenu = [CCMenu menuWithItems: test1, test2, nil];
    [buttonsMenu retain];
    buttonsMenu.position = CGPointZero;
    [targetLayerRef addChild: buttonsMenu];
}

#pragma mark - actions

-(void)_onTest1Click:(id)sender
{    
    [parentSceneRef switchSceneTo: kMZSceneType_Title];
}

-(void)_onTest2Click:(id)sender
{
    ( parentSceneRef.isPause )? [parentSceneRef resume] : [parentSceneRef pause];
}

@end