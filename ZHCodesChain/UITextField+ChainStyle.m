#import "UITextField+ChainStyle.h"
@implementation UITextField (ChainStyle)

- (UITextField *(^)(UIImage *))mDisabledbackground {
	return ^id(UIImage * disabledBackground) {
		self.disabledBackground = disabledBackground;
		return self;
	};
}

- (UITextField *(^)(id))mDelegate {
	return ^id(id delegate) {
		self.delegate = delegate;
		return self;
	};
}

- (UITextField *(^)(BOOL))mClearsonbeginediting {
	return ^id(BOOL clearsOnBeginEditing) {
		self.clearsOnBeginEditing = clearsOnBeginEditing;
		return self;
	};
}

- (UITextField *(^)(BOOL))mClearsoninsertion {
	return ^id(BOOL clearsOnInsertion) {
		self.clearsOnInsertion = clearsOnInsertion;
		return self;
	};
}

- (UITextField *(^)(UIColor *))mTextcolor {
	return ^id(UIColor * textColor) {
		self.textColor = textColor;
		return self;
	};
}

- (UITextField *(^)(NSString *))mPlaceholder {
	return ^id(NSString * placeholder) {
		self.placeholder = placeholder;
		return self;
	};
}

- (UITextField *(^)(BOOL))mAllowseditingtextattributes {
	return ^id(BOOL allowsEditingTextAttributes) {
		self.allowsEditingTextAttributes = allowsEditingTextAttributes;
		return self;
	};
}

- (UITextField *(^)(CGFloat))mMinimumfontsize {
	return ^id(CGFloat minimumFontSize) {
		self.minimumFontSize = minimumFontSize;
		return self;
	};
}

- (UITextField *(^)(UIView *))mInputaccessoryview {
	return ^id(UIView * inputAccessoryView) {
		self.inputAccessoryView = inputAccessoryView;
		return self;
	};
}

- (UITextField *(^)(NSTextAlignment))mTextalignment {
	return ^id(NSTextAlignment textAlignment) {
		self.textAlignment = textAlignment;
		return self;
	};
}

- (UITextField *(^)(UIImage *))mBackground {
	return ^id(UIImage * background) {
		self.background = background;
		return self;
	};
}

- (UITextField *(^)(UITextFieldViewMode))mRightviewmode {
	return ^id(UITextFieldViewMode rightViewMode) {
		self.rightViewMode = rightViewMode;
		return self;
	};
}

- (UITextField *(^)(BOOL))mAdjustsfontsizetofitwidth {
	return ^id(BOOL adjustsFontSizeToFitWidth) {
		self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth;
		return self;
	};
}

- (UITextField *(^)(UITextFieldViewMode))mClearbuttonmode {
	return ^id(UITextFieldViewMode clearButtonMode) {
		self.clearButtonMode = clearButtonMode;
		return self;
	};
}

- (UITextField *(^)(UIView *))mLeftview {
	return ^id(UIView * leftView) {
		self.leftView = leftView;
		return self;
	};
}

- (UITextField *(^)(UITextFieldViewMode))mLeftviewmode {
	return ^id(UITextFieldViewMode leftViewMode) {
		self.leftViewMode = leftViewMode;
		return self;
	};
}

- (UITextField *(^)(UIFont *))mFont {
	return ^id(UIFont * font) {
		self.font = font;
		return self;
	};
}

- (UITextField *(^)(NSDictionary *))mDefaulttextattributes {
	return ^id(NSDictionary * defaultTextAttributes) {
		self.defaultTextAttributes = defaultTextAttributes;
		return self;
	};
}

- (UITextField *(^)(NSDictionary *))mTypingattributes {
	return ^id(NSDictionary * typingAttributes) {
		self.typingAttributes = typingAttributes;
		return self;
	};
}

- (UITextField *(^)(UIView *))mInputview {
	return ^id(UIView * inputView) {
		self.inputView = inputView;
		return self;
	};
}

- (UITextField *(^)(UITextBorderStyle))mBorderstyle {
	return ^id(UITextBorderStyle borderStyle) {
		self.borderStyle = borderStyle;
		return self;
	};
}

- (UITextField *(^)(NSString *))mText {
	return ^id(NSString * text) {
		self.text = text;
		return self;
	};
}

- (UITextField *(^)(NSAttributedString *))mAttributedplaceholder {
	return ^id(NSAttributedString * attributedPlaceholder) {
		self.attributedPlaceholder = attributedPlaceholder;
		return self;
	};
}

- (UITextField *(^)(NSAttributedString *))mAttributedtext {
	return ^id(NSAttributedString * attributedText) {
		self.attributedText = attributedText;
		return self;
	};
}

- (UITextField *(^)(UIView *))mRightview {
	return ^id(UIView * rightView) {
		self.rightView = rightView;
		return self;
	};
}

@end