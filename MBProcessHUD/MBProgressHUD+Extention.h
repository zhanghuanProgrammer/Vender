
#import "MBProgressHUD.h"

@interface MBProgressHUD (Extention)

+ (instancetype)showMessage:(NSString*)message;

+ (instancetype)showMessage:(NSString*)message toView:(UIView*)view;

+ (void)hideHUDForView:(UIView*)view;

+ (instancetype)showGifLoding:(UIView*)view;

+ (instancetype)showRotationLoading:(UIView*)view;

@end
