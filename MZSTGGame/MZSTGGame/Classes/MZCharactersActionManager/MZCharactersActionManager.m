#import "MZCharactersActionManager.h"
#import "MZSTGCharactersHeader.h"
#import "MZGameSettingsHeader.h"
#import "MZCharactersActionControlHeader.h"
#import "MZSTGGameHelper.h"
#import "MZLevelComponentsHeader.h"
#import "MZCharacterTypeStrings.h"
#import "MZLogMacro.h"
#import "MZGameConfig.h"

@interface MZCharactersActionManager (Private)
-(void)_initActiveCharactersArray;
-(void)_initCharactersActionControls;
-(void)_updateActiveCharacters;
-(void)_updateDebugInfo;
-(void)_removeInactiveCharacters;
-(NSMutableArray *)_getActiveCharactersArrayByCharacterType:(MZCharacterType)charType;
@end

@implementation MZCharactersActionManager

#pragma mark - init and dealloc

-(id)init
{
    self = [super init];

    [self _initActiveCharactersArray];
    [self _initCharactersActionControls];
    
    return self;
}

-(void)dealloc
{
    [playerActionControl release];
    [playerBulletsActionControl release];
    [enemiesActionControl release];
    [enemyBulletsActionControl release];

    for( MZCharacter *player in activePlayers )
        [player disable];
    [activePlayers release];
     
    for( MZBehavior_Base *playerBullet in activePlayerBullets )
        [playerBullet disable];
    [activePlayerBullets release];
       
    for( MZBehavior_Base *enemy in activeEnemies )
        [enemy disable];
    [activeEnemies release];
    
    for( MZBehavior_Base *enemyBullet in activeEnemyBullets )
        [enemyBullet disable];
    [activeEnemyBullets release];

    [super dealloc];
}

#pragma mark - methods

-(void)addWithType:(MZCharacterType)characterType character:(MZCharacter *)character
{
    NSMutableArray *targetActiveCharactersArray = [self _getActiveCharactersArrayByCharacterType: characterType];
    MZAssert( targetActiveCharactersArray != nil, 
             @"targetActiveCharactersArray is nil(type=%@)",
             [[MZCharacterTypeStrings sharedInstance] getCharacterTypeDescByType: characterType] );
    
    [targetActiveCharactersArray addObject: character];
    [character enable];
}

-(void)draw
{
    if( [MZGameSetting sharedInstance].debug.drawCollisionRange )
    {
        [playerActionControl drawCollision];
        [playerBulletsActionControl drawCollision];
        [enemiesActionControl drawCollision];
        [enemyBulletsActionControl drawCollision];
    }
}

-(void)update
{
    [self _updateActiveCharacters];
    [self _removeInactiveCharacters];
}

-(void)clearAllWithType:(MZCharacterType)type
{
    NSMutableArray *targetArray = [self _getActiveCharactersArrayByCharacterType: type];
    for( MZCharacter *character in targetArray )
        [character disable];
}

@end

#pragma mark

@implementation MZCharactersActionManager (Private)

#pragma mark - init

-(void)_initActiveCharactersArray
{
    activePlayers = [[NSMutableArray alloc] initWithCapacity: 1];
    activeEnemies = [[NSMutableArray alloc] initWithCapacity: 1];
    activeEnemyBullets = [[NSMutableArray alloc] initWithCapacity: 1];
    activePlayerBullets = [[NSMutableArray alloc] initWithCapacity: 1];
}

-(void)_initCharactersActionControls
{
    MZCharactersActionParamters *charactersActionParamters = [MZCharactersActionParamters charactersActionParamters];
    charactersActionParamters.activePlayers = activePlayers;
    charactersActionParamters.activePlayerBullets = activePlayerBullets;
    charactersActionParamters.activeEnemies = activeEnemies;
    charactersActionParamters.activeEnemyBullets = activeEnemyBullets;
    [charactersActionParamters checkCompleteness];
    
    playerActionControl = [[MZPlayerActionControl alloc] initWithParamters: charactersActionParamters];
    playerBulletsActionControl = [[MZPlayerBulletsActionControl alloc] initWithParamters: charactersActionParamters];
    enemiesActionControl = [[MZEnemiesActionControl alloc] initWithParamters: charactersActionParamters];
    enemyBulletsActionControl = [[MZEnemyBulletsActionControl alloc] initWithParamters: charactersActionParamters];
}

#pragma mark - methods

-(void)_updateActiveCharacters
{ 
    [playerActionControl update];
    [playerBulletsActionControl update];
    [enemiesActionControl update];
    [enemyBulletsActionControl update];
    
    [self _updateDebugInfo];
}

-(void)_updateDebugInfo
{
#if MZ_LOG_CHARACTER_NUMBERS
    int numberOfPlayer = 1;
    int numberOfEnemies = [activeEnemies count];
    int numberOfPlayerBullets = [activePlayerBullets count];
    int numberOfEnemyBullets = [activeEnemyBullets count];
    
    MZLog( @"%@: Info P:%d, E:%d, PB:%d, EB:%d",
          self,
          numberOfPlayer,
          numberOfEnemies,
          numberOfPlayerBullets,
          numberOfEnemyBullets );
#endif
}

-(void)_removeInactiveCharacters
{
    [playerBulletsActionControl removeInactiveCharacters];
    [enemiesActionControl removeInactiveCharacters];
    [enemyBulletsActionControl removeInactiveCharacters];
}

-(NSMutableArray *)_getActiveCharactersArrayByCharacterType:(MZCharacterType)charType
{
    switch( charType )
    {
        case kMZCharacterType_Player:
            if( activePlayers == nil )
                activePlayers = [[NSMutableArray alloc] initWithCapacity: 1];
            return activePlayers;
            
        case kMZCharacterType_PlayerBullet:
            if( activePlayerBullets == nil )
                activePlayerBullets = [[NSMutableArray alloc] initWithCapacity: 1];
            return activePlayerBullets;
            
        case kMZCharacterType_Enemy:
            if( activeEnemies == nil )
                activeEnemies = [[NSMutableArray alloc] initWithCapacity: 1];
            return activeEnemies;
            
        case kMZCharacterType_EnemyBullet:
            if( activeEnemyBullets == nil )
                activeEnemyBullets = [[NSMutableArray alloc] initWithCapacity: 1];
            return activeEnemyBullets;
            
        default:
            break;
    }
    
    MZAssert( false, 
             @"Can not found Array for Char Type(%@)",
             [[MZCharacterTypeStrings sharedInstance] getCharacterTypeDescByType: charType] );
    
    return nil;
}

@end

