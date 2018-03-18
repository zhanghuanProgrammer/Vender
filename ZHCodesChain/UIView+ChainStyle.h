#import <UIKit/UIKit.h>
@interface UIView (ChainStyle)

- (UIView *(^)(BOOL opaque))mOpaque;

- (UIView *(^)(UIView * maskView))mMaskview;

- (UIView *(^)(CGRect frame))mFrame;

- (UIView *(^)(BOOL hidden))mHidden;

- (UIView *(^)(BOOL clipsToBounds))mClipstobounds;

- (UIView *(^)(UIColor * backgroundColor))mBackgroundcolor;

- (UIView *(^)(NSArray * motionEffects))mMotioneffects;

- (UIView *(^)(CGAffineTransform transform))mTransform;

- (UIView *(^)(NSInteger tag))mTag;

- (UIView *(^)(BOOL userInteractionEnabled))mUserinteractionenabled;

- (UIView *(^)(CGRect bounds))mBounds;

- (UIView *(^)(UIEdgeInsets layoutMargins))mLayoutmargins;

- (UIView *(^)(BOOL exclusiveTouch))mExclusivetouch;

- (UIView *(^)(UIColor * tintColor))mTintcolor;

- (UIView *(^)(BOOL preservesSuperviewLayoutMargins))mPreservessuperviewlayoutmargins;

- (UIView *(^)(BOOL clearsContextBeforeDrawing))mClearscontextbeforedrawing;

- (UIView *(^)(UIViewContentMode contentMode))mContentmode;

- (UIView *(^)(BOOL translatesAutoresizingMaskIntoConstraints))mTranslatesautoresizingmaskintoconstraints;

- (UIView *(^)(NSArray * gestureRecognizers))mGesturerecognizers;

- (UIView *(^)(UIViewTintAdjustmentMode tintAdjustmentMode))mTintadjustmentmode;

- (UIView *(^)(BOOL multipleTouchEnabled))mMultipletouchenabled;

- (UIView *(^)(UIViewAutoresizing autoresizingMask))mAutoresizingmask;

- (UIView *(^)(CGFloat alpha))mAlpha;

- (UIView *(^)(CGPoint center))mCenter;

- (UIView *(^)(UISemanticContentAttribute semanticContentAttribute))mSemanticcontentattribute;

- (UIView *(^)(CGFloat contentScaleFactor))mContentscalefactor;

@end
