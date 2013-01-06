#import "MZCharactersActionControl.h"
#import "MZCharactersActionParamters.h"
#import "MZCharacter.h"
#import "MZLogMacro.h"

@interface MZCharactersActionControl (Private)
-(void)_setLeaderToNilWithRmoveCharacter:(MZCharacter *)removeCharacter activeCharactersArray:(NSMutableArray *)activeCharactersArray;
@end

#pragma mark

@implementation MZCharactersActionControl

@synthesize player;
@synthesize activeEnemies;
@synthesize activePlayerBullets;
@synthesize activeEnemyBullets;

#pragma mark - init and dealloc

-(id)initWithParamters:(MZCharactersActionParamters *)aParamters
{
    MZAssert( aParamters, @"aParamters is nil" );
    charactersActionParamters = [aParamters retain];
    
    self = [super init];
    return self;
}

-(void)dealloc
{
    [charactersActionParamters release];
    [super dealloc];
}

#pragma mark - properties

-(MZPlayer *)player { return charactersActionParamters.player; }
-(NSMutableArray *)activePlayerBullets { return charactersActionParamters.activePlayerBullets; }
-(NSMutableArray *)activeEnemies { return charactersActionParamters.activeEnemies; }
-(NSMutableArray *)activeEnemyBullets { return charactersActionParamters.activeEnemyBullets; }

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
//            if( character.isLeader )
//                [self _setLeaderToNilWithRmoveCharacter: character activeCharactersArray: activeCharactersArray];

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
//        if( character.leaderCharacterRef == removeCharacter )
//            character.leaderCharacterRef = nil;
    }
}

@end