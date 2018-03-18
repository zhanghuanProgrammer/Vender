
#define kHcdGuideViewBounds [UIScreen mainScreen].bounds

#import <UIKit/UIKit.h>

static NSString *kCellIdentifier_HcdGuideViewCell = @"HcdGuideViewCell";

@interface HcdGuideViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UIView *clickView;

@end
