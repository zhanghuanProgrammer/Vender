//
//  ZHCustomTabBar.h
//  FTDTabBarController
//
//  Created by ZH on 15/4/29.
//  Copyright © 2016年 ZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHCustomTabBar : UITabBar
/*!
 * 让 `SwappableImageView` 垂直居中时，所需要的默认偏移量。
 *  该值将在设置 top 和 bottom 时被同时使用，具体的操作等价于：
 * `viewController.tabBarItem.imageInsets = UIEdgeInsetsMake(swappableImageViewDefaultOffset, 0, -swappableImageViewDefaultOffset, 0);`
 */
@property (nonatomic, assign, readonly) CGFloat swappableImageViewDefaultOffset;
@end
