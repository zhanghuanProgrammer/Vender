
#import <UIKit/UIKit.h>

@interface FDIndexPathHeightCache : NSObject

@property (nonatomic, assign) BOOL automaticallyInvalidateEnabled;

- (BOOL)existsHeightAtIndexPath:(NSIndexPath *)indexPath;

- (void)cacheHeight:(CGFloat)height byIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath;

- (void)invalidateHeightAtIndexPath:(NSIndexPath *)indexPath;

- (void)invalidateAllHeightCache;

@end

@interface UITableView (FDIndexPathHeightCache)
@property (nonatomic, strong, readonly) FDIndexPathHeightCache *fd_indexPathHeightCache;

@end

@interface UITableView (FDIndexPathHeightCacheInvalidation)
- (void)fd_reloadDataWithoutInvalidateIndexPathHeightCache;

@end
