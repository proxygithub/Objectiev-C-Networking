
#import <Foundation/Foundation.h>
#import "AsyncRequest.h"
#import <UIKit/UIKit.h>

typedef void (^RequestComplitionBlock)(NSObject *resObj);

@interface SyncHelper : NSObject<AsyncRequestDelegate> {

}

-(void)uploadAllDataToServer:(RequestComplitionBlock) reqBlock;

@end

