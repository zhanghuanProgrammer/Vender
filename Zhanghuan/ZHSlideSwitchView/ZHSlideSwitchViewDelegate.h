
#import <Foundation/Foundation.h>

@protocol ZHSlideSwitchViewDelegate <NSObject>

@optional
/**
 切换位置
 */
- (void)slideSwitchDidselectTab:(NSUInteger)index;


@end
