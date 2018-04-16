//
//  UIButton+Layout.m
//  alertView
//
//  Created by TONY on 15/11/18.
//  Copyright © 2015年 tony. All rights reserved.
//

#import "UIButton+Layout.h"

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
