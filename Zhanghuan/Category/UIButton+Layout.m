//
//  UIButton+Layout.m
//  alertView
//
//  Created by TONY on 15/11/18.
//  Copyright © 2015年 tony. All rights reserved.
//

#import "UIButton+Layout.h"
#import <objc/runtime.h>

/// 获取UIEdgeInsets在水平方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}

CG_INLINE void
ReplaceMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}


@implementation UIButton (Layout)


/**
 title     :   text in button
 titleFont :   text's font
 image     :   image in button
 gap       :   gap between button and image
 layType   :   0:title---left ,image---right
 1:title---right ,image---left
 2:title---down ,image---up
 */

-(void)layoutButtonForGapBetween:(CGFloat)gap layType:(NSInteger)layType
{
    switch (layType) {
        case 0:
        {
            //title---left ,image---right
            CGFloat image_width = self.imageView.image.size.width;
//
            NSDictionary *attribute = @{NSFontAttributeName:self.titleLabel.font};
//
            CGSize titleSize = [self.titleLabel.text boundingRectWithSize:CGSizeMake(self.frame.size.width,MAXFLOAT)
                                                   options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
                                                attributes:attribute
                                                   context:nil].size;
            [self setImageEdgeInsets:UIEdgeInsetsMake(0,titleSize.width + gap + image_width + 10,0,0)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0,-gap-5,0,0)];
        }
            break;
        case 1:
        {
           //title---right ,image---left
            [self setImageEdgeInsets:UIEdgeInsetsMake(0,-gap/2,0,0)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0,gap/2,0,0)];
        }
            break;
        case 2:
        {
            //title---down ,image---up
            NSDictionary *attribute = @{NSFontAttributeName:self.titleLabel.font};
            
            CGSize titleSize = [self.titleLabel.text boundingRectWithSize:CGSizeMake(self.frame.size.width,MAXFLOAT)
                                                   options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
                                                attributes:attribute
                                                   context:nil].size;
            CGFloat title_origin_x = -self.imageView.image.size.width/2;
            CGFloat image_origin_x = titleSize.width/2;
            CGFloat image_origin_y = - (titleSize.height+gap)/2;
            CGFloat title_origin_y = (self.imageView.image.size.height+gap)/2;
            [self setImageEdgeInsets:UIEdgeInsetsMake(image_origin_y,image_origin_x,-image_origin_y,-image_origin_x)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(title_origin_y,title_origin_x,-title_origin_y,-title_origin_x)];
            
        }
            break;
        case 3:
        {
            //title---left ,image---right
            [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            CGFloat image_width = self.imageView.image.size.width;
            
            
            
            NSDictionary *attribute = @{NSFontAttributeName:self.titleLabel.font};
            
            CGSize titleSize = [self.titleLabel.text boundingRectWithSize:CGSizeMake(self.frame.size.width,MAXFLOAT)
                                                                  options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
                                                               attributes:attribute
                                                                  context:nil].size;
            
            CGFloat title_origin_x = (self.frame.size.width-image_width-gap-titleSize.width)/2 - image_width;
            CGFloat image_origin_x = title_origin_x + gap + titleSize.width+image_width;
            
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0,title_origin_x,0,0)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0,image_origin_x,0,0)];
        }
        default:
            break;
    }
  
}

@end

@implementation UILabel (Layout)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ReplaceMethod([self class], @selector(drawTextInRect:), @selector(yf_drawTextInRect:));
        ReplaceMethod([self class], @selector(sizeThatFits:), @selector(yf_sizeThatFits:));
    });
}

- (void)yf_drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = self.yf_contentInsets;
    [self yf_drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (CGSize)yf_sizeThatFits:(CGSize)size {
    UIEdgeInsets insets = self.yf_contentInsets;
    size = [self yf_sizeThatFits:CGSizeMake(size.width - UIEdgeInsetsGetHorizontalValue(insets), size.height-UIEdgeInsetsGetVerticalValue(insets))];
    size.width += UIEdgeInsetsGetHorizontalValue(insets);
    size.height += UIEdgeInsetsGetVerticalValue(insets);
    return size;
}

const void *kAssociatedYf_contentInsets;
- (void)setYf_contentInsets:(UIEdgeInsets)yf_contentInsets {
    objc_setAssociatedObject(self, &kAssociatedYf_contentInsets, [NSValue valueWithUIEdgeInsets:yf_contentInsets] , OBJC_ASSOCIATION_RETAIN);
}

- (UIEdgeInsets)yf_contentInsets {
    return [objc_getAssociatedObject(self, &kAssociatedYf_contentInsets) UIEdgeInsetsValue];
}

@end
