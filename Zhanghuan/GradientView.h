
#import <UIKit/UIKit.h>

@interface GradientView : UIView

@property (nonatomic,assign)CGPoint startPoint;
@property (nonatomic,assign)CGPoint endPoint;

@property (nonatomic,strong)UIColor *startColor;
@property (nonatomic,strong)UIColor *endColor;

@end
