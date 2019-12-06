
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>



static NSString *const kAPIKey = @"AIzaSyD-qNZVXORbZF9IGpeXl13nYk6t7X-e6c8";

#define APP_NAME @"Alameda Mapvision iMobile" //@"Alameda Catchbasin"

#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication]delegate])
#define LOCALISEDSTRING(str) NSLocalizedString(str, nil)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#pragma mark ============= API Section =============

#define ACTION_MASTER_SYNC_SEPRATE          @"alamedawebservice/sync_master_data_by_table"

#define TIMEZONE                        @"PST" //@"IST"

//Static Keys
#define USER_CODE                       4
#define CEO_CODE                        2
#define RES_CODE                        @"flag"
#define RES_MESSAGE                     @"message"
#define RES_OBJECT                      @"details"
#define USER_DEVICE_ID                  @"USER_DEVICE_ID"
#define KEY_APP_VERSION                 @"appVersion"
#define KEY_NOTIFY_UPDATE               @"notify_update"

//Userdefaults
#define userDefaults_get_object(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define userDefaults_set_object(key, object) \
[[NSUserDefaults standardUserDefaults] setObject:object forKey:key]; \
[[NSUserDefaults standardUserDefaults] synchronize];

#define userDefaults_remove_object(key) [[NSUserDefaults standardUserDefaults]removeObjectForKey:key]; \
[[NSUserDefaults standardUserDefaults] synchronize];

#pragma mark Utilities ==========================

//Two digits

#define DIGIT_STRING(value)  [NSString stringWithFormat:@"%02d",value]

//Rounded corners
#define ROUNDEDCORNERS(view,value) view.layer.cornerRadius = value;\
                                    view.layer.masksToBounds = YES;

#define BORDER(view) view.layer.borderColor = [UIColor colorWithRed:206.0/255.0 green:206.0/255.0 blue:206.0/255.0 alpha:1.0].CGColor;\
                     view.layer.borderWidth = 1.0;

//Alert
//#define showAlert(msg) [[[UIAlertView alloc] initWithTitle:APP_NAME message:msg delegate:nil cancelButtonTitle:LOCALISEDSTRING(@"Ok") otherButtonTitles:nil, nil] show]

#define showAlert(msg) [self presentViewController:[UIAlertController alertControllerWithTitle:APP_NAME message:msg preferredStyle:UIAlertControllerStyleAlert] animated:YES completion:nil]

//Fonts
#define font(t,s) [UIFont fontWithName:t size:s]
#define APP_FONT_BOLD(theFontSize) [UIFont fontWithName:@"OpenSans-Bold" size:theFontSize]
#define APP_FONT_MEDIUM(theFontSize) [UIFont fontWithName:@"OpenSans-Regular" size:theFontSize]
#define APP_FONT_LIGHT(theFontSize) [UIFont fontWithName:@"OpenSans-Light" size:theFontSize]
//TitleFonts

//Set colors
#define CELL_TITLE_COLOR_MENU               [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7] //black color
#define UIColorFromRGBA(r,g,b,a)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFromHex(hexValue)            UIColorFromHexWithAlpha(hexValue,1.0)


//Display title app
#define TITLE_FONT_SIZE  17
#define TITLE_FONT [UIFont fontWithName:@"OpenSans-Bold" size:TITLE_FONT_SIZE]
#define TITLE_TEXT_COLOR App_BALUE_COLOR


// Devices height width
#define ScreenHeight                    MAX([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)
#define ScreenWidth                     MIN([[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height)


//Device Information
#define uid [[[UIDevice currentDevice] identifierForVendor] UUIDString]
#define isIPad   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isIPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define isIPhone4 (fabs((double)[[UIScreen mainScreen]bounds].size.height-(double)480)<DBL_EPSILON)
#define isIphone5 (fabs((double)[[UIScreen mainScreen]bounds].size.height-(double)568)<DBL_EPSILON)
#define isIPhone6 (fabs((double)[[UIScreen mainScreen]bounds].size.height-(double)667)<DBL_EPSILON)
#define isIPhone6p (fabs((double)[[UIScreen mainScreen]bounds].size.height-(double)736)<DBL_EPSILON)
#define isRetinaDevice ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] >= 2)

//iOS Version
#define IOS_VERSION                              [[UIDevice currentDevice] systemVersion]
#define IOS_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define IOS_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define IOS_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IOS_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define IOS_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescendi

//OTHER FLAG
#define DEVICE_IOS_VERSION   ([[[UIDevice currentDevice] systemVersion] floatValue])

//Log
#if DEBUG
#include <libgen.h>
#define ZDebug(fmt, args...)  NSLog(@"[%s:%d] %@\n", basename(__FILE__), __LINE__, [NSString stringWithFormat:fmt, ##args])
#else
#define ZDebug(fmt, args...)  ((void)0)
#endif

#define Info(fmt, args...)  NSLog(@"[%s:%d] %@\n", __FILE__, __LINE__, [NSString stringWithFormat:fmt, ##args])
#define Error(fmt, args...)  NSLog(@"[%s:%d] %@\n", __FILE__, __LINE__, [NSString stringWithFormat:fmt, ##args])

#define formatString(fmt, args...) [NSString stringWithFormat:fmt, ##args]

//Time
#define TimeStamp [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000]

#define FULL_DATE_FORMAT        @"yyyy-MM-dd HH:mm:ss"

#define APP_DATE_FORMAT                 @"d MMM yy"
#define APP_DATE_FORMAT_TIME            @"d MMM yy HH:mm"
#define DATE_FORMAT                     @"dd/MM/yyyy"
#define WORK_TIME_FORMAT                @"dd/MM/yyyy HH:mm"








