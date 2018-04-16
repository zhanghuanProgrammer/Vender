//
//  ZHConfigBaseNavigationController.m
//  FuTongDai
//
//  Created by ZH on 15/6/21.
//  Copyright © 2016年 OFIM. All rights reserved.
//

#import "ZHConfigBaseNavigationController.h"
#import "UIBarButtonItem+ZHBarButtonCustom.h"
#import "UINavigationController+ZHFullscreenPopGesture.h"

@interface ZHConfigBaseNavigationController ()

@end

@implementation ZHConfigBaseNavigationController

#pragma mark - Life CyCle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - Public Method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 0;
        [self setUpCustomNavigationBarWithViewController:viewController];
    }
    [super pushViewController:viewController animated:YES];
}

- (void)setUpCustomNavigationBarWithViewController:(UIViewController *)viewController{
    UIBarButtonItem * item = [UIBarButtonItem itemWithTarget: self action:@selector(btnLeftBtn) image:@"back_before"  selectImage:@"back_before"];
    viewController.navigationItem.leftBarButtonItem = item;
}

- (void)btnLeftBtn{
    [self popViewControllerAnimated:YES];
}

@end

