#import "UILabel+ChainStyle.h"
@implementation UILabel (ChainStyle)

- (UILabel *(^)(UIColor *))mHighlightedtextcolor {
	return ^id(UIColor * highlightedTextColor) {
		self.highlightedTextColor = highlightedTextColor;
		return self;
	};
}

- (UILabel *(^)(UIColor *))mShadowcolor {
	return ^id(UIColor * shadowColor) {
		self.shadowColor = shadowColor;
		return self;
	};
}

- (UILabel *(^)(CGFloat))mPreferredmaxlayoutwidth {
	return ^id(CGFloat preferredMaxLayoutWidth) {
		self.preferredMaxLayoutWidth = preferredMaxLayoutWidth;
		return self;
	};
}

- (UILabel *(^)(UIColor *))mTextcolor {
	return ^id(UIColor * textColor) {
		self.textColor = textColor;
		return self;
	};
}

- (UILabel *(^)(BOOL))mUserinteractionenabled {
	return ^id(BOOL userInteractionEnabled) {
		self.userInteractionEnabled = userInteractionEnabled;
		return self;
	};
}

- (UILabel *(^)(NSTextAlignment))mTextalignment {
	return ^id(NSTextAlignment textAlignment) {
		self.textAlignment = textAlignment;
		return self;
	};
}

- (UILabel *(^)(UIBaselineAdjustment))mBaselineadjustment {
	return ^id(UIBaselineAdjustment baselineAdjustment) {
		self.baselineAdjustment = baselineAdjustment;
		return self;
	};
}

- (UILabel *(^)(BOOL))mHighlighted {
	return ^id(BOOL highlighted) {
		self.highlighted = highlighted;
		return self;
	};
}

- (UILabel *(^)(BOOL))mAdjustsfontsizetofitwidth {
	return ^id(BOOL adjustsFontSizeToFitWidth) {
		self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth;
		return self;
	};
}

- (UILabel *(^)(NSLineBreakMode))mLinebreakmode {
	return ^id(NSLineBreakMode lineBreakMode) {
		self.lineBreakMode = lineBreakMode;
		return self;
	};
}

- (UILabel *(^)(UIFont *))mFont {
	return ^id(UIFont * font) {
		self.font = font;
		return self;
	};
}

- (UILabel *(^)(BOOL))mEnabled {
	return ^id(BOOL enabled) {
		self.enabled = enabled;
		return self;
	};
}

- (UILabel *(^)(NSString *))mText {
	return ^id(NSString * text) {
		self.text = text;
		return self;
	};
}

- (UILabel *(^)(CGFloat))mMinimumscalefactor {
	return ^id(CGFloat minimumScaleFactor) {
		self.minimumScaleFactor = minimumScaleFactor;
		return self;
	};
}

- (UILabel *(^)(NSAttributedString *))mAttributedtext {
	return ^id(NSAttributedString * attributedText) {
		self.attributedText = attributedText;
		return self;
	};
}

- (UILabel *(^)(CGSize))mShadowoffset {
	return ^id(CGSize shadowOffset) {
		self.shadowOffset = shadowOffset;
		return self;
	};
}

- (UILabel *(^)(NSInteger))mNumberoflines {
	return ^id(NSInteger numberOfLines) {
		self.numberOfLines = numberOfLines;
		return self;
	};
}

@end
