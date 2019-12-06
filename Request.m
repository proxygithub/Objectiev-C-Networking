
#import "Request.h"

@implementation Request
@synthesize dictPermValues;

-(id)init {
    
    if([super init]) {
        dictPermValues = [[NSMutableDictionary alloc] init];
        NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
//
//        [dictPermValues setValue:PARA_DEBUG forKey:@"debug"];
//        [dictPermValues setValue:language forKey:@"language"];
//        [dictPermValues setValue:appDelegate.appUser.device forKey:@"device"];
//        [dictPermValues setValue:appDelegate.appUser.os_version forKey:@"os_version"];
//        [dictPermValues setValue:appDelegate.appUser.app_version forKey:@"app_version"];
//        [dictPermValues setValue:PARA_OS_FLAG forKey:@"os"];
        
//        NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
//        NSString *ver = infoDictionary[@"CFBundleShortVersionString"];
//        
//        [dic setValue:language forKey:@"language"];
//        [dic setValue:@"ios" forKey:@"os"];
//        [dic setValue:ver forKey:@"app_version"];
        
    }
    
    return self;
}

@end
