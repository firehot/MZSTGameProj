#import "MZEventsHeader.h"
#import "MZGameCharactersHeader.h"
#import "MZCharactersActionManager.h"
#import "MZCharacterTypeStrings.h"
#import "MZGameSettingsHeader.h"
#import "MZLevelComponents.h"
#import "MZObjectHelper.h"
#import "MZLogMacro.h"

@implementation MZEvent_CreateEnemy

#pragma mark - override

-(void)dealloc
{
    enemyRef = nil;
    [enemyName release];    
    [super dealloc];
}

-(void)enable
{
    [super enable];
    
    MZEnemy *enemy /*= (MZEnemy *)[[MZCharactersFactory sharedInstace] getCharacterByType: kMZCharacterType_Enemy
                                                                            settingName: enemyName]*/;
    MZAssert( enemy != nil, @"Can't create enemy(%@)", enemyName );
    enemy.position = position;
    
    [[MZLevelComponents sharedInstance].charactersActionManager addCharacterWithType: kMZCharacterType_Enemy character: enemy];
    
    if( [MZGameSetting sharedInstance].debug.showEventInfo )
        MZLog( @"CreateEnemy(%@) at %@", enemyName, NSStringFromCGPoint( position ) );
    
    [enemy enable];
    enemyRef = enemy;
     
    [self disable];
}

-(NSObject *)getResultObject
{
    return enemyRef;
}

@end

#pragma mark

@implementation MZEvent_CreateEnemy (Protected)

#pragma mark - override

-(void)_initWithDictionary:(NSDictionary *)dictionary
{    
    position = CGPointFromString( [dictionary objectForKey: @"position"] );
    enemyName = [[dictionary objectForKey: @"enemyName"] retain];
}

@end
