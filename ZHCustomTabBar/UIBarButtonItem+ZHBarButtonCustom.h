//
//  UIBarButtonItem+ZHBarButtonCustom.h
//  FuTongDai
//
//  Created by ZH on 15/7/7.
//  Copyright © 2016年 OFIM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (FTDBarButtonCustom)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image selectImage:(NSString *)selectImage;

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image selectImage:(NSString *)selectImage title:(NSString *)title;


@end
