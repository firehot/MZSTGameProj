#import "MZCharactersActionParamters.h"
#import "MZPlayer.h"
#import "MZLogMacro.h"

@implementation MZCharactersActionParamters

@synthesize activePlayers;
@synthesize activeEnemies;
@synthesize activeEnemyBullets;
@synthesize activePlayerBullets;
@synthesize player;

#pragma mark - init and dealloc

+(MZCharactersActionParamters *)charactersActionParamters
{
    return [[[self alloc] init] autorelease];
}

-(void)dealloc
{
    activePlayers = nil;
    activeEnemies = nil;
    activeEnemyBullets = nil;
    activePlayerBullets = nil;
    
    [super dealloc];
}

#pragma mark - properties

-(MZPlayer *)player
{
    MZAssert( activePlayers != nil && [activePlayers count] > 0, @"activePlayers is nil or count=0" );
    return [activePlayers objectAtIndex: 0];
}

#pragma mark - methods

-(void)checkCompleteness
{
    MZAssert( activePlayers != nil, @"activePlayers is nil" );
    MZAssert( activePlayerBullets != nil, @"activePlayerBullets is nil" ); 
    MZAssert( activeEnemies != nil, @"activeEnemies is nil" );
    MZAssert( activeEnemyBullets != nil, @"activeEnemyBullets is nil" );
}

@end
