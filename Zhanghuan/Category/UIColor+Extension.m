#import "UIColor+Extension.h"

#define DEFAULT_VOID_COLOR [UIColor whiteColor]

@implementation UIColor (Extension)

// 十六进制数转换成颜色
+ (UIColor*)getColor:(NSString*)hexColor{
    if ([hexColor hasPrefix:@"0x"]) {
        hexColor = [hexColor substringFromIndex:2];
    }
    if ([hexColor hasPrefix:@"#"]) {
        hexColor = [hexColor substringFromIndex:1];
    }
    if ([hexColor length] != 6)
        return DEFAULT_VOID_COLOR;
    //这其实是一个十六进制的颜色字符串,通过截取字符串就可以转换为十进制
    unsigned int red, green, blue;

    NSRange range;

    range.length = 2;

    range.location = 0;

    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];

    range.location = 2;

    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];

    range.location = 4;

    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];

    return [UIColor colorWithRed:(float)(red / 255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

// 随机颜色
+ (UIColor*)gd_randomColor{
    return [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
}

- (CGFloat)red{
    CGFloat r = 0, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return r;
}

- (CGFloat)green{
    CGFloat r, g = 0, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return g;
}

- (CGFloat)blue{
    CGFloat r, g, b = 0, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return b;
}

- (CGFloat)alpha{
    return CGColorGetAlpha(self.CGColor);
}
@end

