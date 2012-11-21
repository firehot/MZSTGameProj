#import "MZEnemiesActionControl.h"
#import "MZGameCharactersHeader.h"

@interface MZEnemiesActionControl (Private)
@end

@implementation MZEnemiesActionControl

#pragma mark - methods (override)

-(void)drawCollision
{            
    for( MZCharacter *enemy in activeEnemiesRef )
        [enemy drawCollision];
}

-(void)update
{
    if( activeEnemiesRef != nil )   
    {                
        for( MZEventControlCharacter *enemy in activeEnemiesRef )
        {
            [enemy update];
            
            if( [enemy isCollisionWithOtherCharacter: playerRef] )
                [enemy disable];
        }
    }
}

-(void)removeInactiveCharacters
{
    [self _removeInactiveCharactersFromActiveCharactersArray: activeEnemiesRef];
}

@end

#pragma mark

@implementation MZEnemiesActionControl (Private)
@end
