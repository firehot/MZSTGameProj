#import "MZTitleScene.h"
#import "MZCCScenesFactory.h"
#import "MZScenesHeader.h"
#import "MZFramesManager.h"
#import "MZCCDisplayHelper.h"
#import "MZGameSettingsHeader.h"
#import "cocos2d.h"

#pragma mark - MZTitleScene

@implementation MZTitleScene

-(id)init
{
    self = [super init];
    
    [self addChild: [MZTitleLayer node]];
    
    return self;
}

@end

#pragma mark - MZTitleLayer

@interface MZTitleLayer (Private)
-(void)_goLevel:(id)sender;
-(void)_onModeSwitchClick:(id)sender;
@end

@implementation MZTitleLayer

-(id)init
{
    self = [super init];

    [[MZFramesManager sharedFramesManager] addFrameWithFrameName: @"TestPic.png"];
    
    CCLabelTTF *lbl = [CCLabelTTF labelWithString: @"Title" fontName: @"Arial" fontSize: 50];
    lbl.position = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: mzp( 160, 240 )];
    
    [self addChild: lbl];
    
    CCMenuItem *btnGoLevel = [CCMenuItemImage itemWithNormalSprite: [CCSprite spriteWithSpriteFrameName: @"TestPic.png"]
                                                    selectedSprite: [CCSprite spriteWithSpriteFrameName: @"TestPic.png"]
                                                            target: self
                                                          selector: @selector( _goLevel: )];
    btnGoLevel.position = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: mzp( 160, 150 )];
    
    modeSwitchLabelRef = [CCLabelBMFont labelWithString: @"EditMode" fntFile: @"CooperStd.fnt"];
    CCMenuItemLabel *modeSwitchButton = [CCMenuItemLabel itemWithLabel: modeSwitchLabelRef
                                                                target: self
                                                              selector: @selector( _onModeSwitchClick: )];
    modeSwitchButton.position = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: mzp( 160, 390 )];
    [MZGameSetting sharedInstance].system.isEditMode = true;
    
    CCMenu *menu = [CCMenu menuWithItems: btnGoLevel, modeSwitchButton, nil];
    menu.position = CGPointZero;
    [self addChild: menu];
    
    return self;
}

@end

@implementation MZTitleLayer (Private)

-(void)_goLevel:(id)sender
{
    [[MZScenesFlowController sharedScenesFlowController] fastSwitchToScene: kMZSceneType_GamePlay];
//    [MZScenesFlowController sharedScenesFlowController].nextScene = kMZSceneType_Level;
//    [[CCDirector sharedDirector] replaceScene: [[MZCCScenesFactory sharedScenesFactory] getReleaseScene]];
}

-(void)_onModeSwitchClick:(id)sender
{
    if( [modeSwitchLabelRef.string isEqualToString: @"NormalMode"] )
    {
        modeSwitchLabelRef.string = @"EditMode";
        [MZGameSetting sharedInstance].system.isEditMode = true;
    }
    else if( [modeSwitchLabelRef.string isEqualToString: @"EditMode"] )
    {
        modeSwitchLabelRef.string = @"NormalMode";
        [MZGameSetting sharedInstance].system.isEditMode = false;
    }
}

@end
