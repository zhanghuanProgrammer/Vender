#import <UIKit/UIKit.h>

@interface UILabel (ChainStyle)

- (UILabel *(^)(UIColor * highlightedTextColor))mHighlightedtextcolor;

- (UILabel *(^)(UIColor * shadowColor))mShadowcolor;

- (UILabel *(^)(CGFloat preferredMaxLayoutWidth))mPreferredmaxlayoutwidth;

- (UILabel *(^)(UIColor * textColor))mTextcolor;

- (UILabel *(^)(BOOL userInteractionEnabled))mUserinteractionenabled;

- (UILabel *(^)(NSTextAlignment textAlignment))mTextalignment;

- (UILabel *(^)(UIBaselineAdjustment baselineAdjustment))mBaselineadjustment;

- (UILabel *(^)(BOOL highlighted))mHighlighted;

- (UILabel *(^)(BOOL adjustsFontSizeToFitWidth))mAdjustsfontsizetofitwidth;

- (UILabel *(^)(NSLineBreakMode lineBreakMode))mLinebreakmode;

- (UILabel *(^)(UIFont * font))mFont;

- (UILabel *(^)(BOOL enabled))mEnabled;

- (UILabel *(^)(NSString * text))mText;

- (UILabel *(^)(CGFloat minimumScaleFactor))mMinimumscalefactor;

- (UILabel *(^)(BOOL allowsDefaultTighteningForTruncation))mAllowsdefaulttighteningfortruncation;

- (UILabel *(^)(NSAttributedString * attributedText))mAttributedtext;

- (UILabel *(^)(CGSize shadowOffset))mShadowoffset;

- (UILabel *(^)(NSInteger numberOfLines))mNumberoflines;

@end
