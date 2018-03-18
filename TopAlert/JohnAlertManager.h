
#import <Foundation/Foundation.h>
#import "JohnTopAlert.h"

@interface JohnAlertManager : NSObject

+ (void)showAlertWithType:(JohnTopAlertType)type title:(NSString *)title;

@end
