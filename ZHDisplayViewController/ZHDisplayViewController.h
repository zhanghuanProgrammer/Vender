
#import <UIKit/UIKit.h>

@class ZHDisplayViewController;

@protocol ZHDisplayViewControllerDelegate <NSObject>

- (void)ZHDisplayViewControllerSelectIndex:(NSInteger)index;

@end

@interface ZHDisplayViewController : UIViewController

@property (nonatomic, weak) UIScrollView *titleScrollView;

@property (nonatomic, assign) CGFloat ZHScreenW;

@property (nonatomic, assign) CGFloat ZHScreenH;

@property (nonatomic, assign) id<ZHDisplayViewControllerDelegate> delegate;

@property (nonatomic, assign) BOOL isfullScreen;

/**是否需要标题间隔平均*/
@property (nonatomic, assign) BOOL needAverageTitleWidth;
/**是否需要标题间隔平均*/
@property (nonatomic, assign) BOOL selectUseFontWeight;

/**一个屏幕宽度容纳多少个标题*/
@property (nonatomic, assign) CGFloat averageTitleWidth;

/**是否需要一次性加载所有控制器*/
@property (nonatomic, assign) BOOL isNeedSetUpAllVC;

/**下划线缩进多少(会乘以2)*/
@property (nonatomic, assign) CGFloat underLineIndexWidth;

/**控制器的内容减少高度*/
@property (nonatomic, assign) CGFloat reduceContentViewHeight;

@property (nonatomic, assign) CGFloat navigationBarTabBarSumHeight;

/*标题滚动视图背景颜色*/
@property (nonatomic, strong) UIColor* titleScrollViewColor;
@property (nonatomic,assign)BOOL titleScrollFullWitdh;

/*标题滚动视图底部线条颜色*/
@property (nonatomic, strong) UIColor* titleScrollViewSplitLineColor;

/*标题高度*/
@property (nonatomic, assign) CGFloat titleHeight;

/*正常标题颜色*/
@property (nonatomic, strong) UIColor* norColor;

/*选中标题颜色*/
@property (nonatomic, strong) UIColor* selColor;

/*标题字体*/
@property (nonatomic, strong) UIFont* titleFont;

/*子标题字体*/
@property (nonatomic, strong) UIFont* subTitleFont;

/*是否需要下标*/
@property (nonatomic, assign) BOOL isShowUnderLine;

/*是否需要下标*/
@property (nonatomic, assign) BOOL isShowSubTitle;

/*下标颜色*/
@property (nonatomic, strong) UIColor* underLineColor;

/*下标高度*/
@property (nonatomic, assign) CGFloat underLineH;

/**徽标*/
@property (nonatomic, strong) NSMutableArray* badgeCounts;

/**子标题*/
@property (nonatomic, strong) NSMutableArray* subTitles;

/*刷新标题和整个界面，在调用之前，必须先确定所有的子控制器*/

- (void)refreshDisplay;

- (void)setBadgeCount:(NSInteger)count forIndex:(NSInteger)index animation:(BOOL)animation;

- (void)setSubTitle:(NSString*)subTitle atIndex:(NSInteger)index;

- (void)selectIndexVC:(NSInteger)index;

@end
