#import "MZAnimationsManager.h"
#import "MZUtilitiesHeader.h"
#import "MZAnimation.h"
#import "MZObjectHelper.h"
#import "MZGameSetting.h"
#import "MZGameSettingsHeader.h"
#import "cocos2d.h"

static MZAnimationsManager *_sharedAnimationsManager = nil;

@interface MZAnimationsManager (Private)
-(NSArray *)_getFrameNamesWithNamePattern:(NSString *)namePattern
                             extendedName:(NSString *)extendedName
                                    start:(int)start
                                      end:(int)end;
-(NSMutableArray *)_getAnimationFramesWithFrameNames:(NSArray *)frameNames;
@end

#pragma mark

@implementation MZAnimationsManager

#pragma mark - init and dealloc

+(MZAnimationsManager *)sharedInstance
{
    if( _sharedAnimationsManager == nil )
        _sharedAnimationsManager = [[MZAnimationsManager alloc] init];
    return _sharedAnimationsManager;
}

-(void)dealloc
{
    [MZObjectHelper releaseAndSetNilToObject: &animationControls];
    
    [_sharedAnimationsManager release];
    _sharedAnimationsManager = nil;
    [super dealloc];
}

#pragma mark - methods

-(void)releaseAllAnimations
{
    if( animationControls != nil ) { [animationControls release]; animationControls = nil; }
    [CCAnimationCache purgeSharedAnimationCache];
}

-(void)addAnimationsFromPlistFile:(NSString *)plistName
{
    NSDictionary *animationsSettingDictionary = [MZFileHelper plistContentFromBundleWithName: plistName];
    MZAssert( animationsSettingDictionary, @"Plist file is nil(file name = %@)", plistName );
    
    [self addAnimationsFromNSDictionary: animationsSettingDictionary];
}

-(void)addAnimationsFromNSDictionary:(NSDictionary *)animationsSettingDictionary
{
    NSDictionary *animationsSettingDcitionary = [animationsSettingDictionary objectForKey: @"Animations"];
    
    for( NSString *animationName in [animationsSettingDcitionary allKeys] )
    {   
        if( [MZGameSetting sharedInstance].debug.showLoadingStates )
            MZLog( @"Add animation(%@)", animationName );
        
        NSDictionary *animationSettingDictionary = [animationsSettingDcitionary objectForKey: animationName];
        MZAssert( animationSettingDictionary, @"animationSettingDictionary is nil with name (%@)", animationName );
        
        [self addAnimationWithNSDictionary: animationSettingDictionary name: animationName];
    }
}

-(void)addAnimationWithNSDictionary:(NSDictionary *)nsDictionary name:(NSString *)name
{
    if( [MZGameSetting sharedInstance].debug.showLoadingStates )
        MZLog( @"Add animation(%@)", [nsDictionary objectForKey: @"Name"] );
    
    int start = [[nsDictionary objectForKey: @"Start"] intValue];
    int end = [[nsDictionary objectForKey: @"End"] intValue];
    float intervalTime = [[nsDictionary objectForKey: @"IntervalTime"] floatValue];
    NSString *frameNamePattern = [nsDictionary objectForKey: @"FrameNamePattern"];
    NSString *extendedType = [nsDictionary objectForKey: @"ExtendedType"];
    
    NSArray *frameNamesArray = [self _getFrameNamesWithNamePattern: frameNamePattern
                                                      extendedName: extendedType 
                                                             start: start
                                                               end: end];
    
    [self addAnimationWithAnimationName: name frameNamesArray: frameNamesArray intervalTime: intervalTime];  
}

-(void)addAnimationWithAnimationName:(NSString *)animationName frameNamesArray:(NSArray *)frameNames intervalTime:(float)intervalTime
{    
    if( frameNames != nil )
    {
        NSMutableArray *animationFrames = [self _getAnimationFramesWithFrameNames: frameNames];
        MZAssert( [animationFrames count] != 0, @"Animation(%@) create fail", animationName );
        
        CCAnimation *animation = [CCAnimation animationWithSpriteFrames: animationFrames delay: intervalTime];
        [[CCAnimationCache sharedAnimationCache] addAnimation: animation name: animationName];
        
        if( animationControls == nil )
            animationControls = [[NSMutableDictionary alloc] init];
        
        MZAnimation *animationControl = [MZAnimation animationControlWithAnimationName: animationName animation: animation];
        [animationControls setObject: animationControl forKey: animationName];
    }
}

-(MZAnimation *)getAnimationControlWithAnimationName:(NSString *)animationName
{
    MZAssert( animationControls, @"animationControls is nil" );
    
    MZAnimation *animationControl = [animationControls objectForKey: animationName];
    MZAssert( animationControl, @"animationControl is nil (name=%@)", animationName );
    
    return animationControl;
}

@end

#pragma mark

@implementation MZAnimationsManager (Private)

#pragma mark - methods

-(NSArray *)_getFrameNamesWithNamePattern:(NSString *)namePattern 
                             extendedName:(NSString *)extendedName
                                    start:(int)start
                                      end:(int)end
{
    NSString *fullExtendedName = @"";
    if( extendedName != nil )
        if( [extendedName length] > 0 )
            fullExtendedName = [NSString stringWithFormat: @".%@", extendedName];
    
    NSMutableArray *frameNamesArray = [NSMutableArray arrayWithCapacity: 1];
    
    if( start <= end )
    {
        for( int i = start; i <= end; i++ )
        {
            NSString *frameName = [NSString stringWithFormat: @"%@%04d%@", namePattern, i, fullExtendedName];
            [frameNamesArray addObject: frameName];
        }
    }
    
    return frameNamesArray;
}

-(NSMutableArray *)_getAnimationFramesWithFrameNames:(NSArray *)frameNames
{
	NSMutableArray *animationFrames = [[NSMutableArray alloc] init];
	
	for( NSString *frameName in frameNames )
	{
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: frameName];
        MZAssert( frame, @"Frame(%@) not found", frameName );
                
        [animationFrames addObject: frame];
	}
	
	return [animationFrames autorelease];
}

@end
