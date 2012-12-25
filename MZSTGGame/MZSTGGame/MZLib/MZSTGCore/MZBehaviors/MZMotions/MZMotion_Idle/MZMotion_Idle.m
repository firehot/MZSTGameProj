#import "MZMotion_Idle.h"
#import "MZMotionSetting.h"
#import "MZLogMacro.h"

@implementation MZMotion_Idle

#pragma mark - override

// 必要性???
-(id)initWithControlTarget:(MZGameObject *)aControlTarget motionSetting:(MZMotionSetting *)aMotionSetting
{
    
    currentVelocity = ( aMotionSetting )? aMotionSetting.initVelocity : 0;

    // 忘記為何要考慮無 setting 的情況了, 等執行到此時再檢討
    if( aMotionSetting == nil )
    {
        MZLog( @"MotionSetting is nil, use default setting" );
    }
//    影響未知 ... 先不刪除
//    if( aMotionSetting == nil )
//    {
//        MZLog( @"MotionSetting is nil, use default setting" );
//        currentSpeed = 0;
//    }
//    else
//    {
//        setting = [aMotionSetting retain];
//        currentSpeed = setting.beginSpeed;
//    }

    self = [super initWithControlTarget: aControlTarget motionSetting: aMotionSetting];
    return self;
}

@end

@implementation MZMotion_Idle (Protected)

#pragma mark - override

-(void)_firstUpdate
{

}

-(void)_updateMotion
{

}

@end