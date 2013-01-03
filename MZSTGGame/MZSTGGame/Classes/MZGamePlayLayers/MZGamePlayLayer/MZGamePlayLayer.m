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
#import "MZCCSpritesPool.h"
#import "MZGameObject.h"
#import "MZCharacterPart.h"
#import "MZCharacter.h"
#import "MZCharacterPartSetting.h"
#import "MZGLHelper.h"
#import "MZMath.h"
#import "MZSTGCharactersHeader.h"

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
    [self __test_update];
}

-(void)beforeRelease
{
    [self removeChild: referenceLines cleanup: false]; [referenceLines release];
    [touchesControlPlayer release];
    [self _removeScheduleAndRemoveDispatcher];

    [self __test_release];
    
    [super beforeRelease];
}

#pragma mark - methods

-(void)setControlWithPlayer:(MZPlayer *)player
{
    MZAssert( player, @"player is nil" );
    touchesControlPlayer = [[MZTouchesControlPlayer alloc] initWithPlayerTouch: player touchSpace: self];
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
    [self __test_init_spritesPool];
//    [self __test_characterPart];
//    [self __test_character];
    [self __test_init_player];
    [self __test_init_enemy];
}

-(void)__test_init_spritesPool
{
    ccBlendFunc blend = (ccBlendFunc){ [MZGLHelper defaultBlendFuncSrc], [MZGLHelper defaultBlendFuncDest] };
    
    [self addSpritesPool: [MZCCSpritesPool poolWithTextureName: @"[test]enemies_atlas.png" layer: self number: 100 blendFunc: blend]
                     key: kMZGamePlayLayerActorType_Enemy];

    [self addSpritesPool: [MZCCSpritesPool poolWithTextureName: @"player_male.pvr.ccz" layer: self number: 100 blendFunc: blend]
                     key: kMZGamePlayLayerActorType_Player];

    [self addSpritesPool: [MZCCSpritesPool poolWithTextureName: @"[test]bullets_atlas.png" layer: self number: 100 blendFunc: blend]
                     key: kMZGamePlayLayerActorType_PlayerBullet];

    [self addSpritesPool: [MZCCSpritesPool poolWithTextureName: @"[test]bullets_atlas.png" layer: self number: 100 blendFunc: blend]
                     key: kMZGamePlayLayerActorType_EnemyBullet];
}

-(void)__randomAssignGameObjectWithFrameName:(NSString *)frameName spritesPool:(MZCCSpritesPool *)spritesPool number:(int)number
{
    for( int i = 0; i < number; i++ )
    {
        MZGameObject *go = [[MZGameObject alloc] init];
        [go setSpritesFromPool: spritesPool];
        
        [go setFrameWithFrameName: frameName];
        go.position = mzp( [MZMath randomIntInRangeMin: 0 max: 320], [MZMath randomIntInRangeMin: 0 max: 480] );
        go.rotation = [MZMath randomIntInRangeMin: 0 max: 360];
    }
}

-(void)__test_random_sprites
{
    [self __randomAssignGameObjectWithFrameName: @"Playermale_Normal0001.png"
                                    spritesPool: [self spritesPoolByKey: kMZGamePlayLayerActorType_Player]
                                         number: 100];


    [self __randomAssignGameObjectWithFrameName: @"bullet_01_normal0001.png"
                                    spritesPool: [self spritesPoolByKey: kMZGamePlayLayerActorType_PlayerBullet]
                                         number: 100];

    [self __randomAssignGameObjectWithFrameName: @"bullet_22_0001.png"
                                    spritesPool: [self spritesPoolByKey: kMZGamePlayLayerActorType_EnemyBullet]
                                         number: 20];

    [self __randomAssignGameObjectWithFrameName: @"Ika_normal0001.png"
                                    spritesPool: [self spritesPoolByKey: kMZGamePlayLayerActorType_Enemy]
                                         number: 50];

}

-(void)__test_characterPart
{
    part = [MZCharacterPart part];
    [part retain];
    [part setSpritesFromPool: [self spritesPoolByKey: kMZGamePlayLayerActorType_Player]];
    part.setting.name = @"test";
    part.setting.frameName = @"Playermale_Normal0001.png";
    
    [part enable];

    part.position = mzp( 160, 240 );
}

-(void)__test_character
{
    // working
    testCharacter = [[MZCharacter alloc] init];
    testCharacter.characterType = kMZCharacterType_Enemy;
    testCharacter.partSpritesPoolRef = [self spritesPoolByKey: kMZGamePlayLayerActorType_Enemy];

    MZCharacterPart *p = [testCharacter addPartWithName: @"testPart"];
    p.setting.frameName = @"Ika_normal0001.png";
    p.position = mzp( 0, 10 );

    MZCharacterPart *p2 = [testCharacter addPartWithName: @"testPart02"];
    p2.setting.frameName = @"Ika_normal0002.png";
    p2.position = mzp( 0, -10 );
    p2.color = ccc3( 255, 0, 0 );

    testCharacter.position = mzp( 160, 240 );
    [testCharacter enable];
}

-(void)__test_init_player
{
    testPlayer = [MZPlayer player];
    [testPlayer retain];
    testPlayer.partSpritesPoolRef = [self spritesPoolByKey: kMZGamePlayLayerActorType_Player];
    
    MZCharacterPart *p = [testPlayer addPartWithName: @"p"];
    p.setting.frameName = @"Playermale_Normal0001.png";
//    [p setFrameWithFrameName: @"Playermale_Normal0001.png"];
    
    testPlayer.position = mzp( 160, 240 );
    [testPlayer enable];
    
    [self setControlWithPlayer: testPlayer];
}

-(void)__test_init_enemy
{
    // working
    testEnemy = [MZEnemy enemy];
    [testEnemy retain];
    testEnemy.partSpritesPoolRef = [self spritesPoolByKey: kMZGamePlayLayerActorType_Enemy];

    MZCharacterPart *p = [testEnemy addPartWithName: @"p"];
    p.setting.frameName = @"Ika_normal0001.png";

    testEnemy.position = mzp( 160, 400 );
    testEnemy.rotation = -90;

    [testEnemy enable];
}

-(void)__test_update
{
    if( testPlayer ) [testPlayer update];
}

-(void)__test_release
{
    [MZObjectHelper releaseObject: &part];
    [MZObjectHelper releaseObject: &testCharacter];
    [MZObjectHelper releaseObject: &testPlayer];
}

@end