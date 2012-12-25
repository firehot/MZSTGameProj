#import "MZBgFeatureControl_Objects.h"
#import "MZGameCoreHeader.h"
#import "MZGamePlayBackgroundLayer.h"
#import "MZGameCoreHeader.h"
#import "MZUtilitiesHeader.h"

@interface MZBgFeatureControl_Objects (Private)
-(MZGameObject *)__test__getRandomObject;
@end

#pragma mark

@implementation MZBgFeatureControl_Objects

#pragma mark - init and dealloc

-(void)dealloc
{
    [objectsArray release];
    [spritesPool release];
    [super dealloc];
}

@end

#pragma mark

@implementation MZBgFeatureControl_Objects (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
    
    NSDictionary *batchNodeSettingsDictionary =
    [NSDictionary dictionaryWithObjectsAndKeys:
     [MZCCSpritesPool __testBatchNodeSettingWithNumber: 100 textureName: @"[test]background_objects_atlas.png" usingBlend: false],
     [NSNumber numberWithInt: kMZCharacterType_Background],
     nil];
    
    NSArray *addOrder = [NSArray arrayWithObjects: [NSNumber numberWithInt: kMZCharacterType_Background], nil];
    
    NSDictionary *poolSettingDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                           batchNodeSettingsDictionary, @"BatchNodeSetting",
                                           addOrder, @"AddOrder",
                                           nil];
    
    spritesPool = [[MZCCSpritesPool alloc] initWithPoolSettingDictionary: poolSettingDictionary layer: parentLayerRef];

    objectsArray = [[NSMutableArray alloc] initWithCapacity: 1];

    for( int i = 0; i < 50 ; i++ )
        [objectsArray addObject: [self __test__getRandomObject]];
}

-(void)_update
{
    [super _update];

    for( MZGameObject *object in objectsArray )
    {
        object.position = mzp( object.position.x, object.position.y - parentLayerRef.deltaMovemnetEveryUpdate );
        [object update];
    }
}

@end

#pragma mark

@implementation MZBgFeatureControl_Objects (Private)

#pragma mark - methods

-(MZGameObject *)__test__getRandomObject
{
    NSArray *objectNamesArray = [NSArray arrayWithObjects: @"disc.png", @"mine.bmp", @"tree.png", @"tree_cartoon_med.png", nil];

    int index = arc4random() % [objectNamesArray count];

    MZGameObject *object = [MZGameObject gameObject];
    [object setSpriteFromPool: spritesPool characterType: kMZCharacterType_Background];
    float posX = (float)( 150 + ( arc4random() % 200 ) );
    float posY = (float)( [objectsArray count]*100 );
    object.position = CGPointMake( posX, posY );

    [object setFrameWithFrameName: [objectNamesArray objectAtIndex: index]];
    [object enable];

    return object;
}

@end