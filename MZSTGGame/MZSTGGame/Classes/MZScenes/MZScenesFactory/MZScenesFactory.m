#import "MZScenesFactory.h"
#import "MZScenesHeader.h"
#import "CCScene.h"

@implementation MZScenesFactory

MZScenesFactory *sharedScenesFactory_ = nil;

#pragma mark - init and dealloc

+(MZScenesFactory *)sharedInstance
{
    if( sharedScenesFactory_ == nil )
        sharedScenesFactory_ = [[MZScenesFactory alloc] init];
    
    return sharedScenesFactory_;
}

-(void)dealloc
{
    [sharedScenesFactory_ release];
    sharedScenesFactory_ = nil;
    
    [super dealloc];
}

#pragma mark - override

-(NSString *)description
{
    return @"This ScenesFactory is for MZSTGGame";
}

#pragma mark - methods

-(CCScene *)sceneWithType:(MZSceneType)sceneType
{
    CCScene *scene = nil;
    
    switch( sceneType )
    {
        case kMZSceneType_Title:
            scene = [MZTitleScene node];
            break;
            
        case kMZSceneType_Release:
            scene = [MZReleaseScene node];
            break;
            
        case kMZSceneType_Loading:
            scene = [MZLoadingScene node];
            break;
    
        case kMZSceneType_GamePlay:
            scene = [MZGamePlayScene node];
            break;

        default:
            break;
    }
    
    return scene;
}

@end
