#import "MZEvent_CreateEnemyToAbsolutePosition.h"
#import "MZEvent_CreateEnemy.h"
#import "MZEnemy.h"
#import "MZMotionSetting.h"
#import "MZSTGGameHelper.h"
#import "MZCharacterDynamicSetting.h"
#import "MZObjectHelper.h"
#import "MZLogMacro.h"

@interface MZEvent_CreateEnemyToAbsolutePosition (Private)
-(void)_checkMotionSettingCheckWithEnemy:(MZEnemy *)enemy;
@end

@implementation MZEvent_CreateEnemyToAbsolutePosition

#pragma mark - override

-(void)dealloc
{
    [createEnemy release];
    [super dealloc];
}

-(void)enable
{
    [createEnemy enable];
    MZEnemy *enemy = (MZEnemy *)[createEnemy getResultObject];
    [self _checkMotionSettingCheckWithEnemy: enemy];
    
    [self disable];
}

@end

#pragma mark

@implementation MZEvent_CreateEnemyToAbsolutePosition (Protected)

#pragma mark - override

-(void)_initWithDictionary:(NSDictionary *)dictionary
{
    MZAssert( [dictionary objectForKey: @"AbsolutePosition"], @"AbsolutePosition is nil" );
    
    absolutePosition = CGPointFromString( [dictionary objectForKey: @"AbsolutePosition"] );
    createEnemy = [[MZEvent_CreateEnemy alloc] initWithDictionary: dictionary];
}

@end

#pragma mark

@implementation MZEvent_CreateEnemyToAbsolutePosition (Private)

#pragma mark - methods

-(void)_checkMotionSettingCheckWithEnemy:(MZEnemy *)enemy
{
    MZAssert( [((MZMotionSetting *)[enemy getMotionSettingWithIndex: 0]).motionType isEqualToString: @"LinearToTarget"], 
              @"motionType must be LinearToTarget(your value is %@)", 
              ((MZMotionSetting *)[enemy getMotionSettingWithIndex: 0]).motionType );
    
    MZAssert( ((MZMotionSetting *)[enemy getMotionSettingWithIndex: 0]).targetType == kMZTargetType_AbsolutePosition,
             @"targetType must be AbsolutePosition" );
    
    enemy.characterDynamicSetting.absolutePosition = absolutePosition;
    [enemy applyDynamicSetting];
}

@end
