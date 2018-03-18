#import "UIImageView+ChainStyle.h"
@implementation UIImageView (ChainStyle)

- (UIImageView *(^)(UIImage *))mHighlightedimage {
	return ^id(UIImage * highlightedImage) {
		self.highlightedImage = highlightedImage;
		return self;
	};
}

- (UIImageView *(^)(NSArray *))mHighlightedanimationimages {
	return ^id(NSArray * highlightedAnimationImages) {
		self.highlightedAnimationImages = highlightedAnimationImages;
		return self;
	};
}

- (UIImageView *(^)(NSArray *))mAnimationimages {
	return ^id(NSArray * animationImages) {
		self.animationImages = animationImages;
		return self;
	};
}

- (UIImageView *(^)(NSTimeInterval))mAnimationduration {
	return ^id(NSTimeInterval animationDuration) {
		self.animationDuration = animationDuration;
		return self;
	};
}

- (UIImageView *(^)(id))mImage {
	return ^id(id image) {
        if ([image isKindOfClass:[UIImage class]]) {
            self.image = image;
        }
        if ([image isKindOfClass:[NSString class]]) {
            self.image = [UIImage imageNamed:image];
        }
		return self;
	};
}

- (UIImageView *(^)(BOOL))mHighlighted {
	return ^id(BOOL highlighted) {
		self.highlighted = highlighted;
		return self;
	};
}

- (UIImageView *(^)(NSInteger))mAnimationrepeatcount {
	return ^id(NSInteger animationRepeatCount) {
		self.animationRepeatCount = animationRepeatCount;
		return self;
	};
}

@end
