//
//  ZHCustomTabBarController.m
//  FTDTabBarController
//
//  Created by ZH on 15/4/29.
//  Copyright © 2016年 ZH. All rights reserved.
//

#import "ZHCustomTabBarController.h"
#import "ZHCustomTabBar.h"
#import "ZHCustomTabBarButton.h"
#import <objc/runtime.h>

NSString *const FTDTabBarItemTitle = @"FTDTabBarItemTitle";
NSString *const FTDTabBarItemImage = @"FTDTabBarItemImage";
NSString *const FTDTabBarItemSelectedImage = @"FTDTabBarItemSelectedImage";

NSUInteger FTDTabbarItemsCount = 0;
NSUInteger FTDCustomButtonIndex = 0;
CGFloat FTDTabBarItemWidth = 0.0f;
NSString *const FTDTabBarItemWidthDidChangeNotification = @"FTDTabBarItemWidthDidChangeNotification";
static void * const FTDSwappableImageViewDefaultOffsetContext = (void*)&FTDSwappableImageViewDefaultOffsetContext;

#pragma mark - NSObject+FTDTabBarControllerItem

@interface NSObject (FTDTabBarControllerItemInternal)

- (void)ftd_setTabBarController:(ZHCustomTabBarController *)tabBarController;

@end
@implementation NSObject (FTDTabBarControllerItemInternal)

- (void)ftd_setTabBarController:(ZHCustomTabBarController *)tabBarController {
    objc_setAssociatedObject(self, @selector(ftd_tabBarController), tabBarController, OBJC_ASSOCIATION_ASSIGN);
}
@end

@implementation NSObject (ZHCustomTabBarController)

- (ZHCustomTabBarController *)ftd_tabBarController {
    ZHCustomTabBarController *tabBarController = objc_getAssociatedObject(self, @selector(ftd_tabBarController));
    if (!tabBarController ) {
        if ([self isKindOfClass:[UIViewController class]] && [(UIViewController *)self parentViewController]) {
            tabBarController = [[(UIViewController *)self parentViewController] ftd_tabBarController];
        } else {
            id<UIApplicationDelegate> delegate = ((id<UIApplicationDelegate>)[[UIApplication sharedApplication] delegate]);
            UIWindow *window = delegate.window;
            if ([window.rootViewController isKindOfClass:[ZHCustomTabBarController class]]) {
                tabBarController = (ZHCustomTabBarController *)window.rootViewController;
            }
        }
    }
    return tabBarController;
}

@end

#pragma mark - ZHCustomTabBarController
@interface ZHCustomTabBarController ()<UITabBarControllerDelegate>

@end

@implementation ZHCustomTabBarController

@synthesize viewControllers = _viewControllers;

#pragma mark -
#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // 处理tabBar，使用自定义 tabBar 添加自定义按钮
    [self setUpTabBar];
    [self.tabBar addObserver:self forKeyPath:@"swappableImageViewDefaultOffset" options:NSKeyValueObservingOptionNew context:FTDSwappableImageViewDefaultOffsetContext];
    self.delegate = self;
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (!self.tabBarHeight) {
        return;
    }
    self.tabBar.frame = ({
        CGRect frame = self.tabBar.frame;
        CGFloat tabBarHeight = self.tabBarHeight;
        frame.size.height = tabBarHeight;
        frame.origin.y = self.view.frame.size.height - tabBarHeight;
        frame;
    });
}

- (void)dealloc {
    // 移除KVO
    [self.tabBar removeObserver:self forKeyPath:@"swappableImageViewDefaultOffset"];
}
#pragma mark -
#pragma mark - Private Methods

/**
 *  利用 KVC 把系统的 tabBar 类型改为自定义类型。
 */
- (void)setUpTabBar {
    [self setValue:[[ZHCustomTabBar alloc] init] forKey:@"tabBar"];
}

- (void)setViewControllers:(NSArray *)viewControllers {
    if (_viewControllers && _viewControllers.count) {
        for (UIViewController *viewController in _viewControllers) {
            [viewController willMoveToParentViewController:nil];
            [viewController.view removeFromSuperview];
            [viewController removeFromParentViewController];
        }
    }
    if (viewControllers && [viewControllers isKindOfClass:[NSArray class]]) {
        if ((!_tabBarItemsAttributes) || (_tabBarItemsAttributes.count != viewControllers.count)) {
            [NSException raise:@"ZHCustomTabBarController" format:@"设置_tabBarItemsAttributes属性时，确保元素个数与控制器的个数相同，并在方法`-setViewControllers:`之前设置"];
        }
        
        if (FTDCustomChildViewController) {
            NSMutableArray *viewControllersWithPlusButton = [NSMutableArray arrayWithArray:viewControllers];
            [viewControllersWithPlusButton insertObject:FTDCustomChildViewController atIndex:FTDCustomButtonIndex];
            _viewControllers = [viewControllersWithPlusButton copy];
        } else {
            _viewControllers = [viewControllers copy];
        }
        FTDTabbarItemsCount = [viewControllers count];
        FTDTabBarItemWidth = ([UIScreen mainScreen].bounds.size.width - FTDCustomButtonWidth) / (FTDTabbarItemsCount);
        NSUInteger idx = 0;
        for (UIViewController *viewController in _viewControllers) {
            NSString *title = nil;
            NSString *normalImageName = nil;
            NSString *selectedImageName = nil;
            if (viewController != FTDCustomChildViewController) {
                title = _tabBarItemsAttributes[idx][FTDTabBarItemTitle];
                normalImageName = _tabBarItemsAttributes[idx][FTDTabBarItemImage];
                selectedImageName = _tabBarItemsAttributes[idx][FTDTabBarItemSelectedImage];
            } else {
                idx--;
            }
            
            [self addOneChildViewController:viewController
                                  WithTitle:title
                            normalImageName:normalImageName
                          selectedImageName:selectedImageName];
            [viewController ftd_setTabBarController:self];
            idx++;
        }
    } else {
        for (UIViewController *viewController in _viewControllers) {
            [viewController ftd_setTabBarController:nil];
        }
        _viewControllers = nil;
    }
}

/**
 *  添加一个子控制器
 *
 *  @param viewController    控制器
 *  @param title             标题
 *  @param normalImageName   图片
 *  @param selectedImageName 选中图片
 */
- (void)addOneChildViewController:(UIViewController *)viewController
                        WithTitle:(NSString *)title
                  normalImageName:(NSString *)normalImageName
                selectedImageName:(NSString *)selectedImageName {
    
    viewController.tabBarItem.title = title;
    if (normalImageName) {
        UIImage *normalImage = [UIImage imageNamed:normalImageName];
        normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.tabBarItem.image = normalImage;
    }
    if (selectedImageName) {
        UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.tabBarItem.selectedImage = selectedImage;
    }
    if (self.shouldCustomizeImageInsets) {
        viewController.tabBarItem.imageInsets = self.imageInsets;
    }
    if (self.shouldCustomizeTitlePositionAdjustment) {
        viewController.tabBarItem.titlePositionAdjustment = self.titlePositionAdjustment;
    }
    [self addChildViewController:viewController];
}
- (BOOL)shouldCustomizeImageInsets {
    BOOL shouldCustomizeImageInsets = self.imageInsets.top != 0.f || self.imageInsets.left != 0.f || self.imageInsets.bottom != 0.f || self.imageInsets.right != 0.f;
    return shouldCustomizeImageInsets;
}

- (BOOL)shouldCustomizeTitlePositionAdjustment {
    BOOL shouldCustomizeTitlePositionAdjustment = self.titlePositionAdjustment.horizontal != 0.f || self.titlePositionAdjustment.vertical != 0.f;
    return shouldCustomizeTitlePositionAdjustment;
}

#pragma mark - 
#pragma mark - public Methods

- (instancetype)initWithViewControllers:(NSArray<UIViewController *> *)viewControllers tabBarItemsAttributes:(NSArray<NSDictionary *> *)tabBarItemsAttributes {
    if (self = [super init]) {
        _tabBarItemsAttributes = tabBarItemsAttributes;
        self.viewControllers = viewControllers;
    }
    return self;
}

+ (instancetype)tabBarControllerWithViewControllers:(NSArray<UIViewController *> *)viewControllers tabBarItemsAttributes:(NSArray<NSDictionary *> *)tabBarItemsAttributes {
    ZHCustomTabBarController *tabBarController = [[ZHCustomTabBarController alloc] initWithViewControllers:viewControllers tabBarItemsAttributes:tabBarItemsAttributes];
    
    return tabBarController;
}

+ (BOOL)haveCustomButton {
    if (FTDExternCustomButton) {
        return YES;
    }
    return NO;
}

+ (NSUInteger)allItemsInTabBarCount {
    NSUInteger allItemsInTabBar = FTDTabbarItemsCount;
    if ([ZHCustomTabBarController haveCustomButton]) {
        allItemsInTabBar += 1;
    }
    return allItemsInTabBar;
}

- (id<UIApplicationDelegate>)appDelegate {
    return [UIApplication sharedApplication].delegate;
}

- (UIWindow *)rootWindow {
    UIWindow *result = nil;
    
    do {
        if ([self.appDelegate respondsToSelector:@selector(window)]) {
            result = [self.appDelegate window];
        }
        
        if (result) {
            break;
        }
    } while (NO);
    
    return result;
}
#pragma mark -
#pragma mark - KVO Method

// KVO监听执行
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if(context != FTDSwappableImageViewDefaultOffsetContext) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    if(context == FTDSwappableImageViewDefaultOffsetContext) {
        CGFloat swappableImageViewDefaultOffset = [change[NSKeyValueChangeNewKey] floatValue];
        [self offsetTabBarSwappableImageViewToFit:swappableImageViewDefaultOffset];
    }
}

- (void)offsetTabBarSwappableImageViewToFit:(CGFloat)swappableImageViewDefaultOffset {
    if (self.shouldCustomizeImageInsets) {
        return;
    }
    NSArray<UITabBarItem *> *tabBarItems = [self ftd_tabBarController].tabBar.items;
    [tabBarItems enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIEdgeInsets imageInset = UIEdgeInsetsMake(swappableImageViewDefaultOffset, 0, -swappableImageViewDefaultOffset, 0);
        obj.imageInsets = imageInset;
        if (!self.shouldCustomizeTitlePositionAdjustment) {
            obj.titlePositionAdjustment = UIOffsetMake(0, MAXFLOAT);
        }
    }];
}

#pragma mark - delegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController*)viewController
{
    NSUInteger selectedIndex = tabBarController.selectedIndex;
    UIButton *plusButton = FTDExternCustomButton;
    if (FTDCustomChildViewController) {
        if ((selectedIndex == FTDCustomButtonIndex) && (viewController != FTDCustomChildViewController)) {
            plusButton.selected = NO;
        }
    }
    if (tabBarController.selectedIndex == 0) {
        tabBarController.selectedViewController.tabBarItem.title = @"首页";
        tabBarController.selectedViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return YES;
}

- (void)setSelectedIndex:(NSUInteger)index
{
    [super setSelectedIndex:index];
    [self setNoHighlightTabBar];
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController
{
    [super setSelectedViewController:selectedViewController];
    if (selectedViewController.tabBarController.selectedIndex == 0) {
        selectedViewController.tabBarItem.title = @"";
        selectedViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
    [self setNoHighlightTabBar];
}
- (void)setNoHighlightTabBar
{
    NSArray * tabBarSubviews = [self.tabBar subviews];
    for(UIView *sub in tabBarSubviews)
    {
        for(UIView * insub in [sub subviews])
        {
            if(insub && [NSStringFromClass([insub class]) isEqualToString:@"UITabBarSelectionIndicatorView"])//选中图片对于的view
            {
                [insub removeFromSuperview];
                break;
            }
        }
    }
}
@end
