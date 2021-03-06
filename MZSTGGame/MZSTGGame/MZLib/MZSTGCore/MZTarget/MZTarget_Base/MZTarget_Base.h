#import <Foundation/Foundation.h>
#import "MZTypeDefine.h"
#import "MZTypeBaseClassFunctionsHeader.h"

@protocol MZTargetDelegate <NSObject>
@required
@property (nonatomic, readonly) CGPoint position;
@property (nonatomic, readonly) MZCharacterType characterType;
@end

typedef enum
{
    kMZTarget_Target,

}MZTargetClassType;

@interface MZTarget_Base : NSObject
{
    bool needCalcute;
    CGPoint movingVectorResult;
}

MZTypeBaseClassFunctionsHeader( MZTarget_Base, target, MZTargetClassType )

-(void)reset;

-(void)beginOneTime;
-(void)endOneTime;

#pragma mark - settings
@property (nonatomic, readwrite, assign) id<MZTargetDelegate> targetDelegate;
@property (nonatomic, readwrite) bool calcuteEveryTime;
@property (nonatomic, readonly) CGPoint currentMovingVector;

@end

@interface MZTarget_Base (Protected)
-(CGPoint)_calculateMovingVector;
-(CGPoint)_playerPosition; // temp, need delete
@end