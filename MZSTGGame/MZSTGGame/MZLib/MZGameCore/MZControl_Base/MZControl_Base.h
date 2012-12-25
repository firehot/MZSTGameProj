#import "MZBehavior_Base.h"
#import "MZTypeDefine.h"

@protocol MZControlDelegate <NSObject>
@end

@class MZGameObject;

@interface MZControl_Base : MZBehavior_Base
{
@protected
    id controlDelegate;
}

+(MZControl_Base *)controlWithDelegate:(id<MZControlDelegate>)aControlDelegate;
-(id)initWithDelegate:(id<MZControlDelegate>)aControlDelegate;

@end
