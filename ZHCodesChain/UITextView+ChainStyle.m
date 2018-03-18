#import "UITextView+ChainStyle.h"
@implementation UITextView (ChainStyle)

- (UITextView *(^)(UIFont *))mFont {
	return ^id(UIFont * font) {
		self.font = font;
		return self;
	};
}

- (UITextView *(^)(BOOL))mClearsoninsertion {
	return ^id(BOOL clearsOnInsertion) {
		self.clearsOnInsertion = clearsOnInsertion;
		return self;
	};
}

- (UITextView *(^)(NSTextAlignment))mTextalignment {
	return ^id(NSTextAlignment textAlignment) {
		self.textAlignment = textAlignment;
		return self;
	};
}

- (UITextView *(^)(NSRange))mSelectedrange {
	return ^id(NSRange selectedRange) {
		self.selectedRange = selectedRange;
		return self;
	};
}

- (UITextView *(^)(BOOL))mEditable {
	return ^id(BOOL editable) {
		self.editable = editable;
		return self;
	};
}

- (UITextView *(^)(UIColor *))mTextcolor {
	return ^id(UIColor * textColor) {
		self.textColor = textColor;
		return self;
	};
}

- (UITextView *(^)(BOOL))mAllowseditingtextattributes {
	return ^id(BOOL allowsEditingTextAttributes) {
		self.allowsEditingTextAttributes = allowsEditingTextAttributes;
		return self;
	};
}

- (UITextView *(^)(NSDictionary *))mTypingattributes {
	return ^id(NSDictionary * typingAttributes) {
		self.typingAttributes = typingAttributes;
		return self;
	};
}

- (UITextView *(^)(BOOL))mSelectable {
	return ^id(BOOL selectable) {
		self.selectable = selectable;
		return self;
	};
}

- (UITextView *(^)(NSAttributedString *))mAttributedtext {
	return ^id(NSAttributedString * attributedText) {
		self.attributedText = attributedText;
		return self;
	};
}

- (UITextView *(^)(UIEdgeInsets))mTextcontainerinset {
	return ^id(UIEdgeInsets textContainerInset) {
		self.textContainerInset = textContainerInset;
		return self;
	};
}

- (UITextView *(^)(UIView *))mInputaccessoryview {
	return ^id(UIView * inputAccessoryView) {
		self.inputAccessoryView = inputAccessoryView;
		return self;
	};
}

- (UITextView *(^)(UIView *))mInputview {
	return ^id(UIView * inputView) {
		self.inputView = inputView;
		return self;
	};
}

- (UITextView *(^)(NSDictionary *))mLinktextattributes {
	return ^id(NSDictionary * linkTextAttributes) {
		self.linkTextAttributes = linkTextAttributes;
		return self;
	};
}

- (UITextView *(^)(UIDataDetectorTypes))mDatadetectortypes {
	return ^id(UIDataDetectorTypes dataDetectorTypes) {
		self.dataDetectorTypes = dataDetectorTypes;
		return self;
	};
}

- (UITextView *(^)(NSString *))mText {
	return ^id(NSString * text) {
		self.text = text;
		return self;
	};
}

@end