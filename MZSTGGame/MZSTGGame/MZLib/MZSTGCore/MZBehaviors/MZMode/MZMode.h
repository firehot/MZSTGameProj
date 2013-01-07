#import "MZControl_Base.h"
#import "MZTypeDefine.h"
#import "MZMove_Base.h"
#import "MZCharacterPartControl.h"

@class MZCharacterPart;
@class MZControlUpdate;

@protocol MZModeDelegate <MZControlDelegate, MZMoveDelegate>
-(MZCharacterPart *)getChildWithName:(NSString *)childName; // 改個名 ><"
-(id<MZCharacterPartControlDelegate>)characterPartByName:(NSString *)partName;
@end

@interface MZMode : MZControl_Base
{
    id<MZModeDelegate> modeDelegate;

    MZControlUpdate *movesUpdate;
    NSMutableDictionary *characterPartControlUpdatesDictionary;

    NSMutableArray *currentCharacterPartControls;
}

+(MZMode *)mode;

-(MZMove_Base *)addMoveWithName:(NSString *)name moveType:(MZMoveClassType)classType;
-(MZMove_Base *)moveByName:(NSString *)name;

// add part control
-(void)addPartControlUpdateWithPart:(MZControlUpdate *)partControlUpdate name:(NSString *)name; // not very good

#pragma mark - settings
@property (nonatomic, readwrite, assign) id<MZModeDelegate> modeDelegate;
@property (nonatomic, readwrite) bool disableMove; 
@property (nonatomic, readwrite) bool disableAttack;

#pragma mark - states

@end