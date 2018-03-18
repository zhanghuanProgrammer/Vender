
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface QRCodeGenerator : NSObject
//for ios7+ 生成二维码
- (UIImage *)imageWithSize:(CGFloat)size andColorWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue andQRString:(NSString *)qrString;

- (UIImage*)imageWithSize:(CGFloat)size andColor:(UIColor *)color andQRString:(NSString *)qrString;

@end
