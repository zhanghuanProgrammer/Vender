
#import "ZHDisplayViewController.h"

#import "ZHDisplayTitleLabel.h"

#import "ZHDisplayViewControllerConst.h"

@interface ZHDisplayViewController ()<UIScrollViewDelegate>

/** 标题滚动视图 */
@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, strong) NSMutableArray *titleLabels;
@property (nonatomic, strong) NSMutableArray *subTitleLabels;
@property (nonatomic, strong) NSMutableArray *badges;
@property (nonatomic, strong) NSMutableArray *titleWidths;
@property (nonatomic, weak) UIView *underLine;


// 记录上一次内容滚动视图偏移量
@property (nonatomic, assign) CGFloat lastOffsetX;

// 记录是否点击
@property (nonatomic, assign) BOOL isClickTitle;

// 记录是否在动画
@property (nonatomic, assign) BOOL isAniming;

// 标题间距
@property (nonatomic, assign) CGFloat titleMargin;

@end

@implementation ZHDisplayViewController

#pragma mark --- 懒加载
/**懒加载高*/
- (CGFloat)ZHScreenH{
    if (_ZHScreenH==0) {
        _ZHScreenH=[UIApplication sharedApplication].keyWindow.bounds.size.height;
    }
    return _ZHScreenH;
}
/**懒加载宽*/
- (CGFloat)ZHScreenW{
    if (_ZHScreenW==0) {
        _ZHScreenW=[UIApplication sharedApplication].keyWindow.bounds.size.width;
    }
    return _ZHScreenW;
}
/**懒加载数组*/
- (NSMutableArray *)titleWidths{
    if (_titleWidths == nil) {
        _titleWidths = [NSMutableArray array];
    }
    return _titleWidths;
}
- (NSMutableArray *)titleLabels{
    if (_titleLabels == nil) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}
- (NSMutableArray *)subTitleLabels{
    if (_subTitleLabels==nil) {
        _subTitleLabels=[NSMutableArray array];
    }
    return _subTitleLabels;
}
- (NSMutableArray *)subTitles{
    if (_subTitles==nil) {
        _subTitles=[NSMutableArray array];
    }
    return _subTitles;
}
- (NSMutableArray *)badges{
    if (!_badges) {
        _badges=[NSMutableArray array];
    }
    return _badges;
}
- (NSMutableArray *)badgeCounts{
    if (!_badgeCounts) {
        _badgeCounts=[NSMutableArray array];
    }
    return _badgeCounts;
}
/**懒加载字体*/
- (UIFont *)titleFont{
    if (!_titleFont) {
        _titleFont=[UIFont systemFontOfSize:15];
    }
    return _titleFont;
}
- (UIFont *)subTitleFont{
    if (!_subTitleFont) {
        _subTitleFont=[UIFont systemFontOfSize:14];
    }
    return _subTitleFont;
}
/**懒加载未选中文字颜色*/
- (UIColor *)norColor{
    if (_norColor == nil){
        _norColor = [UIColor blackColor];
    }
    
    return _norColor;
}
/**懒加载选中文字颜色*/
- (UIColor *)selColor{
    if (_selColor == nil) _selColor = [UIColor redColor];
    
    return _selColor;
}
/**懒加载下划线*/
- (UIView *)underLine{
    if (_underLine == nil) {
        
        UIView *underLineView = [[UIView alloc] init];
        
        underLineView.backgroundColor = _underLineColor?_underLineColor:[UIColor redColor];
        
        [self.titleScrollView addSubview:underLineView];
        
        _underLine = underLineView;
    }
    return _isShowUnderLine?_underLine : nil;
}





#pragma mark --- 初始化
/**初始化*/
- (void)setUp{
    if (_isfullScreen) {
        // 全屏展示
        _contentScrollView.frame = CGRectMake(0, 0, self.ZHScreenW, self.ZHScreenH);
    }
}


#pragma mark --- 生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.titleLabels.count) return;
    
    [self setUpTitleWidth];
    
    [self setUpAllTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}





#pragma mark --- 设置并计算
/**设置所有标题*/
- (void)setUpAllTitle{
    // 遍历所有的子控制器
    NSUInteger count = self.childViewControllers.count;
    
    // 添加所有的标题
    CGFloat labelW = 0;
    CGFloat labelH = ZHTitleScrollViewH;
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    
    for (int i = 0; i < count; i++) {
        
        UIViewController *vc = self.childViewControllers[i];
        
        UILabel *label = [[ZHDisplayTitleLabel alloc] init];
        label.textAlignment=NSTextAlignmentCenter;
        
        // 设置按钮的文字颜色
        label.textColor = self.norColor;
        label.font = self.titleFont;
        
        // 设置按钮标题
        label.text = vc.title;
        labelW = [self.titleWidths[i] floatValue];
        
        // 设置按钮位置
        UILabel *lastLabel = [self.titleLabels lastObject];
        if (i==0) labelX = _titleMargin/2.0 + CGRectGetMaxX(lastLabel.frame);
        else labelX = _titleMargin + CGRectGetMaxX(lastLabel.frame);
        
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        if (self.isShowSubTitle)//添加subTitlelLabel
        {
            CGFloat subLabelW = 0;
            CGFloat subLabelH = ZHTitleScrollViewH/2.0-10;
            CGFloat subLabelX = 0;
            CGFloat subLabelY = labelH-5;
            
            UILabel *subTitlelLabel = [[ZHDisplayTitleLabel alloc] init];
            subTitlelLabel.textAlignment=NSTextAlignmentCenter;
            
            // 设置按钮的文字颜色
            subTitlelLabel.textColor = self.norColor;
            subTitlelLabel.font = self.subTitleFont;
            
            // 设置按钮标题
            if (self.subTitles.count>i){
                subTitlelLabel.text = self.subTitles[i];
            }
            subLabelW = [self.titleWidths[i] floatValue];
            
            // 设置按钮位置
            UILabel *lastLabel = [self.subTitleLabels lastObject];
            if (i==0) subLabelX = _titleMargin/2.0 + CGRectGetMaxX(lastLabel.frame);
            else subLabelX = _titleMargin + CGRectGetMaxX(lastLabel.frame);
            
            subTitlelLabel.frame = CGRectMake(subLabelX, subLabelY, subLabelW, subLabelH);
            
            [self.subTitleLabels addObject:subTitlelLabel];
            [_titleScrollView addSubview:subTitlelLabel];
        }
        
        //添加徽标
        CGFloat badgeWidth=8;
        UILabel *badge=[[UILabel alloc]initWithFrame:CGRectMake(labelX+labelW-10, labelY+badgeWidth, badgeWidth, badgeWidth)];
        badge.backgroundColor=[UIColor redColor];
        [badge cornerRadiusWithFloat:badgeWidth/2.0];
        if (self.badgeCounts.count>i) {
            if ([self.badgeCounts[i] integerValue]>0)badge.hidden=NO;
            else badge.hidden=YES;
        }else{
            badge.hidden=YES;
        }
        
        // 监听标题的点击
        UIView *tapView=[[UIView alloc]initWithFrame:CGRectMake(label.x, label.y, label.width, self.titleHeight-ZHUnderLineH)];
        tapView.tag = i;
        [_titleScrollView addSubview:tapView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [tapView addGestureRecognizer:tap];
        
        // 保存到数组
        [self.titleLabels addObject:label];
        
        //加到titleScrollView
        [_titleScrollView addSubview:label];
        //加到titleScrollView
        [_titleScrollView addSubview:badge];
        
        [self.badges addObject:badge];
        
        //默认选中第一个
        if (i == 0) [self titleClick:tap];
    }
    
    // 设置标题滚动视图的内容范围
    UILabel *lastLabel = self.titleLabels.lastObject;
    _titleScrollView.contentSize = CGSizeMake(self.titleScrollFullWitdh?[UIScreen mainScreen].bounds.size.width:CGRectGetMaxX(lastLabel.frame)+_titleMargin/2.0, 0);
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _titleScrollView.backgroundColor = self.titleScrollViewColor;
    
    _contentScrollView.contentSize = CGSizeMake(count * self.ZHScreenW, 0);
    
}
/**设置所有控制器*/
- (void)setUpVc:(NSInteger)i{
    UIViewController *vc = self.childViewControllers[i];
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 9.0) { // iOS系统版本 >= 9.0
        if (vc.viewIfLoaded) return;//如果已经加载过了,就不要再加载了
    } else{ //iOS系统版本 < 9.0
        if([self.contentScrollView.subviews containsObject:vc.view])return;//如果已经加载过了,就不要再加载了
    }
    
    //设置frame
    vc.view.frame = CGRectMake(i*self.ZHScreenW, 0, self.contentScrollView.width, self.contentScrollView.height);
    //添加到ScrollView中
    [self.contentScrollView addSubview:vc.view];
    
    if (self.isNeedSetUpAllVC) {
        [self setUpAllVc];
    }
}
/**设置所有控制器并加载*/
- (void)setUpAllVc{
    for (NSInteger i=0; i<self.childViewControllers.count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        NSString *version = [UIDevice currentDevice].systemVersion;
        if (version.doubleValue >= 9.0) { // iOS系统版本 >= 9.0
            if (vc.viewIfLoaded) continue;//如果已经加载过了,就不要再加载了
        } else{ //iOS系统版本 < 9.0
            if([self.contentScrollView.subviews containsObject:vc.view])continue;//如果已经加载过了,就不要再加载了
        }
        //设置frame
        vc.view.frame = CGRectMake(i*self.ZHScreenW, 0, self.contentScrollView.width, self.contentScrollView.height);
        //添加到ScrollView中
        [self.contentScrollView addSubview:vc.view];
    }
}

/**设置下标的位置*/
- (void)setUpUnderLine:(UILabel *)label{
    // 获取文字尺寸
    CGRect titleBounds = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil];
    
    CGFloat width=titleBounds.size.width;
    
    if (self.needAverageTitleWidth) {
        width=self.averageTitleWidth;
    }
    
    CGFloat underLineH = _underLineH?_underLineH:ZHUnderLineH;
    
    if (self.isShowSubTitle) {
        self.underLine.y = self.titleHeight - underLineH;
    }else{
        self.underLine.y = label.height - underLineH;
    }
    self.underLine.height = underLineH;
    self.underLine.width = width-2*self.underLineIndexWidth;
    
    // 点击时候需要动画
    [UIView animateWithDuration:0.25 animations:^{
        self.underLine.x = label.x+self.underLineIndexWidth;
    }];
}
/**让选中的按钮居中显示*/
- (void)setLabelTitleCenter:(UILabel *)label{
    
    // 设置标题滚动区域的偏移量
    CGFloat offsetX = label.center.x - self.ZHScreenW * 0.5;
    
    if (offsetX < 0)offsetX = 0;
    
    // 计算下最大的标题视图滚动区域
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - self.ZHScreenW;
    
    if (maxOffsetX < 0) maxOffsetX = 0;
    
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    
    // 滚动区域
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}
/**计算标题宽度*/
- (void)setUpTitleWidth{
    // 判断是否能占据整个屏幕
    NSUInteger count = self.childViewControllers.count;
    
    NSArray *titles = [self.childViewControllers valueForKeyPath:@"title"];
    
    CGFloat totalWidth = 0;
    
    if (self.needAverageTitleWidth) {
        
        _titleMargin=0;
        
        if (titles.count<self.ZHScreenW) {
            self.averageTitleWidth=self.ZHScreenW/titles.count;
        }
        
        for (NSInteger i=0; i<titles.count; i++) {
            [self.titleWidths addObject:@(self.averageTitleWidth)];
        }
        return;
    }
    
    // 计算所有标题的宽度
    for (NSString *title in titles) {
        CGRect titleBounds = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil];
        
        CGFloat width = titleBounds.size.width;
        
        [self.titleWidths addObject:@(width)];
        
        totalWidth += width;
    }
    
    if (totalWidth > self.ZHScreenW) {
        _titleMargin = margin;
        return;
    }
    
    CGFloat titleMargin = (self.ZHScreenW - totalWidth) / (count + 1);
    
    _titleMargin = titleMargin < margin? margin: titleMargin;
}
/**设置标题滚动视图*/
- (void)setUpTitleScrollView{
    UIScrollView *titleScrollView = [[UIScrollView alloc] init];
    
    // 计算尺寸
    CGFloat y = self.navigationController?ZHNavBarH : 0;
    
    CGFloat titleH = _titleHeight>0?_titleHeight:ZHTitleScrollViewH;
    
    
    titleScrollView.frame = CGRectMake(-1, y-1,self.titleScrollFullWitdh?[UIScreen mainScreen].bounds.size.width: self.ZHScreenW+2, titleH+1);
    
    [self.view addSubview:titleScrollView];
    
    titleScrollView.bounces=NO;
    
    _titleScrollView = titleScrollView;

    //添加标题滚动视图底部线条
    [_titleScrollView cornerRadiusWithBorderColor:self.titleScrollViewSplitLineColor borderWidth:1];
}
/**设置内容滚动视图*/
- (void)setUpContentScrollView{
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    
    // 计算尺寸
    CGFloat y = CGRectGetMaxY(_titleScrollView.frame);
    
    CGFloat navigationBarTabBarSumHeight=0;
    if(self.navigationController.navigationBar!=nil)
        navigationBarTabBarSumHeight+=64;
    
    if (self.reduceContentViewHeight>0) {
        if (navigationBarTabBarSumHeight!=self.navigationBarTabBarSumHeight&&self.navigationBarTabBarSumHeight>0) {
            navigationBarTabBarSumHeight=self.navigationBarTabBarSumHeight;
        }
        contentScrollView.frame = CGRectMake(0, y, self.ZHScreenW, self.ZHScreenH-y-navigationBarTabBarSumHeight-self.reduceContentViewHeight);
    }else{
        contentScrollView.frame = CGRectMake(0, y, self.ZHScreenW, self.ZHScreenH-y-navigationBarTabBarSumHeight);
    }
    
    [self.view insertSubview:contentScrollView belowSubview:_titleScrollView];
    
    _contentScrollView = contentScrollView;
    
    _contentScrollView.delegate = self;
    
    // 设置内容滚动视图
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.bounces = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

/**设置标题滚动视图底部线条颜色*/
- (void)setTitleScrollViewSplitLineColor:(UIColor *)titleScrollViewSplitLineColor{
    _titleScrollViewSplitLineColor=titleScrollViewSplitLineColor;
}
/**设置标题颜色渐变*/
- (void)setUpTitleColorGradientWithOffset:(CGFloat)offsetX rightLabel:(ZHDisplayTitleLabel *)rightLabel leftLabel:(ZHDisplayTitleLabel *)leftLabel withIndex:(NSInteger)index{
    if (self.selectUseFontWeight) {
        return;
    }
    // 获取右边缩放
    CGFloat rightSacle = offsetX / self.ZHScreenW - index;
    
    // 获取移动距离
    CGFloat offsetDelta = offsetX - _lastOffsetX;
    
    if (offsetDelta > 0) { // 往右边
        
        rightLabel.fillColor = self.selColor;
        rightLabel.progress = rightSacle;
        
        leftLabel.fillColor = self.norColor;
        leftLabel.progress = rightSacle;
        
    }else if(offsetDelta < 0){ // 往左边
        
        rightLabel.textColor = self.norColor;
        rightLabel.fillColor = self.selColor;
        rightLabel.progress = rightSacle;
        
        leftLabel.textColor = self.selColor;
        leftLabel.fillColor = self.norColor;
        leftLabel.progress = rightSacle;
    }
}
- (void)cleanTitleColorGradient{
    for (ZHDisplayTitleLabel *label in self.titleLabels) {
        label.textColor = self.norColor;
        label.fillColor = self.norColor;
        label.progress = 0;
    }
}
/**设置子标题颜色渐变*/
- (void)setUpSubTitleColorGradientWithOffset:(CGFloat)offsetX rightLabel:(ZHDisplayTitleLabel *)rightLabel leftLabel:(ZHDisplayTitleLabel *)leftLabel withIndex:(NSInteger)index{
    if (self.selectUseFontWeight) {
        return;
    }
    // 获取右边缩放
    CGFloat rightSacle = offsetX / self.ZHScreenW - index;
    
    // 获取移动距离
    CGFloat offsetDelta = offsetX - _lastOffsetX;
    
    if (offsetDelta > 0) { // 往右边
        rightLabel.fillColor = self.selColor;
        rightLabel.progress = rightSacle;
        
        leftLabel.fillColor = self.norColor;
        leftLabel.progress = rightSacle;
        
    }else if(offsetDelta < 0){ // 往左边
        
        rightLabel.textColor = self.norColor;
        rightLabel.fillColor = self.selColor;
        rightLabel.progress = rightSacle;
        
        leftLabel.textColor = self.selColor;
        leftLabel.fillColor = self.norColor;
        leftLabel.progress = rightSacle;
    }
}
- (void)cleanSubTitleColorGradient{
    if (self.isShowSubTitle) {
        for (ZHDisplayTitleLabel *label in self.subTitleLabels) {
            label.textColor = self.norColor;
            label.fillColor = self.norColor;
            label.progress = 0;
        }
    }
}
/**设置下标偏移*/
- (void)setUpUnderLineOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel{
    if (_isClickTitle) return;
    
    if (rightLabel==nil) {
        self.underLine.x=leftLabel.x;
        return;
    }
    // 获取两个标题中心点距离
    CGFloat centerDelta = rightLabel.x - leftLabel.x;
    
    // 标题宽度差值
    CGFloat widthDelta = [self widthDeltaWithRightLabel:rightLabel leftLabel:leftLabel];
    
    // 获取移动距离
    CGFloat offsetDelta = offsetX - _lastOffsetX;
    
    // 计算当前下划线偏移量
    CGFloat underLineTransformX = offsetDelta * centerDelta / self.ZHScreenW;
    
    // 宽度递增偏移量
    CGFloat underLineWidth = offsetDelta * widthDelta / self.ZHScreenW;
    
    if (self.needAverageTitleWidth) {
        self.underLine.width = self.averageTitleWidth-self.underLineIndexWidth*2;
    }else
        self.underLine.width += underLineWidth;
    self.underLine.x += underLineTransformX;
}



#pragma mark - UIScrollViewDelegate 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 点击和动画的时候不需要设置
    if (_isAniming) return;
    
    // 获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 获取左边角标
    NSInteger leftIndex = offsetX / self.ZHScreenW;
    
    // 左边按钮
    ZHDisplayTitleLabel *leftLabel = self.titleLabels[leftIndex];
    
    // 右边角标
    NSInteger rightIndex = leftIndex + 1;
    
    // 右边按钮
    ZHDisplayTitleLabel *rightLabel = nil;
    
    if (rightIndex < self.titleLabels.count) {
        rightLabel = self.titleLabels[rightIndex];
    }
    
    if (_isClickTitle==NO) {
        // 设置下标偏移
        [self setUpUnderLineOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    }
    
    // 设置标题渐变
    [self setUpTitleColorGradientWithOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel withIndex:leftIndex];
    
    if (self.isShowSubTitle) {
        ZHDisplayTitleLabel *leftSubLabel = self.subTitleLabels[leftIndex];
        ZHDisplayTitleLabel *rightSubLabel = nil;
        if (rightIndex < self.subTitleLabels.count) {
            rightSubLabel = self.subTitleLabels[rightIndex];
        }
        // 设置子标题渐变
        [self setUpSubTitleColorGradientWithOffset:offsetX rightLabel:rightSubLabel leftLabel:leftSubLabel withIndex:leftIndex];
    }
    
    // 记录上一次的偏移量
    _lastOffsetX = offsetX;
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    _isAniming = NO;
    // 点击事件处理完成
    _isClickTitle = NO;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 获取角标
    NSInteger i = offsetX / self.ZHScreenW;
    
    // 添加控制器的view
    [self setUpVc:i];
    
    if (i>0) [self setUpVc:i-1];
    if (i<self.childViewControllers.count-1)[self setUpVc:i+1];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger offsetXInt = offsetX;
    NSInteger screenWInt = self.ZHScreenW;
    
    NSInteger extre = offsetXInt % screenWInt;
    if (extre > self.ZHScreenW * 0.5) {
        // 往右边移动
        offsetX = offsetX + (self.ZHScreenW - extre);
        _isAniming = YES;
        [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }else if (extre < self.ZHScreenW * 0.5 && extre > 0){
        _isAniming = YES;
        // 往左边移动
        offsetX =  offsetX - extre;
        [self.contentScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    
    // 获取角标
    NSInteger i = offsetX / self.ZHScreenW;
    
    // 选中标题
    [self selectLabelIndex:i];
    if (self.isShowSubTitle) {
        [self selectSubLabel:self.subTitleLabels[i]];
    }
    
    [self setUpVc:i];
}










#pragma mark  --- 事件响应函数
/**标题按钮点击*/
- (void)titleClick:(UITapGestureRecognizer *)tap
{
    
    NSInteger index=tap.view.tag;
    [self selectIndexVC:index];
}

- (void)selectIndexVC:(NSInteger)index{
    if (self.titleLabels.count<=index) {
        return;
    }
    
    // 记录是否点击标题
    _isClickTitle = YES;
    
    [self cleanTitleColorGradient];
    [self cleanSubTitleColorGradient];
    
    // 获取当前角标
    NSInteger i = index;
    if (self.titleLabels.count>i) {
        // 选中label
        [self selectLabelIndex:i];
    }
    
    if (self.isShowSubTitle) {
        [self selectSubLabel:self.subTitleLabels[i]];
    }
    
    // 内容滚动视图滚动到对应位置
    CGFloat offsetX = i * self.ZHScreenW;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.contentScrollView.contentOffset=CGPointMake(offsetX, 0);
    }completion:^(BOOL finished) {
        // 点击事件处理完成
        _isClickTitle = NO;
    }];
    
    // 记录上一次偏移量,因为点击的时候不会调用scrollView代理记录，因此需要主动记录
    _lastOffsetX = offsetX;
    
    // 添加对应的控制器view在对应位置上
    [self setUpVc:i];
}

- (void)selectLabelIndex:(NSInteger)index
{
    // 获取对应标题label
    UILabel *label = (UILabel *)self.titleLabels[index];
    
    for (UILabel *labelView in self.titleLabels) {
        
        labelView.transform = CGAffineTransformIdentity;
        labelView.textColor = self.norColor;
    }
    
    // 修改标题选中颜色
    label.textColor = self.selColor;
    // 设置标题居中
    [self setLabelTitleCenter:label];
    
    // 设置下标的位置
    [self setUpUnderLine:label];
    
    if (self.childViewControllers.count>index) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(ZHDisplayViewControllerSelectIndex:)]) {
            [self.delegate ZHDisplayViewControllerSelectIndex:index];
        }
    }
}
- (void)selectSubLabel:(UILabel *)label
{
    for (UILabel *labelView in self.subTitleLabels) {
        labelView.transform = CGAffineTransformIdentity;
        labelView.textColor = self.norColor;
    }
    
    // 修改标题选中颜色
    label.textColor = self.selColor;
}



#pragma mark  --- 辅助函数
/**获取两个按钮的宽度差值*/
- (CGFloat)widthDeltaWithRightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel{
    
    //求出右边按钮的CGRect(因为标题不一样,按钮的宽度就应该不一样)
    CGRect titleBoundsR = [rightLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil];
    
    //求出左边按钮的CGRect
    CGRect titleBoundsL = [leftLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil];
    
    //返回按钮的宽度差值
    return titleBoundsR.size.width - titleBoundsL.size.width;
}

/**更新界面*/
- (void)refreshDisplay{
    
    //设置高度
    if (self.isShowSubTitle) {
        //设置高度
        _titleHeight = ZHTitleScrollViewH*3/2.0;
    }else{
        _titleHeight = ZHTitleScrollViewH;
    }
    
    // 添加顶部标签滚动视图
    [self setUpTitleScrollView];
    
    // 添加底部内容滚动视图
    [self setUpContentScrollView];
    
    // 初始化
    [self setUp];
}

- (void)setBadgeCount:(NSInteger)count forIndex:(NSInteger)index animation:(BOOL)animation{
    
    CGFloat animationTime=0.25;
    if (!animation) {
        animationTime=0.0;
    }
    
    if (self.badges.count>index) {
        UILabel *badge=self.badges[index];
        if (count>0) {
            if (badge.hidden==NO)return;
            badge.alpha=0.0;
            [UIView animateWithDuration:animationTime animations:^{
                badge.alpha=1.0;
            }completion:^(BOOL finished) {
                badge.hidden=NO;
            }];
        }else if (count==0) {
            if (badge.hidden==YES)return;
            badge.alpha=1.0;
            [UIView animateWithDuration:animationTime animations:^{
                badge.alpha=0.0;
            }completion:^(BOOL finished) {
                badge.hidden=YES;
                badge.alpha=1.0;
            }];
        }
    }
}

- (void)setSubTitle:(NSString *)subTitle atIndex:(NSInteger)index{
    if (self.subTitles.count<=index) {
        for (NSInteger i=self.subTitles.count; i<=index; i++) {
            [self.subTitles addObject:@""];
        }
    }
    self.subTitles[index]=subTitle;
    if (self.subTitleLabels.count>index) {
        UILabel *subTitleLabel=self.subTitleLabels[index];
        subTitleLabel.text=subTitle;
    }
}

@end
