#import <Foundation/Foundation.h>

@interface ZHNotificationLocal : NSObject

/**time 这里的time是针对当天00:00以后的分钟数*/
+ (void)registerLocalNotificationForTime:(NSInteger)time content:(NSString *)content repeatInterval:(NSCalendarUnit)repeatInterval;

+ (void)cancelLocalNotificationForTime:(NSInteger)time;

+ (void)all;

+ (void)removeAll;

@end
