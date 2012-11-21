#import <Foundation/Foundation.h>

@class CDSoundEngine;

@interface MZSound : NSObject 
{
    NSDictionary *soundNamesIndexDictionary;
    NSMutableDictionary *soundRunTimeIdForNameDictionary;
    CDSoundEngine *soundEngineRef;
}

+(MZSound *)sharedSound;
-(void)setSoundsByPlist:(NSString *)plistFileName;
-(void)setSoundsByNSDictionary:(NSDictionary *)nsDictionary;
-(void)playSoundByName:(NSString *)soundName loop:(bool)loop;
-(void)playSoundByName:(NSString *)soundName gain:(float)gain loop:(bool)loop;
-(void)stopSoundByName:(NSString *)soundName;
-(void)stopAll;

@property (nonatomic, readwrite) bool showState;
@property (nonatomic, readwrite) float globalVolume;

@property (nonatomic, readwrite) float preSleepTime;
@property (nonatomic, readwrite) float afterSleepTime;

@end