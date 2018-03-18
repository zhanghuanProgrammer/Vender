
#import "ZHAutoFont.h"
#import "ZHBlockSingleCategroy.h"

@implementation ZHAutoFont

+ (void)autoFontForView:(UIView*)view{
    //保存到全局字典里,防止重复缩小字体
    if ([ZHBlockSingleCategroy defaultMyblock][@"autoFontViews"] != nil) {
        NSMutableArray* arrM = [ZHBlockSingleCategroy defaultMyblock][@"autoFontViews"];
        __weak typeof(view) weakSef = view;
        if ([arrM containsObject:weakSef]) {
            return;
        } else {
            [arrM addObject:weakSef];
        }
    } else {
        NSMutableArray* arrM = [NSMutableArray array];
        __weak typeof(view) weakSef = view;
        [arrM addObject:weakSef];
        [ZHBlockSingleCategroy defaultMyblock][@"autoFontViews"] = arrM;
    }

    //获取所有的textfeild Label button
    NSArray* textControls = [self allTextControls:view];
    for (UIView* view in textControls) {
        if ([view isKindOfClass:[UIButton class]]) {

            UIButton* button = ((UIButton*)view);
            UIFont* font = button.titleLabel.font;
            if (font.pointSize > 0)
                button.titleLabel.font = [UIFont fontWithName:button.titleLabel.font.fontName size:font.pointSize * CurrentScreen_Width / 375.0];
        } else if ([view isKindOfClass:[UILabel class]]) {
            UILabel* label = ((UILabel*)view);
            UIFont* font = label.font;
            if (font.pointSize > 0)
                label.font = [UIFont fontWithName:label.font.fontName size:font.pointSize * CurrentScreen_Width / 375.0];
        }
        else if ([view isKindOfClass:[UITextField class]]) {
            UITextField* textField = ((UITextField*)view);
            UIFont* font = textField.font;
            if (font.pointSize > 0)
                textField.font = [UIFont fontWithName:textField.font.fontName size:font.pointSize * CurrentScreen_Width / 375.0];
        }
    }
}
+ (void)autoFontForVC:(UIViewController*)viewController{
    [self autoFontForView:viewController.view];
}
+ (NSArray*)allTextControls:(UIView*)view{
    NSMutableArray* textControls = [NSMutableArray array];
    //[view isKindOfClass:[UITextView class]]||
    if ([view isKindOfClass:[UILabel class]] || [view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UIButton class]]) {
        [textControls addObject:view];
    } else if (view.subviews.count > 0) {
        for (UIView* subView in view.subviews) {
            [textControls addObjectsFromArray:[self allTextControls:subView]];
        }
    }
    return textControls;
}

@end

