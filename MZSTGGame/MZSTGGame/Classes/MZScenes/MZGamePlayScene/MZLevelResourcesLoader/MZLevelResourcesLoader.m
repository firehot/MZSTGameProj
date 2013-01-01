#import "MZLevelResourcesLoader.h"
#import "MZGameSettingsHeader.h"
#import "MZFramesManager.h"
#import "MZAnimationsManager.h"
#import "MZCharactersFactory.h"
#import "MZUtilitiesHeader.h"

#define DEFAULT_ANIMATION_DEFINE_FILE_NAME @"Animations.plist"
#define DEFAULT_BULLETS_DEFINE_FILE_NAME @"Bullets.plist"

@interface MZLevelResourcesLoader (Private)
-(void)_loadSystemResources;
-(void)_loadTexturesFromSpriteSheetNamesArray:(NSArray *)textureNamesArray;
-(void)_loadSpriteSheetsFromSpriteSheetNamesArray:(NSArray *)spriteSheetNamesArray;
-(void)_loadAnimationsSettingsFromAnimationsSettingFileNamesArray:(NSArray *)animationsSettingFileNamesArray;
-(void)_loadPlayerSettingsFromPlayerSettingNamesArray:(NSArray *)playerSettingNamesArray;
-(void)_loadEnemySettingsFromPlayerSettingNamesArray:(NSArray *)enemySettingNamesArray;
-(void)_loadBulletSettingsFromBulletSettingNamesArray:(NSArray *)bulletSettingNamesArray;
@end

@implementation MZLevelResourcesLoader

#pragma mark - init and deallc

+(MZLevelResourcesLoader *)levelResourcesLoaderWithLevelSettingNSDicitonary:(NSDictionary *)aLevelSettingNSDicitonary
{
    return [[[self alloc] initWithLevelSettingNSDicitonary: aLevelSettingNSDicitonary] autorelease];
}

-(id)initWithLevelSettingNSDicitonary:(NSDictionary *)aLevelSettingNSDicitonary
{
    if( ( self = [super init] ) )
    {
        [self _loadSystemResources];
        [self _loadTexturesFromSpriteSheetNamesArray: [aLevelSettingNSDicitonary objectForKey: @"textures"]];
        [self _loadSpriteSheetsFromSpriteSheetNamesArray: [aLevelSettingNSDicitonary objectForKey: @"spriteSheets"]];
//        [self _loadAnimationsSettingsFromAnimationsSettingFileNamesArray: [aLevelSettingNSDicitonary objectForKey: @"animations"]];
//        [self _loadPlayerSettingsFromPlayerSettingNamesArray: [aLevelSettingNSDicitonary objectForKey: @"players"]];
//        [self _loadEnemySettingsFromPlayerSettingNamesArray: [aLevelSettingNSDicitonary objectForKey: @"enemies"]];
//        [self _loadBulletSettingsFromBulletSettingNamesArray: [aLevelSettingNSDicitonary objectForKey: @"bullets"]];
    }
    
    return self;
}

-(void)dealloc
{
    [super dealloc];
}

@end

#pragma mark

@implementation MZLevelResourcesLoader (Private)

#pragma mark - methods

-(void)_loadSystemResources
{
    NSArray *systemFrameNamesArray = [NSArray arrayWithObjects: 
                                      @"TestPic.png", 
                                      @"ColorRect4x4_White.png",
                                      @"nebula.png",
                                      nil];
    
    for( NSString *systemFrameName in systemFrameNamesArray )
        [[MZFramesManager sharedInstance] addFrameWithFrameName: systemFrameName];
}

-(void)_loadTexturesFromSpriteSheetNamesArray:(NSArray *)textureNamesArray
{
    if( textureNamesArray == nil ) return;
    
    if( [MZGameSetting sharedInstance].debug.showLoadingStates )
        MZLog( @"" );
    
    for( NSString *textureName in textureNamesArray )
        [[MZFramesManager sharedInstance] addFrameWithFrameName: textureName];
}

-(void)_loadSpriteSheetsFromSpriteSheetNamesArray:(NSArray *)spriteSheetNamesArray
{
    MZAssert( spriteSheetNamesArray != nil, @"spriteSheetNamesArray is nil" );
    
    if( [MZGameSetting sharedInstance].debug.showLoadingStates )
        MZLog( @"" );
    
    for( NSString *spriteSheetName in spriteSheetNamesArray )
        [[MZFramesManager sharedInstance] addSpriteSheetWithFileName: spriteSheetName];
}

-(void)_loadAnimationsSettingsFromAnimationsSettingFileNamesArray:(NSArray *)animationsSettingFileNamesArray
{
    if( [MZGameSetting sharedInstance].debug.showLoadingStates )
        MZLog( @"Load default animation from %@", DEFAULT_ANIMATION_DEFINE_FILE_NAME );
    
    [[MZAnimationsManager sharedInstance] addAnimationsFromPlistFile: DEFAULT_ANIMATION_DEFINE_FILE_NAME];
    
    for( NSString *animationsSettingFileName in animationsSettingFileNamesArray )
    {
        if( [MZGameSetting sharedInstance].debug.showLoadingStates )
            MZLog( @"Load animation from %@", animationsSettingFileName );
        
        [[MZAnimationsManager sharedInstance] addAnimationsFromPlistFile: animationsSettingFileName];
    }
}

-(void)_loadPlayerSettingsFromPlayerSettingNamesArray:(NSArray *)playerSettingNamesArray
{
    MZAssert( playerSettingNamesArray != nil, @"playerSettingNamesArray is nil" );
    
    if( [MZGameSetting sharedInstance].debug.showLoadingStates )
        MZLog( @"" );
    
    MZCharactersFactory *charactersFactory = [MZCharactersFactory sharedInstace];
    
    for( NSString *settingName in playerSettingNamesArray )
        [charactersFactory addSettingWithCharacterType: kMZCharacterType_Player fromPlistFile: settingName];
}

-(void)_loadEnemySettingsFromPlayerSettingNamesArray:(NSArray *)enemySettingNamesArray
{
    MZAssert( enemySettingNamesArray != nil, @"enemySettingNamesArray is nil" );
        
    MZCharactersFactory *charactersFactory = [MZCharactersFactory sharedInstace];
    
    for( NSString *settingName in enemySettingNamesArray )
    {
        if( [MZGameSetting sharedInstance].debug.showLoadingStates )
            MZLog( @"" );

        [charactersFactory addSettingWithCharacterType: kMZCharacterType_Enemy fromPlistFile: settingName];
    }
}

-(void)_loadBulletSettingsFromBulletSettingNamesArray:(NSArray *)bulletSettingNamesArray
{
    NSDictionary *defaultBulletsDefinesDictionary = [MZFileHelper plistContentFromBundleWithName: DEFAULT_BULLETS_DEFINE_FILE_NAME];
    MZAssert( defaultBulletsDefinesDictionary, @"Can not load default bullets define file(%@)", DEFAULT_BULLETS_DEFINE_FILE_NAME );

    MZCharactersFactory *charactersFactory = [MZCharactersFactory sharedInstace];
    
    if( [MZGameSetting sharedInstance].debug.showLoadingStates )
        MZLog( @"Load bullets define from default file(%@)", DEFAULT_BULLETS_DEFINE_FILE_NAME );
    
    for( NSString *bulletName in [defaultBulletsDefinesDictionary allKeys] )
    {
        if( [MZGameSetting sharedInstance].debug.showLoadingStates )
            MZLog( @"Load bullet: (%@)", bulletName );
        
        NSDictionary *bulletDictionary = [defaultBulletsDefinesDictionary objectForKey: bulletName];
        [charactersFactory addSettingWithCharacterType: kMZCharacterType_EnemyBullet settingDictionary: bulletDictionary];
    }
    
    if( bulletSettingNamesArray == nil )
        return;
            
    for( NSString *settingName in bulletSettingNamesArray )
    {
        if( [MZGameSetting sharedInstance].debug.showLoadingStates )
            MZLog( @"Load bullet from plist: %@", settingName );
        
        [charactersFactory addSettingWithCharacterType: kMZCharacterType_EnemyBullet fromPlistFile: settingName]; 
    }
}

@end