#import "MZCharactersActionParamters.h"
#import "MZPlayer.h"
#import "MZLogMacro.h"

@implementation MZCharactersActionParamters

@synthesize activeEnemiesRef;
@synthesize activeEnemyBulletsRef;
@synthesize activePlayerBulletsRef;
@synthesize playerRef;

#pragma mark - init and dealloc

+(MZCharactersActionParamters *)charactersActionParamters
{
    return [[[self alloc] init] autorelease];
}

-(void)dealloc
{
    activeEnemiesRef = nil;
    activeEnemyBulletsRef = nil;
    activePlayerBulletsRef = nil;
    playerRef = nil ;
    
    [super dealloc];
}

#pragma mark - methods

-(void)checkCompleteness
{
    MZAssert( playerRef != nil, @"player is nil" );    
    MZAssert( activePlayerBulletsRef != nil, @"activePlayerBullets is nil" ); 
    MZAssert( activeEnemiesRef != nil, @"activeEnemies is nil" );
    MZAssert( activeEnemyBulletsRef != nil, @"activeEnemyBullets is nil" );
}

@end
