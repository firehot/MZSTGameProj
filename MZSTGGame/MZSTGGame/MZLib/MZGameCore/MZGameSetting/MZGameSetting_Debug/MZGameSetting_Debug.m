#import "MZGameSetting_Debug.h"
#import "MZLogMacro.h"

@implementation MZGameSetting_Debug

@synthesize showLoadingStates;
@synthesize showFPS;
@synthesize showMemoryUsage;
@synthesize showCharactersNumber;
@synthesize showCharacterSpawnInfo;
@synthesize showScenarioInfo;
@synthesize showEventInfo;
@synthesize drawCollisionRange;
@synthesize drawBoundary;
@synthesize drawBGEventsInfo;
//@synthesize isDrawPlayer;
//@synthesize isDrawEnemies;
//@synthesize isDrawPlayerBullets;
//@synthesize isDrawEnemyBullets;
//@synthesize enablePlayerAttack;
//@synthesize enableEnemyAttack;

#pragma mark - init and dealloc

-(id)initWithNSDictionary:(NSDictionary *)nsDictionary
{
    if( ( self = [super init] ) )
    {
        MZAssert( nsDictionary != nil, @"nsDictionary is nil" );

        showLoadingStates = [[nsDictionary objectForKey: @"ShowLoadingStates"] boolValue];
        showFPS = [[nsDictionary objectForKey: @"ShowFPS"] boolValue];
        showMemoryUsage = [[nsDictionary objectForKey: @"ShowMemoryUsage"] boolValue];
        showCharactersNumber = [[nsDictionary objectForKey: @"ShowCharactersNumber"] boolValue];
        showCharacterSpawnInfo = [[nsDictionary objectForKey: @"ShowCharacterSpawnInfo"] boolValue];
        showScenarioInfo = [[nsDictionary objectForKey: @"ShowScenarioInfo"] boolValue];
        showEventInfo = [[nsDictionary objectForKey: @"ShowEventInfo"] boolValue];
        drawCollisionRange = [[nsDictionary objectForKey: @"DrawCollisionRange"] boolValue];
        drawBoundary = [[nsDictionary objectForKey: @"DrawBoundary"] boolValue];
        drawBGEventsInfo = [[nsDictionary objectForKey: @"DrawBGEventsInfo"] boolValue];
        
//        isDrawPlayer = [[nsDictionary objectForKey: @"IsDrawPlayer"] boolValue];
//        isDrawEnemies = [[nsDictionary objectForKey: @"IsDrawEnemies"] boolValue];
//        isDrawPlayerBullets = [[nsDictionary objectForKey: @"IsDrawPlayerBullets"] boolValue];
//        isDrawEnemyBullets = [[nsDictionary objectForKey: @"IsDrawEnemyBullets"] boolValue];
//        enablePlayerAttack = [[nsDictionary objectForKey: @"EnablePlayerAttack"] boolValue];
//        enableEnemyAttack = [[nsDictionary objectForKey: @"EnableEnemyAttack"] boolValue];
    }
    
    return self;
}

@end
