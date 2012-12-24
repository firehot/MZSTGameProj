@class MZFrame;
@class CCTexture2D;

@interface MZFramesManager : NSObject
{
    NSMutableDictionary *framesByNameDictionary;
}

+(MZFramesManager *)sharedInstance;

-(void)addFrameWithFrameName:(NSString *)frameName;
-(void)addSpriteSheetWithFileName:(NSString *)spriteSheetFileName;
-(void)releaseAllFrames;

-(MZFrame *)frameByName:(NSString *)frameName;
-(CCTexture2D *)textureByName:(NSString *)textureName;

@end