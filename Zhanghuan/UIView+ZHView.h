
#import <UIKit/UIKit.h>

@interface UIView (ZHView)

@property (assign, nonatomic) CGFloat x;

@property (assign, nonatomic) CGFloat y;

@property (assign, nonatomic) CGFloat width;

@property (assign, nonatomic) CGFloat height;

@property (assign, nonatomic) CGFloat right;

@property (assign, nonatomic) CGFloat bottom;

@property (assign, nonatomic) CGSize size;

@property (assign, nonatomic) CGPoint origin;

@property (assign, nonatomic) CGFloat centerX;

@property (assign, nonatomic) CGFloat centerY;

@property (assign, nonatomic, readonly) CGFloat minX;

@property (assign, nonatomic, readonly) CGFloat minY;

@property (assign, nonatomic, readonly) CGFloat maxX;

@property (assign, nonatomic, readonly) CGFloat maxY;

- (CGRect)frameInWindow;

/**给控件设置成圆角*/
- (void)cornerRadius;

- (void)cornerRadiusWithFloat:(CGFloat)vaule;

- (void)cornerRadiusWithBorderColor:(UIColor *)color borderWidth:(CGFloat)width;

- (void)cornerRadiusWithFloat:(CGFloat)vaule borderColor:(UIColor *)color borderWidth:(CGFloat)width;

/**判断两个控件是否重叠*/
- (BOOL)interSectionWithOtherView:(UIView *)otherView;

/**返回两个控件的交集的Frame*/
- (CGRect)getCGRectInterSectionWithOtherView:(UIView *)otherView;

/**为view添加点击手势*/
- (UITapGestureRecognizer *)addUITapGestureRecognizerWithTarget:(id)target withAction:(SEL)action;

/**为view添加捏合手势*/
- (UIPinchGestureRecognizer *)addUIPinchGestureRecognizerWithTarget:(id)target withAction:(SEL)action;

/**为view添加旋转手势*/
- (UIRotationGestureRecognizer *)addUIRotationGestureRecognizerWithTarget:(id)target withAction:(SEL)action;

/**为view添加拖动手势*/
- (UISwipeGestureRecognizer *)addUISwipeGestureRecognizerWithTarget:(id)target withAction:(SEL)action withDirection:(UISwipeGestureRecognizerDirection)direction;

/**为view添加旋转手势*/
- (UIPanGestureRecognizer *)addUIPanGestureRecognizerWithTarget:(id)target withAction:(SEL)action withMinimumNumberOfTouches:(NSUInteger)minimumNumberOfTouches withMaximumNumberOfTouches:(NSUInteger)maximumNumberOfTouches;

/**为view添加长按手势*/
- (UILongPressGestureRecognizer *)addUILongPressGestureRecognizerWithTarget:(id)target withAction:(SEL)action withMinimumPressDuration:(double)minimumPressDuration;

/**为View添加抛光效果*/
- (void)addPolishingWithBackColor:(UIColor *)color;

/**为View添加左右晃动的效果,类似于密码输入错误后的效果*/
- (void)addShakerWithDuration:(NSTimeInterval)duration;

/**获取ViewController*/
-(UIViewController *)getViewController;

/**添加毛玻璃效果*/
- (UIVisualEffectView *)addBlurEffectWithAlpha:(CGFloat)alpha;

/**添加阴影*/
- (void)addShadowWithShadowOffset:(CGSize)shadowOffset;
- (void)removeShadow;
- (void)addShadowWithShadowOffsetByAddView:(CGSize)shadowOffset;
- (void)removeShadowView;

- (void)rotationAnimationDuration:(CGFloat)duration;

- (void)rotationAnimationDuration:(CGFloat)duration repeatCount:(CGFloat)repeatCount;

- (void)rotationAnimationFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue duration:(CGFloat)duration;

- (NSLayoutConstraint *)getLayoutConstraint:(NSLayoutAttribute)attribute;

- (void)gradientStartColor:(UIColor *)startColor endColor:(UIColor *)endColor;
- (void)gradientStartColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
- (void)gradientStartColor:(UIColor *)startColor endColor:(UIColor *)endColor frame:(CGRect)frame;
- (void)gradientStartColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint frame:(CGRect)frame;

@end
