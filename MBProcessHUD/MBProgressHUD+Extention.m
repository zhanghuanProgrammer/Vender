
#import "MBProgressHUD+Extention.h"
#import "UIImage+GIF.h"

@implementation MBProgressHUD (Extention)

+ (instancetype)showMessage:(NSString*)message{
    return [self showMessage:message toView:nil];
}

+ (instancetype)showMessage:(NSString*)message toView:(UIView*)view{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    NSArray* subView = [view subviews];
    UIView* target;
    for (UIView* tempView in subView) {
        if ([tempView isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD* hud = (MBProgressHUD*)tempView;
            if (hud.labelText.length > 0) {
                target = tempView;
                break;
            }
        }
    }
    if (target) {
        [(MBProgressHUD*)target hide:NO];
    }

    // 快速显示一个提示信息
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = StringNoNull(message);
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.labelFont = [UIFont systemFontOfSize:16];
    hud.margin = 20.0f;

    //一秒消失
    [hud hide:YES afterDelay:1.5];
    return hud;
}

+ (void)hideHUDForView:(UIView*)view{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:YES];
}

+ (instancetype)showGifLoding:(UIView*)view{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView* gifImageView = [[UIImageView alloc] initWithImage:[UIImage sd_animatedGIFNamed:@"gifLoding"]];
    gifImageView.bounds = CGRectMake(0, 0, 80, 80);
    //    SDLogViewFrame(gifImageView);
    hud.customView = gifImageView;
    hud.color = [UIColor whiteColor];
    hud.backgroundColor = RGBA(0, 0, 0, 0.5);
    return hud;
}

+ (instancetype)showRotationLoading:(UIView*)view{
    if (view == nil)
        view = [UIApplication sharedApplication].keyWindow;

    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 80)];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
    imageView.frame = CGRectMake(20, 0, 50, 50);
    imageView.tag = 1994;
    [customView addSubview:imageView];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, 90, 15)];
    label.text = @"玩命加载中...";
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    [imageView rotationAnimationDuration:1 repeatCount:MAXFLOAT];
    [customView addSubview:label];
    hud.customView = customView;
    hud.color = [UIColor whiteColor];
    hud.backgroundColor = RGBA(0, 0, 0, 0.5);
    return hud;
}

@end

