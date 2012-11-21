#import "MZGamePlayHUD_Panel.h"
#import "MZGamePlayHUDLayer.h"
#import "MZCCUtilitiesHeader.h"
#import "MZGameCoreHeader.h"
#import "cocos2d.h"

@implementation MZGamePlayHUD_Panel

#pragma mark - override 

-(void)beforeRelease
{
    [targetLayerRef removeChild: top cleanup: false]; [top release];
    [targetLayerRef removeChild: bottom cleanup: false]; [bottom release];
    [targetLayerRef removeChild: left cleanup: false]; [left release];
    [targetLayerRef removeChild: right cleanup: false]; [right release];
}

@end

#pragma mark

@implementation MZGamePlayHUD_Panel (Protected)

#pragma mark - override

-(void)_init
{
    [super _init];
    
    [[MZFramesManager sharedFramesManager] addFrameWithFrameName: @"hud_bottom.png"];
    
    top = [CCSprite spriteWithSpriteFrameName: @"hud_bottom.png"];
    [top retain];
    top.flipY = true;
    top.position = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: mzp( 160, 510 )];
    top.opacity = ( [MZGameSetting sharedInstance].system.isEditMode )? 64 : 255;
    top.color = ccc3( 20, 20, 20 );
    [targetLayerRef addChild: top];
    
    bottom = [CCSprite spriteWithSpriteFrameName: @"hud_bottom.png"];
    [bottom retain];
    bottom.position = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: mzp( 160, -5 )];
    bottom.opacity = ( [MZGameSetting sharedInstance].system.isEditMode )? 64 : 255;
    bottom.color = ccc3( 20, 20, 20 );
    [targetLayerRef addChild: bottom];
    
    left = [CCSprite spriteWithSpriteFrameName: @"hud_bottom.png"];
    [left retain];
    left.position = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: mzp( -30, 240 )];
    left.opacity = ( [MZGameSetting sharedInstance].system.isEditMode )? 64 : 255;
    left.color = ccc3( 20, 20, 20 );
    left.rotation = -90;
    left.scaleY = 0.5;
    [targetLayerRef addChild: left];
    
    right = [CCSprite spriteWithSpriteFrameName: @"hud_bottom.png"];
    [right retain];
    right.position = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: mzp( 350, 240 )];
    right.opacity = ( [MZGameSetting sharedInstance].system.isEditMode )? 64 : 255;
    right.color = ccc3( 20, 20, 20 );
    right.rotation = 90;
    right.scaleY = 0.5;
    [targetLayerRef addChild: right];
}

@end

