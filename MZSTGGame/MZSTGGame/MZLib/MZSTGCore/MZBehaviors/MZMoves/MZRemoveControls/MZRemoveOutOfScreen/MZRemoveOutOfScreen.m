#import "MZRemoveOutOfScreen.h"
#import "MZCharacter.h"

@implementation MZRemoveOutOfScreen

-(bool)checkAndSetToRemove
{
    if( ![controlCharacterRef isInnerScreen] )
    {
        [controlCharacterRef disable];
        return true;
    }    
        
    return false;
}

@end
