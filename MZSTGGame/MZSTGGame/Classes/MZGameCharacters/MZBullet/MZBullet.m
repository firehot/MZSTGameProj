#import "MZBullet.h"
#import "MZUtilitiesHeader.h"

@implementation MZBullet
@synthesize strength;

#pragma mark - init and dealloc

+(MZBullet *)bullet
{ return [[[self alloc] init] autorelease]; }

-(void)dealloc
{
    [moveControlUpdate release];
    [super dealloc];
}

#pragma mark - methods

-(MZMove_Base *)addMoveWithName:(NSString *)name moveType:(MZMoveClassType)classType
{
    if( moveControlUpdate == nil ) moveControlUpdate = [[MZControlUpdate alloc] initWithBaseClass: [MZMove_Base class]];

    MZMove_Base *move = [MZMove_Base createWithClassType: classType];
    move.moveDelegate = self;

    [moveControlUpdate add: move key: name];

    return move;
}

-(MZMove_Base *)moveByName:(NSString *)name
{
    return ( moveControlUpdate != nil )? [moveControlUpdate.controlsDictionaryArray objectForKey: name] : nil;
}

@end

@implementation MZBullet (Protected)

#pragma mark - override

-(void)_update
{
    if( moveControlUpdate != nil ) [moveControlUpdate update];
}

@end