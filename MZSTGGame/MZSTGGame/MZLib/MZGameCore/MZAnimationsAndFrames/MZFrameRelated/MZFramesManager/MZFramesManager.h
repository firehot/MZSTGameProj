#import <Foundation/Foundation.h>

@class MZFrame;
@class CCTexture2D;

@interface MZFramesManager : NSObject 
{
    NSMutableDictionary *framesByNameDictionary;
}

+(MZFramesManager *)sharedFramesManager;

-(void)addFrameWithFrameName:(NSString *)frameName;
-(void)addSpriteSheetWithFileName:(NSString *)spriteSheetFileName;
-(void)releaseAllFrames;

-(MZFrame *)frameByName:(NSString *)frameName;
-(CCTexture2D *)textureByName:(NSString *)textureName;

@end