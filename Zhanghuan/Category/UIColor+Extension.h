#import <UIKit/UIKit.h>

@interface UIColor (Extension)

+ (UIColor*)getColor:(NSString*)hexColor;

/**
 *  随机颜色
 */
+ (UIColor*)gd_randomColor;

- (CGFloat)red;

- (CGFloat)green;

- (CGFloat)blue;

- (CGFloat)alpha;

@end
