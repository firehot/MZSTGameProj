#import "MZControlUpdate.h"
#import "MZUtilitiesHeader.h"
#import "MZControl_Base.h"

@interface MZControlUpdate (Private)
-(bool)_needSwitchControl;
-(void)_checkRunOceAndRemove:(MZControl_Base *)control;
-(id<MZControlProtocol>)_nextControl;
@end

#pragma mark

@implementation MZControlUpdate

@synthesize disableUpdate;
@synthesize currentControl = currentControlRef;
@synthesize controlsDictionaryArray = originControlsDictionaryArray;

#pragma mark - init and dealloc

+(MZControlUpdate *)controlUpdate
{ return [[[self alloc] init] autorelease]; }

-(void)dealloc
{
    [executingControlsArray release];
    [originControlsDictionaryArray release];

    [super dealloc];
}

#pragma mark - methods

-(int)add:(id<MZControlProtocol>)control key:(id<NSCopying>)key
{
    MZAssert( control != nil, @"control is nil" );

    if( originControlsDictionaryArray == nil )
    {
        originControlsDictionaryArray = [[MZDictionaryArray alloc] init];
        executingControlsArray = [[NSMutableArray alloc] initWithCapacity: 0];
    }

    [originControlsDictionaryArray addObject: control key: key];
    [executingControlsArray addObject: control];

    return [originControlsDictionaryArray count];
}

-(void)reset
{
    currentControlRef = nil;

    if( executingControlsArray != nil ) [executingControlsArray release];
    executingControlsArray = [[NSMutableArray alloc] initWithCapacity: 0];

    for ( id c in originControlsDictionaryArray.array )
        [executingControlsArray addObject: c];
}

-(void)update
{
    if( disableUpdate || executingControlsArray == nil ) return;

    if( [self _needSwitchControl] )
    {
        currentControlRef = [self _nextControl];
        [self _checkRunOceAndRemove: currentControlRef];

        if( currentControlRef != nil )
        {
            [currentControlRef reset];
            [currentControlRef enable];
        }
    }

    if( currentControlRef != nil )
        [currentControlRef update];
}

@end

#pragma mark

@implementation MZControlUpdate (Private)

-(bool)_needSwitchControl
{
    return ( currentControlRef == nil || [currentControlRef isActive] == false );
}

-(void)_checkRunOceAndRemove:(MZControl_Base *)control
{
    if( ![control isRunOnce] ) return;
    [executingControlsArray removeObject: control];
}

-(id<MZControlProtocol>)_nextControl
{
    if( [executingControlsArray count] == 0 )
        return nil;

    if( currentControlRef == nil   )
        return [executingControlsArray objectAtIndex: 0];

    int currentIndex = [executingControlsArray indexOfObject: currentControlRef];
    int nextIndex = ( currentIndex >= [executingControlsArray count] - 1 )? 0 : currentIndex + 1;

    return ( currentIndex != nextIndex )? [executingControlsArray objectAtIndex: nextIndex] : nil;
}

@end
