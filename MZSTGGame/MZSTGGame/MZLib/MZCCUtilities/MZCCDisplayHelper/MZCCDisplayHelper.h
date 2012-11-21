#import <Foundation/Foundation.h>
#import "MZCGPointMacro.h"
#import "ccTypes.h"

typedef enum
{
    kMZDeviceScreenSizeType_Unknow,
    kMZDeviceScreenSizeType_IPhoneThreePointFiveInch,
    kMZDeviceScreenSizeType_IPhoneFourInch,
    kMZDeviceScreenSizeType_IPadNinePointSevenInch,
}MZDeviceScreenSizeType;

typedef enum 
{
    kMZDeviceType_Unknow,
    kMZDeviceType_iPhone,
    kMZDeviceType_iPad,
}MZDeviceType;

@interface MZCCDisplayHelper : NSObject
{
    CGPoint originInReal;
    
    UIActivityIndicatorView *activityIndicatorView;
}

+(MZCCDisplayHelper *)sharedInstance;
-(void)setDisplayInfoAfterViewActive;

-(CGPoint)realPositionFromStandard:(CGPoint)standardPosition;
-(CGPoint)standardPositionFromReal:(CGPoint)realPosition;

-(CGPoint)realPositionFromProportionWithStandard:(CGPoint)standardPosition;

-(UIActivityIndicatorView *)getUIActivityIndicatorView;
-(UIActivityIndicatorView *)getUIActivityIndicatorViewWithStdPosition:(CGPoint)stdPosition;

@property (nonatomic, readonly) bool isSimulator;
@property (nonatomic, readonly) float deviceScale;
@property (nonatomic, readonly) MZDeviceType deviceType;
@property (nonatomic, readonly) MZDeviceScreenSizeType deviceScreenSizeType;
@property (nonatomic, readonly) ccResolutionType resolutionType;
@property (nonatomic, readonly) CGPoint realCenter;
@property (nonatomic, readonly) CGPoint stanadardCenter;
@property (nonatomic, readonly) CGSize standardScreenSize;
@property (nonatomic, readonly) CGSize realScreenSize;
@property (nonatomic, readonly) CGRect standardScreenRect;
@property (nonatomic, readonly) CGRect standardScreenRectInReal;
@property (nonatomic, readonly) NSString *deviceModelName;

@end