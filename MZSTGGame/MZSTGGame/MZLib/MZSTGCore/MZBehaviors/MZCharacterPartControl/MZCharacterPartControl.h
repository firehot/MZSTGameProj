#import "MZControl_Base.h"
#import "MZTypeDefine.h"
#import "MZMove_Base.h"
#import "MZFaceToControlProtocol.h"

@protocol MZCharacterPartControlDelegate <MZControlDelegate, MZMoveDelegate> /* 還有一個 attack */
@property (nonatomic, readwrite) bool visible; // ???
@property (nonatomic, readwrite) float rotation; // ??? ... faceTo use it????
@property (nonatomic, readwrite) CGPoint standardPosition;
@property (nonatomic, readwrite) CGPoint currentMovingVector;
@end

@class MZCharacterPart;
@class MZAttack_Base;
@class MZMove_Base;
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

@property (nonatomic, readwrite) bool disableAttack;
@property (nonatomic, readwrite, assign) id<MZCharacterPartControlDelegate> characterPartDelegate;

@end