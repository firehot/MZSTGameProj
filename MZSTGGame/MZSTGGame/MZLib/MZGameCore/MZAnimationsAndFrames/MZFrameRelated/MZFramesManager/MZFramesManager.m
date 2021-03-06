#import "MZFramesManager.h"
#import "CCTextureCache.h"
#import "CCSpriteFrameCache.h"
#import "MZUtilitiesHeader.h"
#import "MZFrame.h"
#import "MZGameSetting.h"
#import "MZGameSettingsHeader.h"
#import "MZCCDisplayHelper.h"

@interface MZFramesManager (Private)
-(void)_addFrameWithFrameName:(NSString *)frameName;
@end

#pragma mark

@implementation MZFramesManager

//static MZFramesManager *sharedInstance_ = nil;

#pragma mark - init and dealloc

//+(MZFramesManager *)sharedInstance
//{
//    if( sharedInstance_ == nil )
//        sharedInstance_ = [[MZFramesManager alloc] init];
//    return sharedInstance_;
//}

-(void)dealloc
{
    [MZObjectHelper releaseAndSetNilToObject: &framesByNameDictionary];
        
//    [sharedInstance_ release];
//    sharedInstance_ = nil;
    
    [super dealloc];
}

#pragma mark - methods

-(void)addFrameWithFrameName:(NSString *)frameName
{
    MZLodingLog( 1, @"%@", frameName );
    MZAssert( [framesByNameDictionary objectForKey: frameName] == nil, @"Duplicate frmaeName name(%@)", frameName );
    
    CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: frameName];
    CGRect textureRect = CGRectMake( 0, 0, texture.contentSize.width, texture.contentSize.height );
    CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture: texture rect: textureRect];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFrame: frame name: frameName];
    
    [self _addFrameWithFrameName: frameName];
}

-(void)addSpriteSheetWithFileName:(NSString *)spriteSheetFileName
{
    MZLodingLog( 1, @"%@", spriteSheetFileName );

    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: spriteSheetFileName];
    
    NSDictionary *spriteSheetPlist = [MZFileHelper plistContentFromBundleWithName: spriteSheetFileName];
    
    NSString *textureName = [[spriteSheetPlist objectForKey: @"metadata"] objectForKey: @"textureFileName"];
    [[CCTextureCache sharedTextureCache] addImage: textureName];

    NSEnumerator *enumerator = [[spriteSheetPlist objectForKey: @"frames"] keyEnumerator];
    NSString *frameName = nil;
    while( (frameName = [enumerator nextObject]) )
        [self _addFrameWithFrameName: frameName];
}

-(void)releaseAllFrames
{
    if( framesByNameDictionary != nil ) { [framesByNameDictionary release]; framesByNameDictionary = nil; }
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeAllTextures];
}

-(MZFrame *)frameByName:(NSString *)frameName
{
    MZAssert( framesByNameDictionary, @"framesByNameDictionary is nil" );
    MZFrame *frame = [framesByNameDictionary objectForKey: frameName];
    MZAssert( frame, @"Can't found frame(%@)", frameName );
    
    return frame;
}

-(CCTexture2D *)textureByName:(NSString *)textureName
{
    CCTexture2D *texture = [[CCTextureCache sharedTextureCache] textureForKey: textureName];
    MZAssert( texture, @"texture(%@) not found", textureName );
    
    return texture;
}

@end

#pragma mark

@implementation MZFramesManager (Private)

#pragma mark - methods

-(void)_addFrameWithFrameName:(NSString *)frameName
{
    if( framesByNameDictionary == nil )
        framesByNameDictionary = [[NSMutableDictionary alloc] init];
    
    MZFrame *frame = [MZFrame frameControlWithFrameName: frameName];
    [framesByNameDictionary setObject: frame forKey: frameName];

    MZLodingLog( 2, @"%@", frameName );
}

@end

