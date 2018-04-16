#import <Foundation/Foundation.h>

@interface KxMenuItem : NSObject

@property (readwrite, nonatomic, strong) UIImage *image;
@property (readwrite, nonatomic, strong) NSString *title;
@property (readwrite, nonatomic, weak) id target;
@property (readwrite, nonatomic) SEL action;
@property (readwrite, nonatomic, strong) UIColor *foreColor;
@property (readwrite, nonatomic) NSTextAlignment alignment;

+ (instancetype) menuItem:(NSString *) title
                    image:(UIImage *) image
                   target:(id)target
                   action:(SEL) action;

@end

@interface KxMenu : NSObject
@property (copy, nonatomic) void(^dismissBlock)(KxMenu *menu);
@property (nonatomic,assign)CGFloat cornerRadius;
@property (nonatomic,assign)CGFloat offsetX;
@property (nonatomic,assign)CGFloat defineWidth;
@property (nonatomic,assign)CGFloat defineHeight;
@property (nonatomic,assign)CGFloat itemHeight;
@property (nonatomic,assign)CGFloat itemWidth;
@property (nonatomic,assign)CGFloat itemCornerRadius;
@property (nonatomic, strong) UIColor *itemBgColor;
@property (nonatomic, strong) UIColor *selectTextColor;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic,assign)NSInteger curIndex;


+ (instancetype) sharedMenu;

+ (void)showMenuInView:(UIView *)view
               fromRect:(CGRect)rect
              menuItems:(NSArray *)menuItems;

+ (void)dismissMenu:(BOOL) animated;

+ (BOOL)isShowingInView:(UIView *)view;

+ (UIColor *) tintColor;
+ (void) setTintColor: (UIColor *) tintColor;

+ (UIColor *) lineColor;
+ (void) setLineColor: (UIColor *) lineColor;

+ (UIColor *) overlayColor;
+ (void) setOverlayColor: (UIColor *) overlayColor;

+ (UIFont *) titleFont;
+ (void) setTitleFont: (UIFont *) titleFont;

@end
