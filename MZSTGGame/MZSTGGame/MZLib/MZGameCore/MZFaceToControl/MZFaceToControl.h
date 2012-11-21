#import <Foundation/Foundation.h>
#import "MZFaceToControlProtocol.h"
#import "MZTypeDefine.h"

@class MZGameObject;
@class MZLevelComponents;

@interface MZFaceToControl : NSObject
{
    CGPoint previousPosition;
    CGPoint previousDirection;
    MZFaceToType faceToType;
    
    NSObject<MZFaceToControlProtocol> *controlTargetRef;
    MZLevelComponents *levelComponentsRef;
}

+(MZFaceToControl *)controlWithControlTarget:(NSObject<MZFaceToControlProtocol> *)aControlTarget
                             levelComponents:(MZLevelComponents *)aLevelComponents
                                      faceTo:(MZFaceToType)aFaceTo
                           previousDirection:(CGPoint)aPreviousDirection;
-(id)initWithControlTarget:(NSObject<MZFaceToControlProtocol> *)aControlTarget
           levelComponents:(MZLevelComponents *)aLevelComponents
                    faceTo:(MZFaceToType)aFaceTo
         previousDirection:(CGPoint)aPreviousDirection;
-(void)update;

@property (nonatomic, readonly) bool hasVaildValue;
@property (nonatomic, readonly) CGPoint lastDirection;

@end