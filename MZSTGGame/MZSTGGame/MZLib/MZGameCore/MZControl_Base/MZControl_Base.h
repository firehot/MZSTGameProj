#import "MZBehavior_Base.h"
#import "MZControlUpdate.h"
#import "MZTypeDefine.h"

@protocol MZControlDelegate <NSObject>
@end

@class MZGameObject;

@interface MZControl_Base : MZBehavior_Base <MZControlProtocol>
{
@protected
    id controlDelegate; // not complete
}

+(MZControl_Base *)controlWithDelegate:(id<MZControlDelegate>)aControlDelegate; // replace to simple init
-(id)initWithDelegate:(id<MZControlDelegate>)aControlDelegate;

@property (nonatomic, readwrite) bool isRunOnce;

@end
