#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"

@class MZPlayer;
@class MZCharactersActionParamters;

@interface MZCharactersActionControl : NSObject
{
    NSMutableArray *activeEnemiesRef;
    NSMutableArray *activePlayerBulletsRef;
    NSMutableArray *activeEnemyBulletsRef;
    MZCharactersActionParamters *charactersActionParamters;
    MZPlayer *playerRef;
}

-(id)initWithParamters:(MZCharactersActionParamters *)aParamters;
-(void)drawCollision;
-(void)update;
-(void)removeInactiveCharacters;

@end

@interface MZCharactersActionControl (Protected)
-(void)_removeInactiveCharactersFromActiveCharactersArray:(NSMutableArray *)activeCharactersArray;
@end
