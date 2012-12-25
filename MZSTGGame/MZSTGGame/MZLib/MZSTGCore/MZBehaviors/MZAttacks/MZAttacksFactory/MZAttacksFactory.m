#import "MZAttacksFactory.h"
#import "MZSTGCharactersHeader.h"
#import "MZAttacksHeader.h"
#import "MZUtilitiesHeader.h"
#import "MZLevelComponents.h"
#import "MZObjectHelper.h"

@implementation MZAttacksFactory

MZAttacksFactory *sharedInstance_ = nil;

#pragma mark - init and dealloc

+(MZAttacksFactory *)sharedInstance
{
    if( sharedInstance_ == nil )
        sharedInstance_ = [[MZAttacksFactory alloc] init];
    
    return sharedInstance_;
}

-(void)dealloc
{
    [sharedInstance_ release];
    sharedInstance_ = nil;
    
    [super dealloc];
}

#pragma mark - methods

-(void)removeFromLevel
{

}

-(MZAttack_Base*)getAttackBySetting:(MZAttackSetting *)setting controlTarget:(MZGameObject *)controlTarget
{
    NSString *className = [NSString stringWithFormat: @"MZAttack_%@", setting.attackTypeString];
    MZAttack_Base*attack = [NSClassFromString( className ) attackWithAttackSetting: setting controlTarget: controlTarget];
    
    MZAssert( attack, @"Create attack fail, class name=(%@)", className );
    
    return attack;
}

@end

@implementation MZAttacksFactory (Private)

-(NSString *)_getAttackClassNameWithSetting:(MZAttackSetting *)setting
{
//    if( setting.attackTypeString )

//        NSString *className = [NSString stringWithFormat: @"MZAttack_%@", setting.attackTypeString];
    return  @"";
}

@end