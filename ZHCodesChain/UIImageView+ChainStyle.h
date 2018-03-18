#import <UIKit/UIKit.h>

@interface UIImageView (ChainStyle)

- (UIImageView *(^)(UIImage * highlightedImage))mHighlightedimage;

- (UIImageView *(^)(NSArray * highlightedAnimationImages))mHighlightedanimationimages;

- (UIImageView *(^)(NSArray * animationImages))mAnimationimages;

- (UIImageView *(^)(NSTimeInterval animationDuration))mAnimationduration;

- (UIImageView *(^)(id image))mImage;

- (UIImageView *(^)(BOOL highlighted))mHighlighted;

- (UIImageView *(^)(NSInteger animationRepeatCount))mAnimationrepeatcount;

@end
