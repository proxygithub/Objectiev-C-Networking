
#import <Foundation/Foundation.h>
#import "Response.h"
#import "Request.h"
#import <UIKit/UIKit.h>


@protocol AsyncRequestDelegate <NSObject>

-(void)asyncRequestDelegate :(NSString *)action :(Response *)responseData;
@end

@interface AsyncRequest : NSObject {
	id<AsyncRequestDelegate> delegate;
}

@property (nonatomic, retain) id<AsyncRequestDelegate> delegate;

-(void)sendPostRequest :(NSString *)action :(Request *)requestData;
-(void)sendPostRequestWithUpload :(NSString *)action :(Request *)requestData;
-(void)sendJsonRequest :(NSString *)action :(Request *)requestData;
-(void)sendPostRequestWithImage:(NSString *)action image:(UIImage*)image  requestData:(Request *)requestData;
-(void)downloadFileFromPath:(NSString *)filePath WithCB:(NSString *)callBack;
@end

