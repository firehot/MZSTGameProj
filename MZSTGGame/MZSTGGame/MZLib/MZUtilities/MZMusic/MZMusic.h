#import <Foundation/Foundation.h>

@class CDAudioManager;

@interface MZMusic : NSObject 
{
    CDAudioManager *audioManagerRef;
}

+(MZMusic *)sharedMusic;
-(void)preLoadMusicWithName:(NSString *)fileName;
-(void)playMusicByName:(NSString *)name loop:(bool)loop;
-(void)stopAll;

@property (nonatomic, readwrite) bool showState;
@property (nonatomic, readwrite) float globalVolume;
@property (nonatomic, readwrite) float gain;

@end

@interface MZMusic (Private)

@end
