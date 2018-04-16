
#import "GradientView.h"

@implementation GradientView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 绘制颜色渐变
    // 创建色彩空间对象
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    // 创建起点颜色
    CGColorRef beginColor = CGColorCreate(colorSpaceRef, (CGFloat[]){self.startColor.red, self.startColor.green, self.startColor.blue,self.startColor.alpha});
    // 创建终点颜色
    CGColorRef endColor = CGColorCreate(colorSpaceRef, (CGFloat[]){self.endColor.red, self.endColor.green, self.endColor.blue,self.startColor.alpha});
    // 创建颜色数组
    CFArrayRef colorArray = CFArrayCreate(kCFAllocatorDefault, (const void*[]){beginColor, endColor}, 2, nil);
    // 创建渐变对象
    CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpaceRef, colorArray, (CGFloat[]){
        0.0f,	   // 对应起点颜色位置
        1.0f		// 对应终点颜色位置
    });
    // 释放颜色数组
    CFRelease(colorArray);
    // 释放起点和终点颜色
    CGColorRelease(beginColor);
    CGColorRelease(endColor);
    // 释放色彩空间
    CGColorSpaceRelease(colorSpaceRef);
    
    CGContextDrawLinearGradient(context, gradientRef, self.startPoint, self.endPoint, 0);
    
    // 释放渐变对象
    CGGradientRelease(gradientRef);
}
@end
