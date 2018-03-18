
#import <UIKit/UIKit.h>

@interface UIColor (Extend)

+ (UIColor *)randomColor;

+ (instancetype)r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b alphaComponent:(CGFloat)alpha;

+ (instancetype)r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b;

+ (instancetype)r:(uint8_t)r g:(uint8_t)g b:(uint8_t)b a:(uint8_t)a;

+ (instancetype)rgba:(NSUInteger)rgba;

+ (instancetype)colorWithHexString:(NSString*)hexString;

- (NSUInteger)rgbaValue;

@end
