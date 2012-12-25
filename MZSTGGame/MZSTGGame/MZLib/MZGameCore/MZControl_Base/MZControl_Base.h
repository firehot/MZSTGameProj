#import "MZBehavior_Base.h"
#import "MZTypeDefine.h"

@class MZGameObject;

@interface MZControl_Base : MZBehavior_Base
{
    MZGameObject *controlTargetRef;
    MZGameObject *referenceTargetRef;
}

+(MZControl_Base *)controlWithTarget:(MZGameObject *)aControlTarget;
-(id)initWithTarget:(MZGameObject *)aControlTarget;

@property (nonatomic, readwrite, assign) MZGameObject *referenceTargetRef;

@end
