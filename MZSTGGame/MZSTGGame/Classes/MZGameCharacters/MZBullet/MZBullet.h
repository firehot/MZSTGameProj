#import "MZCharacter.h"
#import "MZMove_Base.h"

@class MZControlUpdate;

@interface MZBullet : MZCharacter <MZMoveDelegate>
{
    MZControlUpdate *moveControlUpdate;
}

+(MZBullet *)bullet;

-(MZMove_Base *)addMoveWithName:(NSString *)name moveType:(MZMoveClassType)classType;
-(MZMove_Base *)moveByName:(NSString *)name;

@property (nonatomic, readwrite) int strength;
@end
