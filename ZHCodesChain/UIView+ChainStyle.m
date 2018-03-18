#import "UIView+ChainStyle.h"
@implementation UIView (ChainStyle)

- (UIView *(^)(BOOL))mOpaque {
	return ^id(BOOL opaque) {
		self.opaque = opaque;
		return self;
	};
}

- (UIView *(^)(UIView *))mMaskview {
	return ^id(UIView * maskView) {
		self.maskView = maskView;
		return self;
	};
}

- (UIView *(^)(CGRect))mFrame {
	return ^id(CGRect frame) {
		self.frame = frame;
		return self;
	};
}

- (UIView *(^)(BOOL))mHidden {
	return ^id(BOOL hidden) {
		self.hidden = hidden;
		return self;
	};
}

- (UIView *(^)(BOOL))mClipstobounds {
	return ^id(BOOL clipsToBounds) {
		self.clipsToBounds = clipsToBounds;
		return self;
	};
}

- (UIView *(^)(UIColor *))mBackgroundcolor {
	return ^id(UIColor * backgroundColor) {
		self.backgroundColor = backgroundColor;
		return self;
	};
}

- (UIView *(^)(NSArray *))mMotioneffects {
	return ^id(NSArray * motionEffects) {
		self.motionEffects = motionEffects;
		return self;
	};
}

- (UIView *(^)(CGAffineTransform))mTransform {
	return ^id(CGAffineTransform transform) {
		self.transform = transform;
		return self;
	};
}

- (UIView *(^)(NSInteger))mTag {
	return ^id(NSInteger tag) {
		self.tag = tag;
		return self;
	};
}

- (UIView *(^)(BOOL))mUserinteractionenabled {
	return ^id(BOOL userInteractionEnabled) {
		self.userInteractionEnabled = userInteractionEnabled;
		return self;
	};
}

- (UIView *(^)(CGRect))mBounds {
	return ^id(CGRect bounds) {
		self.bounds = bounds;
		return self;
	};
}

- (UIView *(^)(UIEdgeInsets))mLayoutmargins {
	return ^id(UIEdgeInsets layoutMargins) {
		self.layoutMargins = layoutMargins;
		return self;
	};
}

- (UIView *(^)(BOOL))mExclusivetouch {
	return ^id(BOOL exclusiveTouch) {
		self.exclusiveTouch = exclusiveTouch;
		return self;
	};
}

- (UIView *(^)(UIColor *))mTintcolor {
	return ^id(UIColor * tintColor) {
		self.tintColor = tintColor;
		return self;
	};
}

- (UIView *(^)(BOOL))mPreservessuperviewlayoutmargins {
	return ^id(BOOL preservesSuperviewLayoutMargins) {
		self.preservesSuperviewLayoutMargins = preservesSuperviewLayoutMargins;
		return self;
	};
}

- (UIView *(^)(BOOL))mClearscontextbeforedrawing {
	return ^id(BOOL clearsContextBeforeDrawing) {
		self.clearsContextBeforeDrawing = clearsContextBeforeDrawing;
		return self;
	};
}

- (UIView *(^)(UIViewContentMode))mContentmode {
	return ^id(UIViewContentMode contentMode) {
		self.contentMode = contentMode;
		return self;
	};
}

- (UIView *(^)(BOOL))mTranslatesautoresizingmaskintoconstraints {
	return ^id(BOOL translatesAutoresizingMaskIntoConstraints) {
		self.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints;
		return self;
	};
}

- (UIView *(^)(NSArray *))mGesturerecognizers {
	return ^id(NSArray * gestureRecognizers) {
		self.gestureRecognizers = gestureRecognizers;
		return self;
	};
}

- (UIView *(^)(UIViewTintAdjustmentMode))mTintadjustmentmode {
	return ^id(UIViewTintAdjustmentMode tintAdjustmentMode) {
		self.tintAdjustmentMode = tintAdjustmentMode;
		return self;
	};
}

- (UIView *(^)(BOOL))mMultipletouchenabled {
	return ^id(BOOL multipleTouchEnabled) {
		self.multipleTouchEnabled = multipleTouchEnabled;
		return self;
	};
}

- (UIView *(^)(UIViewAutoresizing))mAutoresizingmask {
	return ^id(UIViewAutoresizing autoresizingMask) {
		self.autoresizingMask = autoresizingMask;
		return self;
	};
}

- (UIView *(^)(CGFloat))mAlpha {
	return ^id(CGFloat alpha) {
		self.alpha = alpha;
		return self;
	};
}

- (UIView *(^)(CGPoint))mCenter {
	return ^id(CGPoint center) {
		self.center = center;
		return self;
	};
}

- (UIView *(^)(UISemanticContentAttribute))mSemanticcontentattribute {
	return ^id(UISemanticContentAttribute semanticContentAttribute) {
		self.semanticContentAttribute = semanticContentAttribute;
		return self;
	};
}

- (UIView *(^)(CGFloat))mContentscalefactor {
	return ^id(CGFloat contentScaleFactor) {
		self.contentScaleFactor = contentScaleFactor;
		return self;
	};
}

@end
