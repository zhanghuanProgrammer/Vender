#import <UIKit/UIKit.h>
@interface UITextView (ChainStyle)

- (UITextView *(^)(UIFont * font))mFont;

- (UITextView *(^)(BOOL clearsOnInsertion))mClearsoninsertion;

- (UITextView *(^)(NSTextAlignment textAlignment))mTextalignment;

- (UITextView *(^)(NSRange selectedRange))mSelectedrange;

- (UITextView *(^)(BOOL editable))mEditable;

- (UITextView *(^)(UIColor * textColor))mTextcolor;

- (UITextView *(^)(BOOL allowsEditingTextAttributes))mAllowseditingtextattributes;

- (UITextView *(^)(NSDictionary * typingAttributes))mTypingattributes;

- (UITextView *(^)(BOOL selectable))mSelectable;

- (UITextView *(^)(NSAttributedString * attributedText))mAttributedtext;

- (UITextView *(^)(UIEdgeInsets textContainerInset))mTextcontainerinset;

- (UITextView *(^)(UIView * inputAccessoryView))mInputaccessoryview;

- (UITextView *(^)(UIView * inputView))mInputview;

- (UITextView *(^)(NSDictionary * linkTextAttributes))mLinktextattributes;

- (UITextView *(^)(UIDataDetectorTypes dataDetectorTypes))mDatadetectortypes;

- (UITextView *(^)(NSString * text))mText;

@end