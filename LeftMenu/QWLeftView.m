
#import "QWLeftView.h"

@interface QWLeftView ()
@property (nonatomic, strong) UIView* contentView;
@property (nonatomic, strong) UIView* coverView;
@property (nonatomic, assign) CGFloat contentViewWidth;
@end

@implementation QWLeftView

- (instancetype)initWithContentView:(UIView *)contentView{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(-CurrentScreen_Width, 0, CurrentScreen_Width, CurrentScreen_Height);
        self.contentViewWidth = contentView.width;
        self.backgroundColor = [UIColor clearColor];
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentViewWidth, CurrentScreen_Height)];
        self.contentView.backgroundColor = [UIColor redColor];
        [self addSubview:self.contentView];
        [self.contentView addSubview:contentView];
        [self coverView];
        self.hidden = YES;
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}

#pragma mark - 内部方法
- (UIView*)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.contentView.frame), 0, self.contentViewWidth + CurrentScreen_Width, CurrentScreen_Height)];
        [self addSubview:_coverView];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0;

        _coverView.userInteractionEnabled = YES;

        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCover:)];
        [_coverView addGestureRecognizer:tap];

        UISwipeGestureRecognizer* swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeCover:)];
        swipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [_coverView addGestureRecognizer:swipe];
    }
    return _coverView;
}

- (void)show{
    self.hidden = NO;

    [UIView animateWithDuration:0.25
                     animations:^{
                         self.x = 0;
                     }
                     completion:^(BOOL finished){
                     }];

    //设置颜色渐变动画
    [self startCoverViewOpacityWithAlpha:0.5 withDuration:0.25];
}

- (void)hide:(BOOL)animation{
    [self cancelCoverViewOpacity];
    [UIView animateWithDuration:animation?0.25:0 animations:^{
        self.x = -CurrentScreen_Width;
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

#pragma mark - 手势操作
//点击蒙版
- (void)clickCover:(UITapGestureRecognizer*)tap{
    [self hide:YES];
}

//向左滑动蒙版
- (void)swipeCover:(UISwipeGestureRecognizer*)tap{
    [self hide:YES];
}

//点击头像或者账号
- (void)tapIcon:(UITapGestureRecognizer*)tap{
    [self hide:YES];
}

#pragma mark - 动画
- (void)startCoverViewOpacityWithAlpha:(CGFloat)alpha withDuration:(CGFloat)duration{
    CABasicAnimation* opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:alpha];
    opacityAnimation.duration = duration;
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    [_coverView.layer addAnimation:opacityAnimation forKey:@"opacity"];
    _coverView.alpha = alpha;
}

- (void)cancelCoverViewOpacity{
    [_coverView.layer removeAllAnimations];
    _coverView.alpha = 0;
}

@end
