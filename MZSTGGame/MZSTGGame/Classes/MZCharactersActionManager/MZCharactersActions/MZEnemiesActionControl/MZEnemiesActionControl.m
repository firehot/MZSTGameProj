#import "MZEnemiesActionControl.h"
#import "MZGameCharactersHeader.h"

@interface MZEnemiesActionControl (Private)
@end

@implementation MZEnemiesActionControl

#pragma mark - methods (override)

-(void)drawCollision
{            
    for( MZCharacter *enemy in self.activeEnemies )
        [enemy drawCollision];
}

-(void)update
{
    if( self.activeEnemies != nil )   
    {                
        for( MZEventControlCharacter *enemy in self.activeEnemies )
        {
            [enemy update];
            
            if( [enemy isCollisionWithOtherCharacter: self.player] )
                [enemy disable];
        }
    }
}

-(void)removeInactiveCharacters
{
    [self _removeInactiveCharactersFromActiveCharactersArray: self.activeEnemies];
}

@end

#pragma mark

@implementation MZEnemiesActionControl (Private)
@end
