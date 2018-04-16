//
//  ZHCustomTabBarController.h
//  FTDTabBarController
//
//  Created by ZH on 15/4/29.
//  Copyright © 2016年 ZH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString *const FTDTabBarItemTitle;
FOUNDATION_EXTERN NSString *const FTDTabBarItemImage;
FOUNDATION_EXTERN NSString *const FTDTabBarItemSelectedImage;
FOUNDATION_EXTERN NSString *const FTDTabBarItemWidthDidChangeNotification;
FOUNDATION_EXTERN NSUInteger FTDTabbarItemsCount;
FOUNDATION_EXTERN NSUInteger FTDCustomButtonIndex;
FOUNDATION_EXTERN CGFloat FTDCustomButtonWidth;
FOUNDATION_EXTERN CGFloat FTDTabBarItemWidth;


@interface ZHCustomTabBarController : UITabBarController

/*!
 *  显示在tabBarController上面的子控制器数组
 */
@property (nonatomic, readwrite, strong) NSArray<UIViewController *> *tarBarViewControllers;

/*!
 *  tabBarItem的属性数组
 */
@property (nonatomic, readwrite, strong) NSArray<NSDictionary *> *tabBarItemsAttributes;

/*!
 *  自定义tabar的高度
 */
@property (nonatomic, assign) CGFloat tabBarHeight;

/*!
 *  设置tabbar中图片的位置. 默认是UIEdgeInsetsZero.
 */
@property (nonatomic, readwrite, assign) UIEdgeInsets                   imageInsets;

/*!
 *  设置tabbar中文字的位置
 *
 */
@property (nonatomic, readwrite, assign) UIOffset                       titlePositionAdjustment;

/*!
 *  是否加了中间的按钮
 */
+ (BOOL)haveCustomButton;

/*!
 *  tabBar上面所有的item的数量
 */
+ (NSUInteger)allItemsInTabBarCount;

/*!
 *  返回appDelegate对象
 *
 */
- (id<UIApplicationDelegate>)appDelegate;

/*!
 *  返回当前根窗口
 *
 */
- (UIWindow *)rootWindow;

// 初始化tabBarController
- (instancetype)initWithViewControllers:(NSArray<UIViewController *> *)viewControllers tabBarItemsAttributes:(NSArray<NSDictionary *> *)tabBarItemsAttributes;

+ (instancetype)tabBarControllerWithViewControllers:(NSArray<UIViewController *> *)viewControllers tabBarItemsAttributes:(NSArray<NSDictionary *> *)tabBarItemsAttributes;

@end

@interface NSObject (ZHCustomTabBarController)

/**
 *  如果self为UIViewController的时候，返回tabBarController控制器上最顶的控制器 
 *  如果self不为UIViewController的时候，返回rootViewController（设置了FTDCustomTabBarViewController才是），否则返回nil
 */
@property (nonatomic, readonly, strong) ZHCustomTabBarController *ftd_tabBarController;

@end
