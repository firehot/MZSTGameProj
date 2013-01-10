#import "MZAttack_MultiVortex.h"
#import "MZCharacter.h"
#import "MZObjectHelper.h"
#import "MZAttack_Vortex.h"
#import "MZLogMacro.h"

@interface MZAttack_MultiVortex (Private)
//-(MZAttackSetting *)_getAttackSettingWithTarget:(MZCharacter *)aTarget index:(int)index;
@end

@implementation MZAttack_MultiVortex

#pragma mark - override

-(void)dealloc
{
    [vortexes release];
    [super dealloc];
}

@end

#pragma mark

@implementation MZAttack_MultiVortex (Protected)

#pragma mark - override

-(void)_firstUpdate
{    
//    MZAssert( vortexes == nil, @"%@._setValuesOnFirstUpdate: vortex is not nil", self ); // 未修正
//    
//    vortexes = [[NSMutableArray alloc] initWithCapacity: 1];
//    
//    for( int i = 0; i < setting.numberOfWays; i++ )
//    {
//        MZAttackSetting *attackSetting = [self _getAttackSettingWithTarget: nil index: i]; // need fix
//        
//        MZAttack_Base*vortex = [[MZAttacksFactory sharedMZAttacksFactory] getAttackBySetting: attackSetting
//                                                                    controlCharacterPart: nil/*controlCharacterPart*/]; // need fix
//        [vortexes addObject: vortex];
//    }
}

-(void)_launchBullets
{
//    for( MZAttack_Base*vortex in vortexes )
//        [vortex _launchBulletsWithReferenceCharacter: nil deltaTime: deltaTime]; // need fix
}


@end

#pragma mark

@implementation MZAttack_MultiVortex (Private)

#pragma mark - methods

//-(MZAttackSetting *)_getAttackSettingWithTarget:(MZCharacter *)aTarget index:(int)index
//{
//    NSMutableDictionary *nsDictionary = [self _getCommonValuesNSDictionary];
//    [nsDictionary setObject: [NSNumber numberWithInt: setting.intervalDegree] forKey: @"IntervalDegree"];
//    [nsDictionary setObject: @"Vortex" forKey: @"Type"];    
//
//    // working ...  我也不知道要 work 什麼 ... XD (12/05)
//    MZAttackSetting *attackSetting = [MZAttackSetting settingWithNSDictionary: nsDictionary];
//    return attackSetting;
//
//    return nil; // temp
//}

@end