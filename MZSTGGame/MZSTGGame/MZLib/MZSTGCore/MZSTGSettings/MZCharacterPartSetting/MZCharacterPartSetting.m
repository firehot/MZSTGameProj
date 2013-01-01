#import "MZCharacterPartSetting.h"
#import "MZCollision.h"
#import "MZCCColorHelper.h"
#import "MZGLHelper.h"

@implementation MZCharacterPartSetting

@synthesize blendFuncSrc;
@synthesize blendFuncDest;
@synthesize scale;
@synthesize relativePosition;
@synthesize color;
@synthesize name;
@synthesize frameName;
@synthesize animationName;
@synthesize collisions;

#pragma mark - init and dealloc

+(MZCharacterPartSetting *)setting
{
    return [[[self alloc] init] autorelease];
}

+(MZCharacterPartSetting *)settingWithDictionary:(NSDictionary *)aDictionary name:(NSString *)aName
{
    return [[[self alloc] initWithDictionary: aDictionary name: aName] autorelease];
}

-(id)init
{
    self = [super init];
    blendFuncSrc = [MZGLHelper defaultBlendFuncSrc];
    blendFuncDest = [MZGLHelper defaultBlendFuncDest];
    scale = 1;
    color = ccc3( 255, 255, 255 );
    return self;
}

-(id)initWithDictionary:(NSDictionary *)aDictionary name:(NSString *)aName
{
    self = [super init];
    
    name = [aName retain];
    
    scale = ( [aDictionary objectForKey: @"scale"] )? [[aDictionary objectForKey: @"scale"] floatValue] : 1;
    relativePosition =
    ( [aDictionary objectForKey: @"relativePosition"] )? CGPointFromString( [aDictionary objectForKey: @"relativePosition"] ) : CGPointZero;
    color = [MZCCColorHelper color3BFromString: [aDictionary objectForKey: @"color"]];

    frameName = ( [aDictionary objectForKey: @"frameName"] != nil )? [[aDictionary objectForKey: @"frameName"] retain] :  nil;
    animationName = [[aDictionary objectForKey: @"animationName"] retain];
    
    blendFuncSrc = ( [aDictionary objectForKey: @"blendFuncSrc"] )?
    [MZGLHelper glBlendEnumFromString: [aDictionary objectForKey: @"blendFuncSrc"]] : [MZGLHelper defaultBlendFuncSrc];
    blendFuncDest = ( [aDictionary objectForKey: @"blendFuncDest"] )?
    [MZGLHelper glBlendEnumFromString: [aDictionary objectForKey: @"blendFuncDest"]] : [MZGLHelper defaultBlendFuncDest];
    
    [self _setCollisionCircleWithNSArray: [aDictionary objectForKey: @"collisions"]];
    
    return self;
}

-(void)dealloc
{
    [name release];
    [frameName release];
    [animationName release];
    [collisions release];
    
    [super dealloc];
}

@end

#pragma mark

@implementation MZCharacterPartSetting (Private)

#pragma mark - methods

-(void)_setCollisionCircleWithNSArray:(NSArray *)nsArray
{
    if( collisions == nil )
        collisions = [[NSMutableArray alloc] initWithCapacity: 1];
    
    for( NSDictionary *nsDictionary in nsArray )
    {
        CGPoint center = CGPointFromString( [nsDictionary objectForKey: @"center"] );
        float radius = [[nsDictionary objectForKey: @"radius"] floatValue];
    
        MZCircle *circle = [MZCircle circleWithCenter: center radius: radius];
        
        [collisions addObject: circle];
    }
}

@end