#import "MZLevelHud_BackgroundBillboards.h"
#import "CCSprite.h"
#import "MZGameSettingsHeader.h"
#import "MZCCDisplayHelper.h"

@implementation MZLevelHud_BackgroundBillboards

@synthesize upBillboard;

#pragma mark - override

-(void)dealloc
{
    [self removeChild: upBillboard cleanup: false];
    [upBillboard release];
    
    [self removeChild: downBillboard cleanup: false];
    [downBillboard release];
    
    [super dealloc];
}

@end

@implementation MZLevelHud_BackgroundBillboards (Protected)

#pragma mark - override

-(void)_initValues
{
//    float scaleX = 1.0;
//    float scaleY = 1.0;
//    
//    NSString *fileName = @"TestHUD.png";
//    CGSize imageSize = CGSizeMake( 512, 250 );
//    
//    float upBoardHeight = 30;
//    float downBoardHeight = 60;
//    
//    upBillboard = [CCSprite spriteWithFile: fileName];
//    [upBillboard retain];
//    upBillboard.position = [[MZCCDisplayHelper sharedDisplayHelper] 
//                            getRealPositionFromStandPosition: CGPointMake( 160, 480 + (imageSize.height/2 - upBoardHeight) )];
//    upBillboard.scaleX = scaleX;
//    upBillboard.scaleY = scaleY;
//    
//    [self addChild: upBillboard z: [MZGameSetting sharedGameSetting].gamePlay.zIndexOfHUDs];
//    
//    downBillboard = [CCSprite spriteWithFile: fileName];
//    [downBillboard retain];
//    downBillboard.position = [[MZCCDisplayHelper sharedDisplayHelper] 
//                              getRealPositionFromStandPosition: CGPointMake( 160, 0 - (imageSize.height/2 - downBoardHeight) )];
//    downBillboard.scaleX = scaleX;
//    downBillboard.scaleY = scaleY;
//    
//    [self addChild: downBillboard z: [MZGameSetting sharedGameSetting].gamePlay.zIndexOfHUDs];
}

@end


