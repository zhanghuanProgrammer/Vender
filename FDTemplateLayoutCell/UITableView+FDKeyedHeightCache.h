
#import <UIKit/UIKit.h>

@interface FDKeyedHeightCache : NSObject

- (BOOL)existsHeightForKey:(id<NSCopying>)key;

- (void)cacheHeight:(CGFloat)height byKey:(id<NSCopying>)key;

- (CGFloat)heightForKey:(id<NSCopying>)key;

- (void)invalidateHeightForKey:(id<NSCopying>)key;

- (void)invalidateAllHeightCache;

@end

@interface UITableView (FDKeyedHeightCache)

@property (nonatomic, strong, readonly) FDKeyedHeightCache *fd_keyedHeightCache;

@end
