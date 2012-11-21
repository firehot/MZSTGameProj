#import <Foundation/Foundation.h>

@class MZCharacter;

@interface MZRemoveControl : NSObject
{
    MZCharacter *controlCharacterRef;
}

+(MZRemoveControl *)removeControlWithControlCharacter:(MZCharacter *)aControlCharacter;
-(id)initWithControlCharacter:(MZCharacter *)aControlCharacter;

-(bool)checkAndSetToRemove;
@end
