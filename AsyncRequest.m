

#import "AsyncRequest.h"
#import "Request.h"
#import "AFNetworking.h"
#import "Constant.h"


#define REQUEST_TIME_OUT            60*3
#define REQUEST_TIME_OUT_EXTENDED   60*10

@interface AsyncRequest (){
    NSString *strAction;
} 
@end


@implementation AsyncRequest

@synthesize delegate;

#pragma mark -
#pragma mark NSURLRequest


-(void)sendPostRequest :(NSString *)action :(Request *)requestData {
    
    strAction = action;

    NSString *strUrl = [NSString stringWithFormat:@"%@%@?",BASEURL,action];
    ZDebug(@"BASEURL: %@",strUrl);
    
    AFHTTPRequestOperationManager *operationmanager = [AFHTTPRequestOperationManager manager];
//    operationmanager.requestSerializer.timeoutInterval = 6000;
    operationmanager.requestSerializer.timeoutInterval = REQUEST_TIME_OUT;
    operationmanager.responseSerializer = [AFJSONResponseSerializer serializer];
    operationmanager.responseSerializer.acceptableContentTypes = [operationmanager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    operationmanager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    operationmanager.securityPolicy.allowInvalidCertificates = YES;
    
   // operationmanager.securityPolicy.validatesCertificateChain = NO;
    
    [operationmanager POST:strUrl parameters:requestData.dictPermValues success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         NSDictionary *responsedictionary = (NSDictionary *)responseObject;
        // ZDebug(@"sendPostRequest > response: %@", responsedictionary);
         Response *response = [[Response alloc] init];
         response.jsonData = responsedictionary;
         
         if([delegate respondsToSelector:@selector(asyncRequestDelegate::)])
             [delegate asyncRequestDelegate:strAction :response];
     }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@" +++++>> sendPostRequest > Failer %@", error.localizedDescription);
        
        NSDictionary *responsedictionary = [NSDictionary dictionaryWithObjectsAndKeys:RES_CODE_FAIL, RES_CODE ,LOCALISEDSTRING(@"RESPONSE_ERROR"), RES_MESSAGE, nil];
        appDelegate.strErrorMsg = error.localizedDescription;
//        NSDictionary *responsedictionary = [NSDictionary dictionaryWithObjectsAndKeys:RES_CODE_FAIL, RES_CODE ,error.localizedDescription, RES_MESSAGE, nil];
        Response *response = [[Response alloc] init];
        response.jsonData = responsedictionary;
        
        if([delegate respondsToSelector:@selector(asyncRequestDelegate::)])
            [delegate asyncRequestDelegate:strAction :response];
        
        [appDelegate hideProgress];
    }];
}


-(void)sendJsonRequest :(NSString *)action :(Request *)requestData {
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithDictionary:requestData.dictPermValues];
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    NSString *ver = infoDictionary[@"CFBundleShortVersionString"];
    
    [dic setValue:language forKey:@"language"];
    [dic setValue:@"ios" forKey:@"os"];
    [dic setValue:ver forKey:@"app_version"];
    
    requestData.dictPermValues = [[NSMutableDictionary alloc] initWithDictionary:dic];
    
    strAction = action;
    
    ZDebug(@"sendPostRequest > action: %@", action);
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestData.dictPermValues options:NSJSONWritingPrettyPrinted error:&error];
    
    //NSString *paraStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString *strUrl=[NSString stringWithFormat:@"%@%@",BASEURL,action];
    
    AFHTTPRequestOperationManager *operationmanager = [AFHTTPRequestOperationManager manager];
    
    // PARAMETERS IN HEADER
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    operationmanager.requestSerializer = requestSerializer;
    operationmanager.responseSerializer = [AFJSONResponseSerializer serializer];
    [operationmanager.requestSerializer setTimeoutInterval:REQUEST_TIME_OUT];
    
    operationmanager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    operationmanager.securityPolicy.allowInvalidCertificates = YES;
    
    [operationmanager POST: strUrl parameters: requestData.dictPermValues   success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
         NSDictionary *responsedictionary = (NSDictionary *)responseObject;
         ZDebug(@"sendPostRequest > action: %@", action);
         
         ZDebug(@"sendPostRequest > response: %@", responsedictionary);
         Response *response = [[Response alloc] init];
         response.jsonData = responsedictionary;
        appDelegate.strErrorMsg = [GeneralUtil getValidString:[responsedictionary valueForKey:@"message"]];
         if([delegate respondsToSelector:@selector(asyncRequestDelegate::)])
             [delegate asyncRequestDelegate:strAction :response];
        
     }
   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
       NSLog(@" +++++>> sendPostRequestWithImage > Failer %@", error.localizedDescription);
       
//       NSDictionary *responsedictionary = [NSDictionary dictionaryWithObjectsAndKeys:RES_CODE_FAIL, RES_CODE,error.localizedDescription, RES_MESSAGE, nil];
       NSDictionary *responsedictionary = [NSDictionary dictionaryWithObjectsAndKeys:RES_CODE_FAIL, RES_CODE,LOCALISEDSTRING(@"RESPONSE_ERROR"), RES_MESSAGE, nil];
       appDelegate.strErrorMsg = error.localizedDescription;
       Response *response = [[Response alloc] init];
       response.jsonData = responsedictionary;
       
       if([delegate respondsToSelector:@selector(asyncRequestDelegate::)])
           [delegate asyncRequestDelegate:strAction :response];
       
       [appDelegate hideProgress];
       
   }];
}

-(void)sendPostRequestWithImage:(NSString *)action image:(UIImage*)image  requestData:(Request *)requestData
{
    strAction = action;
    
    ZDebug(@"sendPostRequest > action: %@", action);
    ZDebug(@"sendPostRequest > request: %@", requestData);
    
    NSString *strUrl=[NSString stringWithFormat:@"%@%@",BASEURL,action];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager POST:strUrl parameters:requestData.dictPermValues constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        NSData *imageData ;
        imageData = UIImageJPEGRepresentation(image, 0.5);
        [formData appendPartWithFileData:imageData name:@"user_photo" fileName:[NSString stringWithFormat:@"%@.jpg",TimeStamp] mimeType:@"image/jpeg"];
        
    }
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Success: %@", responseObject);
         NSDictionary *responsedictionary = (NSDictionary *)responseObject;
         
         Response *response = [[Response alloc] init];
         response.jsonData = responsedictionary;
         
         if([delegate respondsToSelector:@selector(asyncRequestDelegate::)])
             [delegate asyncRequestDelegate:strAction :response];
     }
     
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@" +++++>> sendPostRequestWithImage > Failer %@", error.localizedDescription);
         
         NSDictionary *responsedictionary = [NSDictionary dictionaryWithObjectsAndKeys:RES_CODE_FAIL, RES_CODE,LOCALISEDSTRING(@"RESPONSE_ERROR"), RES_MESSAGE, nil];
         
         Response *response = [[Response alloc] init];
         response.jsonData = responsedictionary;
         
         if([delegate respondsToSelector:@selector(asyncRequestDelegate::)])
             [delegate asyncRequestDelegate:strAction :response];
         
          [appDelegate hideProgress];
     }];
}

-(void)downloadFileFromPath:(NSString *)filePath WithCB:(NSString *)callBack {
    
    strAction = callBack;
    
    NSURL *url = [NSURL URLWithString:[filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSString *fullPath = [NSTemporaryDirectory() stringByAppendingPathComponent:[url lastPathComponent]];
    
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:fullPath append:NO]];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
       // NSLog(@"bytesRead: %u, totalBytesRead: %lld, totalBytesExpectedToRead: %lld", bytesRead, totalBytesRead, totalBytesExpectedToRead);
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"RES: %@", [[[operation response] allHeaderFields] description]);
        
        NSError *error;
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:fullPath error:&error];
        
        Response *response = [[Response alloc] init];
        
        if (error) {
            NSLog(@"ERR: %@", [error description]);
        
//            NSDictionary *responsedictionary = [NSDictionary dictionaryWithObjectsAndKeys:RES_CODE_FAIL, RES_CODE,error.localizedDescription, RES_MESSAGE, nil];
            NSDictionary *responsedictionary = [NSDictionary dictionaryWithObjectsAndKeys:RES_CODE_FAIL, RES_CODE,LOCALISEDSTRING(@"RESPONSE_ERROR"), RES_MESSAGE, nil];
            appDelegate.strErrorMsg = error.localizedDescription;            
            
            response.jsonData = responsedictionary;
        }
        else {
            
            NSDictionary *responsedictionary = [NSDictionary dictionaryWithObjectsAndKeys: RES_CODE_SUCCESS, RES_CODE, fullPath, @"file_path", nil];
            response.jsonData = responsedictionary;
        }
        
        if([delegate respondsToSelector:@selector(asyncRequestDelegate::)])
            [delegate asyncRequestDelegate:strAction :response];
        
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERR: %@ \n%@", [error description],[error localizedDescription]);
        
        Response *response = [[Response alloc] init];
        NSDictionary *responsedictionary = [NSDictionary dictionaryWithObjectsAndKeys:RES_CODE_FAIL, RES_CODE, [error localizedDescription], RES_MESSAGE, nil];
        
        response.jsonData = responsedictionary;
        if([delegate respondsToSelector:@selector(asyncRequestDelegate::)])
            [delegate asyncRequestDelegate:strAction :response];
    }];
    
    [operation start];
}
@end
