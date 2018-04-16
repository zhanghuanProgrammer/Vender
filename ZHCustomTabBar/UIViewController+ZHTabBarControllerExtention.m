//
//  UIViewController+ZHTabBarControllerExtention.m
//  FuTongDai
//
//  Created by ZH on 15/7/13.
//  Copyright © 2016年 OFIM. All rights reserved.
//

#import "UIViewController+ZHTabBarControllerExtention.h"
#import "ZHCustomTabBarController.h"

@implementation UIViewController (FTDTabBarControllerExtention)
- (UIViewController *)FTD_popSelectTabBarChildViewControllerAtIndex:(NSUInteger)index {
    [self checkTabBarChildControllerValidityAtIndex:index];
    [self.navigationController popToRootViewControllerAnimated:NO];
    ZHCustomTabBarController *tabBarController = [self ftd_tabBarController];
    tabBarController.selectedIndex = index;
    UIViewController *selectedTabBarChildViewController = tabBarController.selectedViewController;
    BOOL isNavigationController = [[selectedTabBarChildViewController class] isSubclassOfClass:[UINavigationController class]];
    if (isNavigationController) {
        return ((UINavigationController *)selectedTabBarChildViewController).viewControllers[0];
    }
    return selectedTabBarChildViewController;
}

- (void)FTD_popSelectTabBarChildViewControllerAtIndex:(NSUInteger)index
                                           completion:(FTDPopSelectTabBarChildViewControllerCompletion)completion {
    UIViewController *selectedTabBarChildViewController = [self FTD_popSelectTabBarChildViewControllerAtIndex:index];
    dispatch_async(dispatch_get_main_queue(), ^{
        !completion ?: completion(selectedTabBarChildViewController);
    });
}

- (UIViewController *)FTD_popSelectTabBarChildViewControllerForClassType:(Class)classType {
    ZHCustomTabBarController *tabBarController = [self ftd_tabBarController];
    __block NSInteger atIndex = NSNotFound;
    [tabBarController.viewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id obj_ = nil;
        BOOL isNavigationController = [[tabBarController.viewControllers[idx] class] isSubclassOfClass:[UINavigationController class]];
        if (isNavigationController) {
            obj_ = ((UINavigationController *)obj).viewControllers[0];
        } else {
            obj_ = obj;
        }
        if ([obj_ isKindOfClass:classType]) {
            atIndex = idx;
            *stop = YES;
            return;
        }
    }];
    
    return [self FTD_popSelectTabBarChildViewControllerAtIndex:atIndex];
}

- (void)FTD_popSelectTabBarChildViewControllerForClassType:(Class)classType
                                                completion:(FTDPopSelectTabBarChildViewControllerCompletion)completion {
    UIViewController *selectedTabBarChildViewController = [self FTD_popSelectTabBarChildViewControllerForClassType:classType];
    dispatch_async(dispatch_get_main_queue(), ^{
        !completion ?: completion(selectedTabBarChildViewController);
    });
}

- (void)checkTabBarChildControllerValidityAtIndex:(NSUInteger)index {
    ZHCustomTabBarController *tabBarController = [self ftd_tabBarController];
    @try {
        UIViewController *viewController;
        viewController = tabBarController.viewControllers[index];
    } @catch (NSException *exception) {
        NSString *formatString = @"\n\n\
        ------ BEGIN NSException Log ---------------------------------------------------------------------\n \
        class name: %@                                                                                    \n \
        ------line: %@                                                                                    \n \
        ----reason: 使用pop回去的方法不是ZHCustomTabBarController的item控制器 \n \
        ------ END ---------------------------------------------------------------------------------------\n\n";
        NSString *reason = [NSString stringWithFormat:formatString,
                            @(__PRETTY_FUNCTION__),
                            @(__LINE__)];
        @throw [NSException exceptionWithName:NSGenericException
                                       reason:reason
                                     userInfo:nil];
    }
}

@end
