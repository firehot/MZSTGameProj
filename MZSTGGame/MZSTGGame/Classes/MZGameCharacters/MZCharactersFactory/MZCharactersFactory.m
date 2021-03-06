#import "MZCharactersFactory.h"
#import "MZSTGCharactersHeader.h"
#import "MZLevelComponentsHeader.h"
#import "MZGameSettingsHeader.h"
#import "MZCharacterTypeStrings.h"
#import "MZUtilitiesHeader.h"
#import "MZCharacterCollisionColor.h"
#import "MZColor.h"
#import "MZObjectHelper.h"
#import "MZCCSpritesPool.h"
#import "MZSTGGameHelper.h"

@interface MZCharactersFactory (Private)
@end

#pragma mark

@implementation MZCharactersFactory

#pragma mark - init and dealloc

-(id)initWithSpritePoolSupport:(id<MZSpritesPoolSupport>)aSpritesPoolSupport
{
    MZAssert( aSpritesPoolSupport != nil, @"aSpritesPoolSupport is nil");
    spritesPoolSupportRef = aSpritesPoolSupport;

    self = [super init];
    return self;
}

-(void)dealloc
{
    spritesPoolSupportRef = nil;    
    [super dealloc];
}

#pragma mark - methods

-(MZCharacter *)getByType:(MZCharacterType)type name:(NSString *)name
{
    MZAssert( spritesPoolSupportRef != nil, @"spritesPoolSupport is nil");

    // temp support
    switch( type )
    {
        case kMZCharacterType_Player:
            MZCharacterCreateLog( 1, @"Create Player(%@)", (name != nil)? name : @"" );
            return [self __test_player];

        case kMZCharacterType_Enemy:
            MZCharacterCreateLog( 2, @"Create Enemy(%@)", (name != nil)? name : @"" );
            return [self __test_enemy];

        case kMZCharacterType_EnemyBullet:
            MZCharacterCreateLog( 3, @"Create EnemyBullet(%@)", (name != nil)? name : @"" );
            return [self __test_enemy_bullet];

        case kMZCharacterType_PlayerBullet:
        default:
            return nil;
    }
}

@end

@implementation MZCharactersFactory (Private)
#pragma  mark - methods
@end

@implementation MZCharactersFactory (Test)

-(MZPlayer *)__test_player
{
    MZPlayer *testPlayer = [MZPlayer player];
    testPlayer.partSpritesPoolRef = [spritesPoolSupportRef spritesPoolByCharacterType: kMZCharacterType_Player];

    MZCharacterPart *p = [testPlayer addPartWithName: @"p"];
    [p setFrameWithFrameName: @"Playermale_Normal0001.png"];

    testPlayer.position = mzp( 160, 240 );

    return testPlayer;
}

-(MZEnemy *)__test_enemy
{
    MZEnemy *testEnemy = [MZEnemy enemy];
    testEnemy.partSpritesPoolRef = [spritesPoolSupportRef spritesPoolByCharacterType: kMZCharacterType_Enemy];

    MZCharacterPart *p = [testEnemy addPartWithName: @"p"];
    [p setFrameWithFrameName: @"Ika_normal0001.png"];

    return testEnemy;
}

-(MZBullet *)__test_enemy_bullet
{
    MZBullet *b = [MZBullet bullet];
    b.partSpritesPoolRef = [spritesPoolSupportRef spritesPoolByCharacterType: kMZCharacterType_EnemyBullet];

    MZCharacterPart *p = [b addPartWithName: @"p"];
    [p setFrameWithFrameName: @"bullet_24_normal0001.png"];

    return b;
}

@end
