#import "MZControl_Base.h"
#import "MZTypeDefine.h"
#import "MZMove_Base.h"
#import "MZAttack_Base.h"
#import "MZFaceToControlProtocol.h"

@protocol MZCharacterPartControlDelegate <MZControlDelegate, MZMoveDelegate, MZAttackDelegate>
@property (nonatomic, readwrite) bool visible;
@property (nonatomic, readwrite) float rotation;
@property (nonatomic, readwrite) CGPoint standardPosition;
@property (nonatomic, readwrite) CGPoint currentMovingVector;
@end

@class MZCharacterPart;
@class MZFaceToControl;
@class MZControlUpdate;

@interface MZCharacterPartControl : MZControl_Base <MZFaceToControlProtocol>
{
    id<MZCharacterPartControlDelegate> characterPartDelegate;

    MZControlUpdate *moveControlUpdate;
    MZControlUpdate *attackControlUpdate; // not yet
}

+(MZCharacterPartControl *)characterPartControl;

-(MZMove_Base *)addMoveWithName:(NSString *)name moveType:(MZMoveClassType)classType;
-(MZAttack_Base *)addAttackWithName:(NSString *)name attackType:(MZAttackClassType)classType;

@property (nonatomic, readwrite) bool disableAttack;
@property (nonatomic, readwrite, assign) id<MZCharacterPartControlDelegate> characterPartDelegate;

@end