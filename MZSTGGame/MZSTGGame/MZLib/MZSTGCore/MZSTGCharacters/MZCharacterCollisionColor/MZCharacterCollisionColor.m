#import "MZCharacterCollisionColor.h"
#import "MZColor.h"
#import "MZLogMacro.h"

@implementation MZCharacterCollisionColor

@synthesize playerCollisionColor;
@synthesize playerBulletCollisionColor;
@synthesize enemyCollisionColor;
@synthesize enemyBulletCollisionColor;

MZCharacterCollisionColor *sharedCharacterCollisionColor_ = nil;

+(MZCharacterCollisionColor *)sharedCharacterCollisionColor
{
    if( sharedCharacterCollisionColor_ == nil )
        sharedCharacterCollisionColor_ = [[MZCharacterCollisionColor alloc] _init];
    return sharedCharacterCollisionColor_;
}

-(void)dealloc
{
    [playerCollisionColor release];
    [playerBulletCollisionColor release];
    [enemyCollisionColor release];
    [enemyBulletCollisionColor release];
    
    [sharedCharacterCollisionColor_ release];
    sharedCharacterCollisionColor_ = nil;
    
    [super dealloc];
}

-(MZColor *)getCollisionColorByType:(MZCharacterType)type
{
    switch( type ) 
    {
        case kMZCharacterType_Player:
            return [MZCharacterCollisionColor sharedCharacterCollisionColor].playerCollisionColor;
        case kMZCharacterType_Enemy:
            return [MZCharacterCollisionColor sharedCharacterCollisionColor].enemyCollisionColor;
        case kMZCharacterType_PlayerBullet:
            return [MZCharacterCollisionColor sharedCharacterCollisionColor].playerBulletCollisionColor;
        case kMZCharacterType_EnemyBullet:
            return [MZCharacterCollisionColor sharedCharacterCollisionColor].enemyBulletCollisionColor;
        default: break;
    }
    
    MZAssert( false, @"Unknoww type(%@)", [[MZCharacterTypeStrings sharedCharacterTypeStrings] getCharacterTypeDescByType: type] );
    return nil;
}

@end

@implementation MZCharacterCollisionColor (Private)

-(id)_init
{
    if( ( self = [super init] ) )
    {
        playerCollisionColor = [[MZColor alloc] initWithRed: 0 green: 255 blue: 0];
        playerBulletCollisionColor = [[MZColor alloc] initWithRed: 255 green: 0 blue: 255];
        enemyCollisionColor = [[MZColor alloc] initWithRed: 0 green: 0 blue: 255];
        enemyBulletCollisionColor = [[MZColor alloc] initWithRed: 255 green: 255 blue: 0];        
    }
    
    return self;
}

@end