#import "MZCharactersActionManager.h"
#import "MZSTGCharactersHeader.h"
#import "MZGameSettingsHeader.h"
#import "MZCharactersActionControlHeader.h"
#import "MZSTGGameHelper.h"
#import "MZLevelComponentsHeader.h"
#import "MZLogMacro.h"

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

-(id)initWithLevelComponents:(MZLevelComponents *)aLevelComponents
{
    MZAssert( aLevelComponents, @"aLevelComponents is nil" );
    self = [super init];
    
    levelComponentsRef = aLevelComponents;
    [self _initActiveCharactersArray];
    [self _initCharactersActionControls];
    
    return self;
}

-(void)dealloc
{
    levelComponentsRef = nil;
    
    [playerActionControl release];
    [playerBulletsActionControl release];
    [enemiesActionControl release];
    [enemyBulletsActionControl release];
     
    // 檢討區[到底還需不需要 release 呢?]
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

-(void)addCharacterWithType:(MZCharacterType)characterType character:(MZCharacter *)character
{
    NSMutableArray *targetActiveCharactersArray = [self _getActiveCharactersArrayByCharacterType: characterType];
    MZAssert( targetActiveCharactersArray != nil, 
             @"targetActiveCharactersArray is nil(type=%@)",
             [[MZCharacterTypeStrings sharedCharacterTypeStrings] getCharacterTypeDescByType: characterType] );
    
    [targetActiveCharactersArray addObject: character];
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

#pragma mark - init (private)

-(void)_initActiveCharactersArray
{
    activeEnemies = [[NSMutableArray alloc] initWithCapacity: 1];
    activeEnemyBullets = [[NSMutableArray alloc] initWithCapacity: 1];
    activePlayerBullets = [[NSMutableArray alloc] initWithCapacity: 1];
}

-(void)_initCharactersActionControls
{
    MZCharactersActionParamters *charactersActionParamters = [MZCharactersActionParamters charactersActionParamters];
    charactersActionParamters.playerRef = levelComponentsRef.player;
    charactersActionParamters.activePlayerBulletsRef = activePlayerBullets;
    charactersActionParamters.activeEnemiesRef = activeEnemies;
    charactersActionParamters.activeEnemyBulletsRef = activeEnemyBullets;
    [charactersActionParamters checkCompleteness];
    
    playerActionControl = [[MZPlayerActionControl alloc] initWithParamters: charactersActionParamters];
    playerBulletsActionControl = [[MZPlayerBulletsActionControl alloc] initWithParamters: charactersActionParamters];
    enemiesActionControl = [[MZEnemiesActionControl alloc] initWithParamters: charactersActionParamters];
    enemyBulletsActionControl = [[MZEnemyBulletsActionControl alloc] initWithParamters: charactersActionParamters];
}

#pragma mark - methods (private)

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
    if( [MZGameSetting sharedInstance].debug.showCharactersNumber )
    {
        int numberOfPlayer = 1;
        int numberOfEnemies = [activeEnemies count];
        int numberOfPlayerBullets = [activePlayerBullets count];
        int numberOfEnemyBullets = [activeEnemyBullets count];
        
        NSLog( @"%@: Info P:%d, E:%d, PB:%d, EB:%d", 
               self, 
               numberOfPlayer,
               numberOfEnemies,
               numberOfPlayerBullets,
               numberOfEnemyBullets );
    }
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
             [[MZCharacterTypeStrings sharedCharacterTypeStrings] getCharacterTypeDescByType: charType] );
    
    return nil;
}

@end

