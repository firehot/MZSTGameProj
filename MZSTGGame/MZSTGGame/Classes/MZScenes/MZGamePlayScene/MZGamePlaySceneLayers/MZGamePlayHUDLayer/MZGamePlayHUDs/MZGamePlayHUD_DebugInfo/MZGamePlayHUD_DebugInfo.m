#import "MZLevelDebugInfoHud.h"
#import "MZLevelComponentsHeader.h"
#import "MZTime.h"
#import "CCLabelTTF.h"

@implementation MZLevelDebugInfoHud

#pragma mark - init

+(MZLevelDebugInfoHud *)levelHudWithLevelComponents:(MZLevelComponents *)aLevelComponents
{
    return [[[self alloc] initWithLevelComponents: aLevelComponents] autorelease];
}

#pragma mark - override

-(void)dealloc
{
    [self removeChild: labelGameTime cleanup: false];
    [labelGameTime release];
    [super dealloc];
}

-(void)update
{
    NSString *gameTimeString = [NSString stringWithFormat: @"Time: %0.2f", [MZTime sharedTime].totalTime];
    [labelGameTime setString: gameTimeString];
}

@end

@implementation MZLevelDebugInfoHud (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    
    labelGameTime = [CCLabelTTF labelWithString: @"Time: 0.0" fontName: @"Arial" fontSize: 20];
    [labelGameTime retain];
    labelGameTime.position = CGPointMake( 160, 20 );
    [self addChild: labelGameTime z: 10];
}

@end
