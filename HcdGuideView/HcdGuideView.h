#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HcdGuideView : NSObject

@property (nonatomic, strong) UIWindow *window;

/**
 *  创建单例模式
 */
+ (instancetype)sharedInstance;

/**
 *  引导页图片
 *
 *  @param images      引导页图片
 *  @param title       按钮文字
 *  @param titleColor  文字颜色
 *  @param bgColor     按钮背景颜色
 *  @param borderColor 按钮边框颜色
 */
- (void)showGuideViewWithImages:(NSArray *)images
                 andButtonTitle:(NSString *)title
            andButtonTitleColor:(UIColor *)titleColor
               andButtonBGColor:(UIColor *)bgColor
           andButtonBorderColor:(UIColor *)borderColor;

@end

//使用案例

/*
 #pragma  mark 设置引导页
 -(void) setupAppGuidePage{
 
     NSMutableArray *images = [NSMutableArray new];

     [images addObject:[UIImage imageNamed:@"appLunch1.jpg"]];

     [images addObject:[UIImage imageNamed:@"appLunch2.jpg"]];

     [images addObject:[UIImage imageNamed:@"appLunch3.jpg"]];

     HcdGuideView *guideView = [HcdGuideView sharedInstance];

     guideView.window =self.window;

     [guideView showGuideViewWithImages:images
     andButtonTitle:@"立即体验"
     andButtonTitleColor:CurrentAppThemeColor
     andButtonBGColor:[UIColor clearColor]
     andButtonBorderColor:CurrentAppThemeColor];

 }
 */
