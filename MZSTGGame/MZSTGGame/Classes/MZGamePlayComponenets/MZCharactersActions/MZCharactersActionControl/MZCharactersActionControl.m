#import "MZCharactersActionControl.h"
#import "MZCharactersActionParamters.h"
#import "MZCharacter.h"
#import "MZLogMacro.h"

@interface MZCharactersActionControl (Private)
-(void)_setLeaderToNilWithRmoveCharacter:(MZCharacter *)removeCharacter activeCharactersArray:(NSMutableArray *)activeCharactersArray;
@end

#pragma mark

@implementation MZCharactersActionControl

#pragma mark - init and dealloc

-(id)initWithParamters:(MZCharactersActionParamters *)aParamters
{
    self = [super init];
    
    if( self )
    {
        MZAssert( aParamters, @"aParamters is nil" );
        charactersActionParamters = [aParamters retain];
        
        activeEnemiesRef = charactersActionParamters.activeEnemiesRef;
        activePlayerBulletsRef = charactersActionParamters.activePlayerBulletsRef;
        activeEnemyBulletsRef = charactersActionParamters.activeEnemyBulletsRef;
        playerRef = charactersActionParamters.playerRef;
    }
    
    return self;
}

-(void)dealloc
{
    [charactersActionParamters release];
    
    activeEnemiesRef = nil;
    activePlayerBulletsRef = nil;
    activeEnemyBulletsRef = nil;
    playerRef = nil;

    [super dealloc];
}

#pragma mark - methods

-(void)drawCollision
{
    MZAssert( false, @"override me" );
}

-(void)update
{
    MZAssert( false, @"override me" );
}

-(void)removeInactiveCharacters
{
    MZAssert( false, @"override me" );
}

@end

#pragma mark

@implementation MZCharactersActionControl (Protected)

#pragma mark - methods

-(void)_removeInactiveCharactersFromActiveCharactersArray:(NSMutableArray *)activeCharactersArray
{
    for( int i = 0; i < [activeCharactersArray count]; i++ )
    {
        MZCharacter *character = [activeCharactersArray objectAtIndex: i];
        if( character.isActive == false )
        {
            if( character.isLeader )
                [self _setLeaderToNilWithRmoveCharacter: character activeCharactersArray: activeCharactersArray];
            
            [character releaseSprite];
            [character disable];
            [activeCharactersArray removeObject: character];
            i--;
        }
    }
}

@end

#pragma mark

@implementation MZCharactersActionControl (Private)

#pragma mark - methods

-(void)_setLeaderToNilWithRmoveCharacter:(MZCharacter *)removeCharacter activeCharactersArray:(NSMutableArray *)activeCharactersArray
{
    for( MZCharacter *character in activeCharactersArray )
    {
        if( character.leaderCharacterRef == removeCharacter )
            character.leaderCharacterRef = nil;
    } 
}

@end