#import <Foundation/Foundation.h>
#import "CCTexture2D.h"

@class MZGameSetting_System;
@class MZGameSetting_GamePlay;
@class MZGameSetting_Debug;

@interface MZGameSetting : NSObject 
{

}

+(MZGameSetting *)sharedInstance;

@property (nonatomic, readonly) MZGameSetting_System *system;
@property (nonatomic, readonly) MZGameSetting_GamePlay *gamePlay;
@property (nonatomic, readonly) MZGameSetting_Debug *debug;

@end
