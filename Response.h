
#import <Foundation/Foundation.h>

@interface Response : NSObject {
    NSMutableDictionary *dictPermValues;
    id jsonData;
}

@property (nonatomic, strong) NSMutableDictionary *dictPermValues;
@property (nonatomic, strong) id jsonData;
@end
