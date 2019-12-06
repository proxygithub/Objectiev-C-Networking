
#import "SyncHelper.h"

#import "GeneralUtil.h"

@implementation SyncHelper {
    RequestComplitionBlock complitionBlock;

}

- (id)init {
    self = [super init];
    
    if (self) {
        databaseHelper = [[DatabaseHelper alloc] init:DATABASE_NAME];
        _arrPriorityImgname = [[NSMutableArray alloc] init];
        _arrKmlFileName = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)eTechAsyncRequestDelegate :(NSString *)action :(Response *)responseData {
    
    if ([action isEqualToString:ACTION_SYNC_DATA_APP_TO_SERVER]) {
        NSString *res_code = [NSString stringWithFormat:@"%@",[responseData.jsonData valueForKey:RES_CODE]];
    }
}

-(void)uploadAllDataToServer :(RequestComplitionBlock) reqBlock {
    
    complitionBlock = reqBlock;
    
    if(![GeneralUtil isInternetConnection]) {
        complitionBlock(LOCALISEDSTRING(@"INTERNET_ERROR"));
        return;
    } else {
        Request *request = [[Request alloc]init];
        
        NSMutableDictionary *dataDictionary = [[DBOprations sharedInstenace] getAllUploadData];
        
        if(dataDictionary) {
            request.dictPermValues = dataDictionary;
            ETechAsyncRequest *asyncRequest = [[ETechAsyncRequest alloc]init];
            asyncRequest.delegate = self;
            [asyncRequest sendJsonRequest:ACTION_SYNC_DATA_APP_TO_SERVER :request];
        } else {
            complitionBlock(RES_CODE_SUCCESS_NO_RECORDS);
        }
    }
}
@end

