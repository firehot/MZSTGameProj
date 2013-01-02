#import "MZCharacterTypeStrings.h"

@implementation MZCharacterTypeStrings
@synthesize player;
@synthesize enemy;
@synthesize playerBullet;
@synthesize enemyBullet;
@synthesize background;

static MZCharacterTypeStrings *sharedMZCharacterTypeStrings_ = nil;

#pragma mark - init and dealloc

+(MZCharacterTypeStrings *)sharedCharacterTypeStrings
{
    if( sharedMZCharacterTypeStrings_ == nil )
        sharedMZCharacterTypeStrings_ = [[MZCharacterTypeStrings alloc] init];
    return sharedMZCharacterTypeStrings_;
}

-(id)init
{
    if( (self = [super init]) )
    {
        player = @"MZPlayer";
        [player retain];
        
        enemy = @"MZEventControlCharacter";
        [enemy retain];
    
        playerBullet = @"MZEventControlCharacter";
        [playerBullet retain];
        
        enemyBullet = @"MZEventControlCharacter";
        [enemyBullet retain];
        
        background = @"MZEventControlCharacter";
        [background retain];
    }
    
    return self;
}

-(void)dealloc
{
    [player release];
    [enemy release];
    [playerBullet release];
    [enemyBullet release];
    [background release];
    
    [sharedMZCharacterTypeStrings_ release];
    sharedMZCharacterTypeStrings_ = nil;
    
    [super dealloc];
}

#pragma mark - methods

-(MZCharacterType)getMZCharacterTypeEnumByString:(NSString *)string
{
    NSString *string_ = [string lowercaseString];
    
    if( [string_ isEqualToString: @"player"] )
        return kMZCharacterType_Player;
    
    if( [string_ isEqualToString: @"enemy"] )
        return kMZCharacterType_Enemy;
    
    if( [string_ isEqualToString: @"playerbullet"] )
        return kMZCharacterType_PlayerBullet;
    
    if( [string_ isEqualToString: @"enemybullet"] )
        return kMZCharacterType_EnemyBullet;
    
    if( [string_ isEqualToString: @"background"] )
        return kMZCharacterType_Background;
    
    return kMZCharacterType_None;
}
                                                  
-(NSString *)getCharacterTypeDescByType:(MZCharacterType)type
{
    switch( type )
    {
        case kMZCharacterType_Player: return @"Player";
        case kMZCharacterType_Enemy: return @"Enemy";
        case kMZCharacterType_PlayerBullet: return @"PlayerBullet";
        case kMZCharacterType_EnemyBullet: return @"EnemyBullet";
        case kMZCharacterType_Background: return @"Background";
        default: return @"Unknow";
    }
}

-(NSString *)getCharacterClassNameByType:(MZCharacterType)type
{
    switch( type )
    {
        case kMZCharacterType_Player:
            return @"MZPlayer";
        case kMZCharacterType_Enemy:
            return @"MZEnemy";
        case kMZCharacterType_PlayerBullet:
            return @"MZPlayerBullet";
        case kMZCharacterType_EnemyBullet:
            return @"MZEnemyBullet";
            //        case kMZCharacterType_Background: // not suppert now
        case kMZCharacterType_EventControlCharacter:
            return @"MZEventControlCharacter";
        default:
            return @"Unknow";
    }
}

-(NSString *)getCharacterSettingClassNameByType:(MZCharacterType)type
{
    switch( type )
    {
        case kMZCharacterType_Player:
            return @"MZPlayerSetting";
        case kMZCharacterType_Enemy:
        case kMZCharacterType_PlayerBullet:
        case kMZCharacterType_EnemyBullet:
        case kMZCharacterType_Background:
            return @"MZEventControlCharacterSetting";
        default:
            return @"Unknow";
    }  
}

@end