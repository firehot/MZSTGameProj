#import "MZGameSetting_GamePlay.h"
#import "MZCCDisplayHelper.h"
#import "MZLogMacro.h"

#define Z_INDEX_OF_BACKGROUND -900
#define Z_INDEX_OF_BACKGROUNDEFFECTS -850
#define Z_INDEX_OF_ENEMIES -800
#define Z_INDEX_OF_PLAYER_BULLETS -750
#define Z_INDEX_OF_EFFECTS -700
#define Z_INDEX_OF_REWARD_ITEMS -650
#define Z_INDEX_OF_ENEMY_BULLETS -550
#define Z_INDEX_OF_UI 500
#define Z_INDEX_OF_DEBUGUI 520

@interface MZGameSetting_GamePlay (Private)
-(int)_getIndexValueWithIndexName:(NSString *)indexName nsDictionaryOfIndexes:(NSDictionary *)nsDictionaryOfIndexes;
@end

@implementation MZGameSetting_GamePlay

@synthesize zIndexOfPlayer;
@synthesize zIndexOfPlayerBullets;
@synthesize zIndexOfEnemies;
@synthesize zIndexOfEnemyBullets;
@synthesize zIndexOfUI;
@synthesize zIndexOfEffects;
@synthesize zIndexOfBackground;
@synthesize zIndexOfBackgroundEffects;
@synthesize zIndexOfDebugInfo;
@synthesize zIndexOfRewardItems;
@synthesize zIndexOfHUDs;
@synthesize playerBoundary;
@synthesize realPlayerBoundary;
@synthesize levels;
@synthesize enrageRect;
@synthesize enrageRangeRectStringsDictionary;

#pragma mark - inits and dealloc

-(id)initWithNSDictionary:(NSDictionary *)nsDictionary
{
    if( ( self = [super init] ) )
    {
        MZAssert( nsDictionary != nil, @"nsDictionary is nil" );
        MZAssert( [nsDictionary objectForKey: @"playerBoundary"], @"PlayerBoundary is nil" );
        
        levels = [nsDictionary objectForKey: @"levels"]; [levels retain];
        
        playerBoundary = CGRectFromString( [nsDictionary objectForKey: @"playerBoundary"] );
        enrageRangeRectStringsDictionary = [nsDictionary objectForKey: @"enrageRanges"]; [enrageRangeRectStringsDictionary retain];
    }
    
    return self;
}

-(void)dealloc
{
    [levels release];
    [enrageRangeRectStringsDictionary release];
    [super dealloc];
}

#pragma mark - properties

-(CGRect)realPlayerBoundary
{
    float deviceScale = [MZCCDisplayHelper sharedInstance].deviceScale;
    CGPoint realOriginPoint = [MZCCDisplayHelper sharedInstance].standardScreenRectInReal.origin;
    
    return CGRectMake( playerBoundary.origin.x*deviceScale + realOriginPoint.x,
                      playerBoundary.origin.y*deviceScale + realOriginPoint.y,
                      playerBoundary.size.width*deviceScale,
                      playerBoundary.size.height*deviceScale );
}

-(CGRect)realEnrageRect
{
    float deviceScale = [MZCCDisplayHelper sharedInstance].deviceScale;

    CGPoint realOrigin = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: enrageRect.origin];
    return CGRectMake( realOrigin.x, realOrigin.y, enrageRect.size.width*deviceScale, enrageRect.size.height*deviceScale );
}

@end

@implementation MZGameSetting_GamePlay (Private)

#pragma mark - inits

#pragma mark - methods

-(int)_getIndexValueWithIndexName:(NSString *)indexName nsDictionaryOfIndexes:(NSDictionary *)nsDictionaryOfIndexes
{
    NSString *indexValueString = [nsDictionaryOfIndexes objectForKey: indexName];
    
    if( indexValueString == nil )
    {
        MZLog( @"Not found index value of %@, will set to ZERO", indexName );
        return 0;
    }
    
    return [indexValueString intValue];
}

@end
