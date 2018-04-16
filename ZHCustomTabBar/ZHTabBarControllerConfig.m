//
//  ZHTabBarControllerConfig.m
//  FTDFinancing
//
//  Created by ZH on 15/4/30.
//  Copyright © 2016年 OFIM. All rights reserved.
//

#import "ZHTabBarControllerConfig.h"
#import "HomeViewController.h"
#import "GamePageIndex.h"
#import "VideoViewController.h"
#import "CourseViewController.h"

#import "ZHConfigBaseNavigationController.h"

@interface ZHTabBarControllerConfig ()

@property (nonatomic, readwrite, strong) ZHCustomTabBarController *tabBarController;

@end

@implementation ZHTabBarControllerConfig
/**
 *  懒加载tabBarController
 *
 */
- (ZHCustomTabBarController *)tabBarController
{
    if (!_tabBarController) {
        
        ZHCustomTabBarController *tabBarController = [ZHCustomTabBarController tabBarControllerWithViewControllers:self.viewControllersForController tabBarItemsAttributes:self.tabBarItemsAttributesForController];
       
        // tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
        [self customizeTabBarAppearance:tabBarController];
        
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (NSArray *)viewControllersForController {
    
    HomeViewController *borrowingIndexVC = (HomeViewController *)[TabBarAndNavagation getViewControllerFromStoryBoardWithIdentity:@"HomeViewController"];
    
    UIViewController *firstNavigationController = [[ZHConfigBaseNavigationController alloc] initWithRootViewController:borrowingIndexVC];

    GamePageIndex *loanVC = [GamePageIndex new];
    UIViewController *secondNavigationController = [[ZHConfigBaseNavigationController alloc] initWithRootViewController:loanVC];

    VideoViewController *creditCardVC = (VideoViewController *)[TabBarAndNavagation getViewControllerFromStoryBoardWithIdentity:@"VideoViewController"];
    UIViewController *thirdNavigationController = [[ZHConfigBaseNavigationController alloc] initWithRootViewController:creditCardVC];

    CourseViewController *mineVC = (CourseViewController *)[TabBarAndNavagation getViewControllerFromStoryBoardWithIdentity:@"CourseViewController"];
    UIViewController *fourNavigationController = [[ZHConfigBaseNavigationController alloc] initWithRootViewController:mineVC];

    [TabBarAndNavagation setTitleColor:[UIColor whiteColor] forNavagationBar:borrowingIndexVC];
    [TabBarAndNavagation setTitleColor:[UIColor whiteColor] forNavagationBar:loanVC];
    [TabBarAndNavagation setTitleColor:[UIColor whiteColor] forNavagationBar:creditCardVC];
    [TabBarAndNavagation setTitleColor:[UIColor whiteColor] forNavagationBar:mineVC];

    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController,
                                 fourNavigationController
                                 ];
    return viewControllers;
}


/**
 *  设置TabBarItem的属性，包括 title、Image、selectedImage。
 */
- (NSArray *)tabBarItemsAttributesForController{
    
    NSDictionary *dict1 = @{
                            FTDTabBarItemTitle : @"首页",
                            FTDTabBarItemImage : @"Home",
                            FTDTabBarItemSelectedImage : @"Home_highlight",
                            };
    NSDictionary *dict2 = @{
                            FTDTabBarItemTitle : @"赛事",
                            FTDTabBarItemImage : @"Game",
                            FTDTabBarItemSelectedImage : @"Game_highlight",
                            };
    NSDictionary *dict3 = @{
                            FTDTabBarItemTitle : @"视频",
                            FTDTabBarItemImage : @"Video",
                            FTDTabBarItemSelectedImage : @"Video_highlight",
                            };
    NSDictionary *dict4 = @{
                            FTDTabBarItemTitle : @"课程",
                            FTDTabBarItemImage : @"Class",
                            FTDTabBarItemSelectedImage : @"Class_highlight",
                            };
    NSArray *tabBarItemsAttributes = @[
                                       dict1,
                                       dict2,
                                       dict3,
                                       dict4
                                       ];
    return tabBarItemsAttributes;
}

/**
 *  tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性的设置
 */

- (void)customizeTabBarAppearance:(ZHCustomTabBarController *)tabBarController {

    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = RGBOnly(153);
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = CurrentAppThemeColor;
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    //去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
}

@end
