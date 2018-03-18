
#import <UIKit/UIKit.h>
#import "UITableView+FDKeyedHeightCache.h"
#import "UITableView+FDIndexPathHeightCache.h"
#import "UITableView+FDTemplateLayoutCellDebug.h"

@interface UITableView (FDTemplateLayoutCell)

- (__kindof UITableViewCell *)fd_templateCellForReuseIdentifier:(NSString *)identifier;

- (CGFloat)fd_heightForCellWithIdentifier:(NSString *)identifier configuration:(void (^)(id cell))configuration;

- (CGFloat)fd_heightForCellWithIdentifier:(NSString *)identifier cacheByIndexPath:(NSIndexPath *)indexPath configuration:(void (^)(id cell))configuration;

- (CGFloat)fd_heightForCellWithIdentifier:(NSString *)identifier cacheByKey:(id<NSCopying>)key configuration:(void (^)(id cell))configuration;

- (CGFloat)zh_heightForCellWithIdentifier:(NSString *)identifier configuration:(void (^)(id cell))configuration;

- (CGFloat)zh_heightForCellWithIdentifier:(NSString *)identifier cacheByIndexPath:(NSIndexPath *)indexPath configuration:(void (^)(id cell))configuration;

- (CGFloat)zh_heightForCellWithIdentifier:(NSString *)identifier cacheByKey:(id<NSCopying>)key configuration:(void (^)(id cell))configuration;

@end

@interface UITableView (FDTemplateLayoutHeaderFooterView)

- (CGFloat)fd_heightForHeaderFooterViewWithIdentifier:(NSString *)identifier;

@end

@interface UITableViewCell (FDTemplateLayoutCell)

@property (nonatomic, assign) BOOL recalculate;//是否需要重新计算

@property (nonatomic, assign) BOOL isFrameLayout;//是否是Frame布局

@property (nonatomic, assign) CGFloat bottomOffset;//表示指定的lastViewInCell到cell的bottom的距离,可选设置的属性，默认为0

@property (nonatomic, assign) CGFloat autoBottomOffset;//是否需要底部边距自动等于顶部边距

- (CGFloat)heightForCalculate;

@end
