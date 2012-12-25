#import "MZBgFeatureControl_RepeatTexture.h"
#import "MZGameCoreHeader.h"
#import "MZUtilitiesHeader.h"
#import "MZGamePlayBackgroundLayer.h"
#import "cocos2d.h"

@implementation MZBgFeatureControl_RepeatTexture

#pragma mark - init and dealloc 

-(void)dealloc
{
    [repeatTexture release];
    [super dealloc];
}

@end

#pragma mark

@implementation MZBgFeatureControl_RepeatTexture (Protected)

#pragma mark - override

-(void)_initValues
{
    [super _initValues];
       
    MZAssert( [settingDictionary objectForKey: @"textureName"] != nil, @"where is TextureName???" );
    
    velocityXY = ( [settingDictionary objectForKey: @"velocityXY"] )?
    CGPointFromString( [settingDictionary objectForKey: @"velocityXY"] ) :
    CGPointZero;
    
    CCSprite *repeatSprite = [CCSprite node];
    [parentLayerRef addChild: repeatSprite];

    repeatTexture = [[MZGameObject alloc] init];
    [repeatTexture setSprite: repeatSprite parentLayer: parentLayerRef];
    
    [repeatTexture setPropertiesWithDictionary: settingDictionary];
    [repeatTexture setTexParameters: &(ccTexParams){ GL_LINEAR, GL_LINEAR, GL_REPEAT, GL_REPEAT }];

    // test color tint
    if( [[settingDictionary objectForKey: @"textureName"] isEqualToString: @"[test]bg_cloud.png"] )
    {
        CCTintTo *t1 = [CCTintTo actionWithDuration: 3 red: 128 green: 0 blue: 0];
        CCTintTo *t2 = [CCTintTo actionWithDuration: 3 red: 0 green: 128 blue: 0];
        CCTintTo *t3 = [CCTintTo actionWithDuration: 3 red: 0 green: 0 blue: 128];

        CCSequence *s = [CCSequence actions: t1, t2, t3, nil];
        CCRepeatForever *r = [CCRepeatForever actionWithAction: s];
        [repeatTexture runAction: r];
    }
}

-(void)_update
{
    [super _update];
    
    float x = velocityXY.x*self.lifeTimeCount;
    float y = velocityXY.y*self.lifeTimeCount;
        
    repeatTexture.sprite.textureRect = CGRectMake( x, y, repeatTexture.sprite.textureRect.size.width, repeatTexture.sprite.textureRect.size.height );
}

@end

