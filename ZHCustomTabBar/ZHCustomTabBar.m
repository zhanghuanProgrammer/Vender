//
//  ZHCustomTabBar.m
//  FTDTabBarController
//
//  Created by ZH on 15/4/29.
//  Copyright © 2016年 ZH. All rights reserved.
//

#import "ZHCustomTabBar.h"
#import "ZHCustomTabBarController.h"
#import "ZHCustomTabBarButton.h"

static void *const FTDCustomTabBarContext = (void*)&FTDCustomTabBarContext;

@interface ZHCustomTabBar ()
/**
 *  自定义按钮
 */
@property (nonatomic, strong) UIButton<FTDCustomTabBarButtonDelegate> *customButton;
/**
 *  tabBarItem宽度
 */
@property (nonatomic, assign) CGFloat tabBarItemWidth;
/**
 *  tabBar上button的数目
 */
@property (nonatomic, copy) NSArray *tabBarButtonArray;
@end

@implementation ZHCustomTabBar

#pragma mark -
#pragma mark - LifeCycle Method
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}

- (instancetype)sharedInit {
    if (FTDExternCustomButton) {
        self.customButton = FTDExternCustomButton;
        [self addSubview:(UIButton *)self.customButton];
    }
    // KVO注册监听
    _tabBarItemWidth = FTDTabBarItemWidth;
    [self addObserver:self forKeyPath:@"tabBarItemWidth" options:NSKeyValueObservingOptionNew context:FTDCustomTabBarContext];
    return self;
}

- (NSArray *)tabBarButtonArray {
    if (!_tabBarButtonArray) {
        NSArray *tabBarButtonArray = [[NSArray alloc] init];
        _tabBarButtonArray = tabBarButtonArray;
    }
    return _tabBarButtonArray;
}
- (void)dealloc {
    // 移除监听
    [self removeObserver:self forKeyPath:@"tabBarItemWidth"];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat barWidth = self.bounds.size.width;
    CGFloat barHeight = self.bounds.size.height;
    FTDTabBarItemWidth = (barWidth - FTDCustomButtonWidth) / FTDTabbarItemsCount;
    self.tabBarItemWidth = FTDTabBarItemWidth;
    if (!FTDExternCustomButton) {
        return;
    }
    
    CGFloat multiplerInCenterY = [self multiplerInCenterY];
    self.customButton.center = CGPointMake(barWidth * 0.5, barHeight * multiplerInCenterY);
    NSUInteger customButtonIndex = [self customButtonIndex];
    NSArray *sortedSubviews = [self sortedSubviews];
    self.tabBarButtonArray = [self tabBarButtonFromTabBarSubviews:sortedSubviews];
    [self setupSwappableImageViewDefaultOffset:self.tabBarButtonArray[0]];
    [self.tabBarButtonArray enumerateObjectsUsingBlock:^(UIView * _Nonnull childView, NSUInteger buttonIndex, BOOL * _Nonnull stop) {
        //调整UITabBarItem的位置
        CGFloat childViewX;
        if (buttonIndex >= customButtonIndex) {
            childViewX = buttonIndex * FTDTabBarItemWidth + FTDCustomButtonWidth;
        } else {
            childViewX = buttonIndex * FTDTabBarItemWidth;
        }
        //仅修改childView的x和宽度,yh值不变
        childView.frame = CGRectMake(childViewX,
                                     CGRectGetMinY(childView.frame),
                                     FTDTabBarItemWidth,
                                     CGRectGetHeight(childView.frame)
                                     );
    }];
    //让按钮移动到视图最顶端
    [self bringSubviewToFront:self.customButton];
}
- (void)setSwappableImageViewDefaultOffset:(CGFloat)swappableImageViewDefaultOffset {
    if (swappableImageViewDefaultOffset != 0.f) {
        [self willChangeValueForKey:@"swappableImageViewDefaultOffset"];
        _swappableImageViewDefaultOffset = swappableImageViewDefaultOffset;
        [self didChangeValueForKey:@"swappableImageViewDefaultOffset"];
    }
}
#pragma mark -
#pragma mark - KVO Method
// KVO监听执行
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if(context != FTDCustomTabBarContext) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    if(context == FTDCustomTabBarContext) {
        [[NSNotificationCenter defaultCenter] postNotificationName:FTDTabBarItemWidthDidChangeNotification object:self];
    }
}
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    return NO;
}
- (void)setTabBarItemWidth:(CGFloat )tabBarItemWidth {
    if (_tabBarItemWidth != tabBarItemWidth) {
        [self willChangeValueForKey:@"tabBarItemWidth"];
        _tabBarItemWidth = tabBarItemWidth;
        [self didChangeValueForKey:@"tabBarItemWidth"];
    }
}

#pragma mark -
#pragma mark - Private Methods
/**
 *  调整中间按钮位置
 *
 */
- (CGFloat)multiplerInCenterY
{
    CGFloat multiplerInCenterY;
    if ([[self.customButton class] respondsToSelector:@selector(multiplerInCenterY)]) {
        multiplerInCenterY = [[self.customButton class] multiplerInCenterY];
    } else {
        CGSize sizeOfPustomButton = self.customButton.frame.size;
        CGFloat heightDifference = sizeOfPustomButton.height - self.bounds.size.height;
        if (heightDifference < 0) {
            multiplerInCenterY = 0.5;
        } else {
            CGPoint center = CGPointMake(self.bounds.size.height * 0.5, self.bounds.size.height * 0.5);
            center.y = center.y - heightDifference * 0.5;
            multiplerInCenterY = center.y / self.bounds.size.height;
        }
    }
    return multiplerInCenterY;
}
/**
 *  获得自定义按钮的下标
 *
 *  @return
 */
- (NSUInteger)customButtonIndex
{
    NSUInteger customButtonIndex;
    if ([[self.customButton class] respondsToSelector:@selector(indexOfCustomButtonInTabBar)]) {
        customButtonIndex = [[self.customButton class] indexOfCustomButtonInTabBar];
        //仅修改self.customButton的x,ywh值不变
        self.customButton.frame = CGRectMake(customButtonIndex * FTDTabBarItemWidth,
                                             CGRectGetMinY(self.customButton.frame),
                                             CGRectGetWidth(self.customButton.frame),
                                             CGRectGetHeight(self.customButton.frame)
                                             );
    } else {
        if (FTDTabbarItemsCount % 2 != 0) {
            [NSException raise:@"ZHCustomTabBarController" format:@"如果ZHCustomTabBarController的个数奇数，必须在自定义的customButton中实现`+indexOfCustomButtonInTabBar`，来指定customButton的位置"];
        }
        customButtonIndex = FTDTabbarItemsCount * 0.5;
    }
    FTDCustomButtonIndex = customButtonIndex;
    return customButtonIndex;
}
/**
 *  调整子视图的位置
 *
 *  @return
 */
- (NSArray *)sortedSubviews {
    NSArray *sortedSubviews = [self.subviews sortedArrayUsingComparator:^NSComparisonResult(UIView * view1, UIView * view2) {
        CGFloat view1_x = view1.frame.origin.x;
        CGFloat view2_x = view2.frame.origin.x;
        if (view1_x > view2_x) {
            return NSOrderedDescending;
        } else {
            return NSOrderedAscending;
        }
    }];
    return sortedSubviews;
}
/**
 *  获得tabbar的子视图数组
 *
 */
- (NSArray *)tabBarButtonFromTabBarSubviews:(NSArray *)tabBarSubviews
{
    NSArray *tabBarButtonArray = [NSArray array];
    NSMutableArray *tabBarButtonMutableArray = [NSMutableArray arrayWithCapacity:tabBarSubviews.count - 1];
    [tabBarSubviews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonMutableArray addObject:obj];
        }
    }];
    if (FTDCustomChildViewController) {
        [tabBarButtonMutableArray removeObjectAtIndex:FTDCustomButtonIndex];
    }
    tabBarButtonArray = [tabBarButtonMutableArray copy];
    return tabBarButtonArray;
}
- (void)setupSwappableImageViewDefaultOffset:(UIView *)tabBarButton {
    __block BOOL shouldCustomizeImageView = YES;
    __block CGFloat swappableImageViewHeight = 0.f;
    __block CGFloat swappableImageViewDefaultOffset = 0.f;
    CGFloat tabBarHeight = self.frame.size.height;
    [tabBarButton.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UITabBarButtonLabel")]) {
            shouldCustomizeImageView = NO;
        }
        swappableImageViewHeight = obj.frame.size.height;
        BOOL isSwappableImageView = [obj isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")];
        if (isSwappableImageView) {
            swappableImageViewDefaultOffset = (tabBarHeight - swappableImageViewHeight) * 0.5 * 0.5;
        }
        if (isSwappableImageView && swappableImageViewDefaultOffset == 0.f) {
            shouldCustomizeImageView = NO;
        }

    }];
    if (shouldCustomizeImageView) {
        self.swappableImageViewDefaultOffset = swappableImageViewDefaultOffset;
    }
}
/**
 *  该方法可以让按钮超出父视图的部分也可以点击
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
//        UIView *result = [super hitTest:point withEvent:event];
//        if (result) {
//            return result;
//        } else {
//            for (UIView *subview in self.subviews.reverseObjectEnumerator) {
//                CGPoint subPoint = [subview convertPoint:point fromView:self];
//                result = [subview hitTest:subPoint withEvent:event];
//                if (result) {
//                    return result;
//                }
//            }
//        }
//    }
//    return nil;
    BOOL canNotResponseEvent = self.hidden || (self.alpha <= 0.01f) || (self.userInteractionEnabled == NO);
    if (canNotResponseEvent) {
        return nil;
    }
    if (!FTDExternCustomButton && ![self pointInside:point withEvent:event]) {
        return nil;
    }
    if (FTDExternCustomButton) {
        CGRect plusButtonFrame = self.customButton.frame;
        BOOL isInPlusButtonFrame = CGRectContainsPoint(plusButtonFrame, point);
        if (!isInPlusButtonFrame && (point.y < 0) ) {
            return nil;
        }
        if (isInPlusButtonFrame) {
            return FTDExternCustomButton;
        }
    }
    NSArray *tabBarButtons = self.tabBarButtonArray;
    if (self.tabBarButtonArray.count == 0) {
        tabBarButtons = [self tabBarButtonFromTabBarSubviews:self.subviews];
    }
    for (NSUInteger index = 0; index < tabBarButtons.count; index++) {
        UIView *selectedTabBarButton = tabBarButtons[index];
        CGRect selectedTabBarButtonFrame = selectedTabBarButton.frame;
        if (CGRectContainsPoint(selectedTabBarButtonFrame, point)) {
            return selectedTabBarButton;
        }
    }
    return nil;
}

@end
