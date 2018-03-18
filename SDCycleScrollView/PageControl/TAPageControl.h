
#import <UIKit/UIKit.h>

@protocol TAPageControlDelegate;

@interface TAPageControl : UIControl

@property (nonatomic) Class dotViewClass;

@property (nonatomic) UIImage *dotImage;

@property (nonatomic) UIImage *currentDotImage;

@property (nonatomic) CGSize dotSize;

@property (nonatomic, strong) UIColor *dotColor;

@property (nonatomic) NSInteger spacingBetweenDots;

@property(nonatomic,assign) id<TAPageControlDelegate> delegate;

@property (nonatomic) NSInteger numberOfPages;

@property (nonatomic) NSInteger currentPage;

@property (nonatomic) BOOL hidesForSinglePage;

@property (nonatomic) BOOL shouldResizeFromCenter;

- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;

@end

@protocol TAPageControlDelegate <NSObject>

@optional
- (void)TAPageControl:(TAPageControl *)pageControl didSelectPageAtIndex:(NSInteger)index;

@end
