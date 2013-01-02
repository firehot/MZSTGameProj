#import "MZEvent_ComplementaryColor.h"
#import "MZLevelComponents.h"
#import "MZGamePlayLayer.h"
#import "MZPlayer.h"

@implementation MZEvent_ComplementaryColor

#pragma mark - override

-(void)dealloc
{
//    [complementaryColor release];
    [super dealloc];
}

-(void)enable
{
    [super enable];
    
    if( isUnderComplementaryColor )
    {
//        [complementaryColor disable];        
        isUnderComplementaryColor = false;
    }
    else
    {
//        complementaryColor.position = [MZLevelComponents sharedInstance].player.position;
//        [complementaryColor enable];
        isUnderComplementaryColor = true;
    }
    
    [self disable];
}

-(void)forceToEnd
{
//    [complementaryColor disable];
}

@end

#pragma mark

@implementation MZEvent_ComplementaryColor (Private)

#pragma mark - override

-(void)_initWithDictionary:(NSDictionary *)dictionary
{   
//    complementaryColor = [[MZEffect_ComplementaryColor alloc] initWithNSDictionary: dictionary
//                                                                  levelComponenets: [MZLevelComponents sharedInstance]];
}

-(void)_initValues
{
    isUnderComplementaryColor = false;
}

@end

