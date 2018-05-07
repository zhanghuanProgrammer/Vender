
#import "ZHSlideSwitchView.h"
#import "UIButton+Layout.h"

//button间隔
static const CGFloat ButtonMargin = 10.0f;
//button标题正常大小
static const CGFloat ButtonFontNormalSize = 15.0f;
//button标题选中大小
static const CGFloat ButtonFontSelectedSize = 16.0f;
//顶部ScrollView高度
static const CGFloat TopScrollViewHeight = 48.0f;

@interface ZHSlideSwitchView ()<UIScrollViewDelegate>
{
    //阴影效果
    UIImageView *_shadowImageView;
    //按钮与下半部分的分割线
    UIView *_lineView;
    //存放按钮
    NSMutableArray *_buttons;
    NSMutableArray *_buttonsActionReal;
}
@end

@implementation ZHSlideSwitchView

#pragma mark -
#pragma mark 初始化方法

-(instancetype)init
{
    if (self = [super init]) {
        [self buildUI];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self buildUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    _buttons = [NSMutableArray new];
    _buttonsActionReal = [NSMutableArray new];
    _selectedIndex = 0;
    
    //防止navigationbar对ScrollView的布局产生影响
    [self addSubview:[UIView new]];
    
    //创建顶部ScrollView
    _topScrollView = [UIScrollView new];
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.backgroundColor = [UIColor whiteColor];
    _topScrollView.frame = CGRectMake(0, 0, self.width,TopScrollViewHeight);
    [self addSubview:_topScrollView];
    
    
    //创建分割线
    _lineView = [UIView new];
    _lineView.backgroundColor = [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:204.0f/255.0f alpha:1];
    _lineView.frame = CGRectMake(0, self.bounds.size.height-0.5, CurrentScreen_Width, 0.5);
    [self addSubview:_lineView];

    //创建阴影view
    _shadowImageView = [[UIImageView alloc] init];
    [_topScrollView addSubview:_shadowImageView];
    _shadowImageView.backgroundColor = self.underLineColor?:_btnSelectedColor;
}

#pragma mark -
#pragma mark LayoutSubViews

//更新View
-(void)layoutSubviews
{
    [super layoutSubviews];

    //上半部分
    [self updateButtons];

    //更新shadow的位置
    [self updateShadowView];
}

-(void)updateButtons
{
    CGFloat btnXOffset = ButtonMargin;
    for (NSInteger i = 0; i<_buttons.count; i++) {
        UIButton *button = _buttons[i];
        CGSize textSize = [self buttonSizeOfTitle:button.currentTitle];
        button.frame = CGRectMake(btnXOffset, 0, textSize.width, _topScrollView.bounds.size.height);
        UIButton *buttonReal = _buttonsActionReal[i];
        buttonReal.x = button.maxX;
        [button setTitleColor:_btnNormalColor forState:UIControlStateNormal];
        [button setTitleColor:_btnSelectedColor forState:UIControlStateSelected];
        btnXOffset += textSize.width + ButtonMargin;
        if (i == _selectedIndex) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:ButtonFontSelectedSize];
            button.selected = true;
        }else{
            button.titleLabel.font = [UIFont systemFontOfSize:ButtonFontNormalSize];
            button.selected = false;
        }
    }
    
    //如果需要平分宽度的话，重新设置范围
    if (_adjustBtnSize2Screen) {
        for (NSInteger i = 0; i<_buttons.count; i++) {
            UIButton *button = _buttons[i];
            CGFloat margin = 0.1*_topScrollView.bounds.size.width;
            float btnWidth = (_topScrollView.bounds.size.width - 2*margin)/_titles.count;
            [button setFrame:CGRectMake(i*btnWidth + margin, 0, btnWidth, TopScrollViewHeight)];
            UIButton *buttonReal = _buttonsActionReal[i];
            buttonReal.x = button.maxX;
        }
    }
    
    //更新顶部ScrollView的滚动范围
    UIButton *button = _buttons.lastObject;
    CGFloat conetntWidth = CGRectGetMaxX(button.frame) + ButtonMargin;
    _topScrollView.contentSize = CGSizeMake(conetntWidth, 0);
    if (conetntWidth < _topScrollView.width) {
        _topScrollView.centerX = self.width/2.0;
    }
}

-(void)updateShadowView
{
    //更新阴影的范围
    UIButton *button = _buttons[_selectedIndex];
    if (self.isUnderArrow) {
        _shadowImageView.frame = CGRectMake(button.centerX - 12.0/2, _topScrollView.height - 6,12,6);
        _shadowImageView.center = CGPointMake(button.center.x, _shadowImageView.center.y);
        _shadowImageView.backgroundColor = [UIColor clearColor];
        _shadowImageView.hidden = NO;
        _shadowImageView.image = [UIImage imageNamed:@"jttopwhite"];
    }else{
        CGFloat underLineHeight = self.underLineHeight>0?self.underLineHeight:1.5;
        _shadowImageView.frame = CGRectMake(button.frame.origin.x, CGRectGetMaxY(button.frame) - underLineHeight - 4,self.underLineWidth > 0 ? self.underLineWidth:button.bounds.size.width,underLineHeight);
        if (self.undercornerRadius>0) {
            [_shadowImageView cornerRadiusWithFloat:self.undercornerRadius];
        }
        _shadowImageView.center = CGPointMake(button.center.x, _shadowImageView.center.y);
        _shadowImageView.backgroundColor = self.underLineColor?:_btnSelectedColor;
        //shadow是否隐藏
        _shadowImageView.hidden = _hideShadow;
    }
}

- (void)setButtonImage:(NSString *)imageName index:(NSInteger)index target:(id)target action:(SEL)action{
    UIButton *button = _buttons[index];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button layoutButtonForGapBetween:5 layType:0];
   
    if (target&&action) {
        UIButton *clickAreaTarget = _buttonsActionReal[index];
        if(clickAreaTarget)[clickAreaTarget removeFromSuperview];
        UIButton *clickArea = [UIButton buttonWithType:(UIButtonTypeSystem)];
        clickArea.frame = CGRectMake(button.frameInWindow.origin.x, 0, 36, self.height);
        clickArea.backgroundColor = [UIColor clearColor];
        [clickArea addTarget:target action:action forControlEvents:1<<6];
        clickArea.tag = 989;
        _buttonsActionReal[index]=clickArea;
        [self addSubview:clickArea];
    }
}

#pragma mark -
#pragma mark Setter方法
- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    //添加buttons
    for (int i = 0; i < [titles count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:ButtonFontNormalSize];
        [button setTitleColor:self.btnSelectedColor forState:UIControlStateSelected];
        [button setTitleColor:self.btnNormalColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonSelectedMethod:) forControlEvents:UIControlEventTouchUpInside];
        [_topScrollView addSubview:button];
        [_buttons addObject:button];
        [_buttonsActionReal addObject:[UIButton buttonWithType:(UIButtonTypeSystem)]];
    }
}

//设置当前选中位置
-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    //更新frame
    [self updateUIWithSelectedIndex:selectedIndex byButton:true];
}

#pragma mark -
#pragma mark 视图逻辑方法
/**
 更新UI方法 如果是通过button点击造成的话则需要更新MainScrollView范围
 如果通过ScrollView滚动后更新UI则不需要更新MainScrollView的frame
 */
-(void)updateUIWithSelectedIndex:(NSInteger)index byButton:(BOOL)byButton
{
    _selectedIndex = index;
    //更新选中效果
    for (UIButton *button in _buttons) {
        if ([_buttons indexOfObject:button] == _selectedIndex) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:ButtonFontSelectedSize];
            button.selected = true;
        }else{
            button.titleLabel.font = [UIFont systemFontOfSize:ButtonFontNormalSize];
            button.selected = false;
        }
    }
    
    if ([_delegate respondsToSelector:@selector(slideSwitchDidselectTab:)]) {
        [_delegate slideSwitchDidselectTab:index];
    }
    
    [UIView animateWithDuration:0.35 animations:^{
        //更新TopScrollView的farme
        [self adjustTopScrollView:_buttons[index]];
        //更新shadow的frame
        [self updateShadowView];
    } completion:^(BOOL finished) {
        
    }];
}

//按钮点击方法
- (void)buttonSelectedMethod:(UIButton *)button
{
    [self updateUIWithSelectedIndex:[_buttons indexOfObject:button] byButton:true];
}

//是选中button显示在屏幕中间适配
- (void)adjustTopScrollView:(UIButton *)sender
{
    //如果是自动适配的话就不需要
    if (_adjustBtnSize2Screen == true) {return;}
    CGFloat targetX = CGRectGetMidX(sender.frame) - _topScrollView.bounds.size.width/2.0f;
    //左边缘适配
    if (targetX <=0) {
        targetX = 0;
    }
    //右边缘适配
    if (targetX >= _topScrollView.contentSize.width - _topScrollView.bounds.size.width) {
        targetX = _topScrollView.contentSize.width - _topScrollView.bounds.size.width;
    }
    [_topScrollView setContentOffset:CGPointMake(targetX, 0)];
}

#pragma mark -
#pragma mark 附加方法
/**
 按钮宽度
 */
-(CGSize)buttonSizeOfTitle:(NSString*)title
{
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByTruncatingTail];
    NSDictionary *attributes = @{ NSFontAttributeName : [UIFont boldSystemFontOfSize:ButtonFontSelectedSize], NSParagraphStyleAttributeName : style };
    CGSize textSize = [title boundingRectWithSize:CGSizeMake(_topScrollView.bounds.size.width, TopScrollViewHeight)
                                          options:opts
                                       attributes:attributes
                                          context:nil].size;
    return textSize;
}

@end
