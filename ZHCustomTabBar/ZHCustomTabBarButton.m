//
//  ZHCustomTabBarButton.m
//  FTDTabBarController
//
//  Created by ZH on 15/4/29.
//  Copyright © 2016年 ZH. All rights reserved.
//

#import "ZHCustomTabBarButton.h"
#import "ZHCustomTabBarController.h"

CGFloat FTDCustomButtonWidth = 0.0f;
UIButton<FTDCustomTabBarButtonDelegate> *FTDExternCustomButton = nil;
UIViewController *FTDCustomChildViewController = nil;

@implementation ZHCustomTabBarButton

+ (void)registerSubclass
{
    if ([self conformsToProtocol:@protocol(FTDCustomTabBarButtonDelegate)]) {
        return;
    }
    Class<FTDCustomTabBarButtonDelegate> class = self;
    UIButton<FTDCustomTabBarButtonDelegate> *customButton = [class customButton];
    FTDExternCustomButton = customButton;
    FTDCustomButtonWidth = customButton.frame.size.width;
    if ([[self class] respondsToSelector:@selector(customChildViewController)]) {
        FTDCustomChildViewController = [class customChildViewController];
        [[self class] addSelectViewControllerTarget:customButton];
        if ([[self class] respondsToSelector:@selector(indexOfCustomButtonInTabBar)]) {
            FTDCustomButtonIndex = [[self class] indexOfCustomButtonInTabBar];
        } else {
            [NSException raise:@"ZHCustomTabBarController" format:@"如果想使用customChildViewController样式，必须同时在自定义的customButton中实现 `+indexOfCustomButtonInTabBar`，来指定customButton的位置"];
        }
    }

}
+ (void)addSelectViewControllerTarget:(UIButton<FTDCustomTabBarButtonDelegate> *)customButton {
    id target = self;
    NSArray<NSString *> *selectorNamesArray = [customButton actionsForTarget:target forControlEvent:UIControlEventTouchUpInside];
    if (selectorNamesArray.count == 0) {
        target = customButton;
        selectorNamesArray = [customButton actionsForTarget:target forControlEvent:UIControlEventTouchUpInside];
    }
    [selectorNamesArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SEL selector =  NSSelectorFromString(obj);
        [customButton removeTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }];
    [customButton addTarget:customButton action:@selector(customChildViewControllerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)customChildViewControllerButtonClicked:(UIButton<FTDCustomTabBarButtonDelegate> *)sender
{
    sender.selected = YES;
    [self ftd_tabBarController].selectedIndex = FTDCustomButtonIndex;
}
@end
