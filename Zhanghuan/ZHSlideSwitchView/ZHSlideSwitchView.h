
#import <UIKit/UIKit.h>
#import "ZHSlideSwitchViewDelegate.h"

@interface ZHSlideSwitchView : UIView
/**
 代理
 */
@property (weak,nonatomic) id <ZHSlideSwitchViewDelegate>delegate;

/**
 顶部scroll
 */
@property (strong,nonatomic,readonly)  UIScrollView *topScrollView;

@property (nonatomic,strong)NSArray *titles;


/**
 是否隐藏选中效果
 */
@property (assign,nonatomic) BOOL hideShadow;

@property (assign,nonatomic) BOOL isUnderArrow;

/**
 当前选中位置
 */
@property (assign,nonatomic) NSInteger selectedIndex;

/**
 按钮正常时的颜色
 */
@property (strong,nonatomic) UIColor *btnNormalColor;

/**
 按钮选中时的颜色
 */
@property (strong,nonatomic) UIColor *btnSelectedColor;

/**
 是否需要自动分配按钮宽度
 */
@property (assign,nonatomic) BOOL adjustBtnSize2Screen;

@end
