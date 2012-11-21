#import "MZCCDisplayHelper.h"
#import "MZLogMacro.h"
#import "CCDirector.h"

#define GAME_VIEW_STANDARD_SIZE CGSizeMake( 320, 480 )

@interface MZCCDisplayHelper (Private)
-(bool)_getIsSimulator;
-(MZDeviceType)_getDeviceType; 
-(ccResolutionType)_getCCResolutionType;
-(CGSize)_getRealScreenSize;
-(void)_calcuteOriginInRealAndDeviceScale;
@end

#pragma mark

@implementation MZCCDisplayHelper

@synthesize isSimulator;
@synthesize deviceScale;
@synthesize deviceType;
@synthesize deviceScreenSizeType;
@synthesize resolutionType;
@synthesize realCenter;
@synthesize stanadardCenter;
@synthesize standardScreenRect;
@synthesize realScreenSize;
@synthesize standardScreenSize;
@synthesize standardScreenRectInReal;
@synthesize deviceModelName;

MZCCDisplayHelper *sharedDisplayHelper_ = nil;

#pragma mark - init and dealloc

+(MZCCDisplayHelper *)sharedInstance
{
    if( sharedDisplayHelper_ == nil )
        sharedDisplayHelper_ = [[MZCCDisplayHelper alloc] init];
    
    return sharedDisplayHelper_;
}

-(id)init
{
    MZAssert( sharedDisplayHelper_ == nil, @"i i i am ..." );
    
    self = [super init];
    return self;
}

-(void)dealloc
{
    [deviceModelName release];
    [activityIndicatorView release];
    
    [sharedDisplayHelper_ release];
    sharedDisplayHelper_ = nil;

    [super dealloc];
}

#pragma mark - properties

-(MZDeviceScreenSizeType)deviceScreenSizeType
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    if( CGSizeEqualToSize( screenSize, CGSizeMake( 320, 480 ) ) )
        return kMZDeviceScreenSizeType_IPhoneThreePointFiveInch;
    
    if( CGSizeEqualToSize( screenSize, CGSizeMake( 320, 568 ) ) )
        return kMZDeviceScreenSizeType_IPhoneFourInch;
    
    if( CGSizeEqualToSize( screenSize, CGSizeMake( 768, 1024 ) ) )
        return kMZDeviceScreenSizeType_IPadNinePointSevenInch;

    return kMZDeviceScreenSizeType_Unknow;
}

-(CGPoint)realCenter
{
    return CGPointMake( self.realScreenSize.width/2, self.realScreenSize.height/2 );
}

-(CGPoint)stanadardCenter
{
    return CGPointMake( self.standardScreenSize.width/2, self.standardScreenSize.height/2 );
}

-(CGRect)standardScreenRect
{
    return CGRectMake( 0, 0, GAME_VIEW_STANDARD_SIZE.width, GAME_VIEW_STANDARD_SIZE.height );
}

-(CGRect)standardScreenRectInReal
{
    return CGRectMake( originInReal.x, originInReal.y, GAME_VIEW_STANDARD_SIZE.width*deviceScale, GAME_VIEW_STANDARD_SIZE.height*deviceScale );
}

#pragma mark - methods

-(void)setDisplayInfoAfterViewActive
{
    MZAssert( [[CCDirector sharedDirector] view] != nil, @"view is nil" );
    MZAssert( !CGSizeEqualToSize( [[CCDirector sharedDirector] winSize], CGSizeZero ), @"winSize is ZERO" );
    
    deviceModelName = [[UIDevice currentDevice].model retain];
    standardScreenSize = CGSizeMake( 320, 480 );
    realScreenSize = [self _getRealScreenSize];
    
    isSimulator = [self _getIsSimulator];
    deviceType = [self _getDeviceType];
    resolutionType = [self _getCCResolutionType];
    
    [self _calcuteOriginInRealAndDeviceScale];
}

-(CGPoint)realPositionFromStandard:(CGPoint)standardPosition
{    
    return mzpAdd( originInReal, mzpMul( standardPosition, deviceScale ) );
}

-(CGPoint)standardPositionFromReal:(CGPoint)realPosition
{
    return mzpDiv( mzpSub( realPosition, originInReal ), deviceScale );
}

-(CGPoint)realPositionFromProportionWithStandard:(CGPoint)standardPosition
{    
    CGPoint stdDiff = mzp( standardPosition.x - GAME_VIEW_STANDARD_SIZE.width/2, standardPosition.y - GAME_VIEW_STANDARD_SIZE.height/2 );
    
    float scaleRatioX = ( realScreenSize.width/deviceScale )/GAME_VIEW_STANDARD_SIZE.width;
    float scaleRatioY = ( realScreenSize.height/deviceScale )/GAME_VIEW_STANDARD_SIZE.height;
    
    CGPoint scaleRatio = mzp( stdDiff.x*scaleRatioX, stdDiff.y*scaleRatioY );
    
    CGPoint fixValus = mzpSub( stdDiff, scaleRatio );
    
    CGPoint newStdPos = mzpSub( standardPosition, fixValus );
    
    return [self realPositionFromStandard: newStdPos];
}

-(UIActivityIndicatorView *)getUIActivityIndicatorView
{
    if( activityIndicatorView == nil )
    {
        activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
                
        activityIndicatorView.hidesWhenStopped = true;
        float scale = 1.0*[MZCCDisplayHelper sharedInstance].deviceScale;
        activityIndicatorView.transform = CGAffineTransformMakeScale( scale, scale );
        [[[CCDirector sharedDirector] view] addSubview: activityIndicatorView];
    }
    
    return activityIndicatorView;
}

-(UIActivityIndicatorView *)getUIActivityIndicatorViewWithStdPosition:(CGPoint)stdPosition
{
    UIActivityIndicatorView *currentActivityIndicatorViewRef = [self getUIActivityIndicatorView];
    currentActivityIndicatorViewRef.center = [[MZCCDisplayHelper sharedInstance] realPositionFromStandard: stdPosition];
    
    return currentActivityIndicatorViewRef;
}

@end

#pragma mark

@implementation MZCCDisplayHelper (Private)

#pragma mark - methods

-(bool)_getIsSimulator
{
    NSString *deviceModelLowCase = [[UIDevice currentDevice].model lowercaseString];
    return ( [deviceModelLowCase rangeOfString: @"simulator"].length > 0 )? true : false;
}

-(MZDeviceType)_getDeviceType
{
    switch( [[UIDevice currentDevice] userInterfaceIdiom] )
    {
        case UIUserInterfaceIdiomPhone:
            return kMZDeviceType_iPhone;
            
        case UIUserInterfaceIdiomPad:
            return kMZDeviceType_iPad;
            
        default:
            return kMZDeviceType_Unknow;
    }
}

-(ccResolutionType)_getCCResolutionType
{
    if( deviceType == kMZDeviceType_iPad )
    {
        return kCCResolutioniPad;
    }

    if( deviceType == kMZDeviceType_iPhone )
    {
        if( CGSizeEqualToSize( self.realScreenSize, CGSizeMake( 320, 480 ) ) || CGSizeEqualToSize( self.realScreenSize, CGSizeMake( 480, 320 ) ) )
        {
            return kCCResolutioniPhone;
        }
        else
        {
            return kCCResolutioniPhoneRetinaDisplay;
        }
    }
    
    MZAssert( false, @"Unknow display type" );
    return kCCResolutionUnknown;
}

-(CGSize)_getRealScreenSize
{
    CGRect viewRect = [[[CCDirector sharedDirector] view] bounds];
    return ( GAME_VIEW_STANDARD_SIZE.width > GAME_VIEW_STANDARD_SIZE.height )? CGSizeMake( viewRect.size.height, viewRect.size.width ) : viewRect.size;
}

-(void)_calcuteOriginInRealAndDeviceScale
{
    deviceScale = ( deviceType == kMZDeviceType_iPad )? 2 : 1;
    originInReal = CGPointMake( ( realScreenSize.width - GAME_VIEW_STANDARD_SIZE.width*deviceScale )/2,
                               ( realScreenSize.height - GAME_VIEW_STANDARD_SIZE.height*deviceScale )/2 );
}

@end