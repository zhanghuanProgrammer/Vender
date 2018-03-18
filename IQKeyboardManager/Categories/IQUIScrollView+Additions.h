
#import <UIKit/UIKit.h>

@interface UIScrollView (Additions)

/**
 Restore scrollViewContentOffset when resigning from scrollView. Default is NO.
 */
@property(nonatomic, assign) BOOL shouldRestoreScrollViewContentOffset;

@end
