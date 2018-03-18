#import <UIKit/UIKit.h>
@interface UITextField (ChainStyle)

- (UITextField *(^)(UIImage * disabledBackground))mDisabledbackground;

- (UITextField *(^)(id delegate))mDelegate;

- (UITextField *(^)(BOOL clearsOnBeginEditing))mClearsonbeginediting;

- (UITextField *(^)(BOOL clearsOnInsertion))mClearsoninsertion;

- (UITextField *(^)(UIColor * textColor))mTextcolor;

- (UITextField *(^)(NSString * placeholder))mPlaceholder;

- (UITextField *(^)(BOOL allowsEditingTextAttributes))mAllowseditingtextattributes;

- (UITextField *(^)(CGFloat minimumFontSize))mMinimumfontsize;

- (UITextField *(^)(UIView * inputAccessoryView))mInputaccessoryview;

- (UITextField *(^)(NSTextAlignment textAlignment))mTextalignment;

- (UITextField *(^)(UIImage * background))mBackground;

- (UITextField *(^)(UITextFieldViewMode rightViewMode))mRightviewmode;

- (UITextField *(^)(BOOL adjustsFontSizeToFitWidth))mAdjustsfontsizetofitwidth;

- (UITextField *(^)(UITextFieldViewMode clearButtonMode))mClearbuttonmode;

- (UITextField *(^)(UIView * leftView))mLeftview;

- (UITextField *(^)(UITextFieldViewMode leftViewMode))mLeftviewmode;

- (UITextField *(^)(UIFont * font))mFont;

- (UITextField *(^)(NSDictionary * defaultTextAttributes))mDefaulttextattributes;

- (UITextField *(^)(NSDictionary * typingAttributes))mTypingattributes;

- (UITextField *(^)(UIView * inputView))mInputview;

- (UITextField *(^)(UITextBorderStyle borderStyle))mBorderstyle;

- (UITextField *(^)(NSString * text))mText;

- (UITextField *(^)(NSAttributedString * attributedPlaceholder))mAttributedplaceholder;

- (UITextField *(^)(NSAttributedString * attributedText))mAttributedtext;

- (UITextField *(^)(UIView * rightView))mRightview;

@end