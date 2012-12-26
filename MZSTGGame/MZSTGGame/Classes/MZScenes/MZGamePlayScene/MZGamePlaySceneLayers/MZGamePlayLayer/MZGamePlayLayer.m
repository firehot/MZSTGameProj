#import "MZGamePlayLayer.h"
#import "MZTouchesControlPlayer.h"
#import "MZGameSettingsHeader.h"
#import "MZUtilitiesHeader.h"
#import "MZCCUtilitiesHeader.h"
#import "MZLevelComponents.h"
#import "MZTime.h"
#import "MZGamePlayLayersHeader.h"
#import "MZGamePlayScene.h"
#import "cocos2d.h"

#import "MZAnimationHeader.h"

// test
#import "MZGameObject.h"

@interface MZGamePlayLayer (Private)
-(void)_initReferenceLines;

-(void)_addScheduleAndDispatcher;
-(void)_removeScheduleAndRemoveDispatcher;
@end

#pragma mark

@implementation MZGamePlayLayer

#pragma mark - init and dealloc

#pragma mark - CCStandardTouchDelegate

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [touchesControlPlayer touchesBegan: touches event: event];
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [touchesControlPlayer touchesMoved: touches event: event];
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [touchesControlPlayer touchesEnded: touches event: event];
}

#pragma mark - properties

-(NSNumber *)layerTypeInNSNumber
{
    return [NSNumber numberWithInt: kMZGamePlayLayerType_PlayLayer];
}

#pragma mark - override

-(void)draw
{

}

-(void)pause
{
    [self pauseSchedulerAndActions];
}

-(void)resume
{
    [self resumeSchedulerAndActions];
}

-(void)update
{
    [super update];
}

-(void)beforeRelease
{
    [self removeChild: referenceLines cleanup: false]; [referenceLines release];
    [touchesControlPlayer release];
    [self _removeScheduleAndRemoveDispatcher];
}

#pragma mark - methods

-(void)setControlWithPlayer:(MZPlayerControlCharacter *)player
{
    MZAssert( player, @"player is nil" );
    touchesControlPlayer = [[MZTouchesControlPlayer alloc] initWithPlayerControlCharacter: player gamePlayLayerRef: self];
}

@end

#pragma mark

@implementation MZGamePlayLayer (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    [self _initReferenceLines];
    [self _addScheduleAndDispatcher];
    
    [self __test_init];
}

-(void)_initWithLevelSettingDictionary:(NSDictionary *)levelSettingDictionary
{    
    [super _initWithLevelSettingDictionary: levelSettingDictionary];
}

@end

#pragma mark

@implementation MZGamePlayLayer (Private)

#pragma mark - methods

-(void)_initReferenceLines
{
    if( [MZGameSetting sharedInstance].debug.drawBoundary == false ) return;
    
    referenceLines = [CCDrawNode node];
    [referenceLines retain];
    
    // center point mark
    [referenceLines drawDot: [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: mzp( 160, 240 )]
                     radius: 5*[MZCCDisplayHelper sharedInstance].deviceScale
                      color: ccc4f( 0, 1, 1, 1 )];
    
    // standard screen
    CGRect screenRect = [MZCCDisplayHelper sharedInstance].standardScreenRect;
    [MZCCDrawPrimitivesHelper addToDrawNode: &referenceLines withStdRect: screenRect lineWidth: 2 color: ccc4f( 0, 1, 1, 0.5 )];
//    [MZCCDrawPrimitivesHelper addToDrawNode: &referenceLines withRect: realScreenRect lineWidth: 4 color: ccc4f( 0, 1, 1, 1 )];
    
    // player boundary
    CGRect playerBoundary = [MZGameSetting sharedInstance].gamePlay.playerBoundary;
    [MZCCDrawPrimitivesHelper addToDrawNode: &referenceLines withStdRect: playerBoundary lineWidth: 2 color: ccc4f( 1, 0, 0, 0.8 )];
    
    // zoom out boundary
    float zoomOutScale = 1.225;
    float zoomOutWidth = 768*zoomOutScale;
    float zoomOutHeight = 1024*zoomOutScale;
    CGRect zoomOutRect = CGRectMake( -( zoomOutWidth - 768 )/2, -( zoomOutHeight - 1024 )/2, zoomOutWidth, zoomOutHeight );
    [MZCCDrawPrimitivesHelper addToDrawNode: &referenceLines withRect: zoomOutRect lineWidth: 3 color: ccc4f( 0, 0, 1, 0.5 )];
    
    [self addChild: referenceLines];
}

-(void)_addScheduleAndDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addStandardDelegate: self priority: 10];
}

-(void)_removeScheduleAndRemoveDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate: self];
}

@end

#pragma mark

@implementation MZGamePlayLayer (Test)

-(void)__test_init
{
    MZGameObject *go = [[MZGameObject alloc] init];
    [go setSprite: [CCSprite node] parentLayer: self depth: 100];
    [go setFrameWithFrameName: @"Playermale_Normal0001.png"];
    go.position = mzp( 160, 240 );
}

@end