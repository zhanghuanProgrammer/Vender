//
//  UIViewController+ZHTabBarControllerExtention.h
//  FuTongDai
//
//  Created by ZH on 15/7/13.
//  Copyright © 2016年 OFIM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FTDPopSelectTabBarChildViewControllerCompletion)(__kindof UIViewController *selectedTabBarChildViewController);

@interface UIViewController (FTDTabBarControllerExtention)
/*
 * Pop 到当前 `NavigationController` 的栈底，并改变 `TabBarController` 的 `selectedViewController` 属性，并将被选择的控制器作为返回值返回。
 * @param index  需要选择的控制器在 `TabBar` 中的 index。
 * @return       最终被选择的控制器。
 */
- (UIViewController *)FTD_popSelectTabBarChildViewControllerAtIndex:(NSUInteger)index;

/*
 * Pop 到当前 `NavigationController` 的栈底，并改变 `TabBarController` 的 `selectedViewController` 属性，并将被选择的控制器在 `Block` 回调中返回。
 * @param index 需要选择的控制器在 `TabBar` 中的 index。
 */
- (void)FTD_popSelectTabBarChildViewControllerAtIndex:(NSUInteger)index
                                           completion:(FTDPopSelectTabBarChildViewControllerCompletion)completion;

/*
 * Pop 到当前 `NavigationController` 的栈底，并改变 `TabBarController` 的 `selectedViewController` 属性，并将被选择的控制器作为返回值返回。
 * @param classType 需要选择的控制器所属的类。
 * @return          最终被选择的控制器。
 */
- (UIViewController *)FTD_popSelectTabBarChildViewControllerForClassType:(Class)classType;

/*
 * Pop 到当前 `NavigationController` 的栈底，并改变 `TabBarController` 的 `selectedViewController` 属性，并将被选择的控制器在 `Block` 回调中返回。
 * @param classType 需要选择的控制器所属的类。
 */
- (void)FTD_popSelectTabBarChildViewControllerForClassType:(Class)classType
                                                completion:(FTDPopSelectTabBarChildViewControllerCompletion)completion;
@end
