
#import "HcdGuideViewCell.h"
#import "HcdGuideView.h"

@interface HcdGuideViewCell()

@end

@implementation HcdGuideViewCell

- (instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.layer.masksToBounds = YES;
    self.imageView = [[UIImageView alloc]initWithFrame:kHcdGuideViewBounds];
    self.imageView.center = CGPointMake(kHcdGuideViewBounds.size.width / 2, kHcdGuideViewBounds.size.height / 2);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.hidden = YES;
    CGFloat  btnW=150;
    CGFloat  btnH=45;
    [button setFrame:CGRectMake(0, 0, btnW, btnH)];
    [button setTitle:@"立即体验" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.layer setCornerRadius:btnH*0.5];
    [button.layer setBorderColor:[UIColor grayColor].CGColor];
    [button.layer setBorderWidth:1.0f];
    [button setBackgroundColor:[UIColor whiteColor]];
    
    self.button = button;
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.button];
    
    [self.button setCenter:CGPointMake(kHcdGuideViewBounds.size.width / 2, kHcdGuideViewBounds.size.height - 100)];
    [self animate:YES];
    
    self.clickView=[[UIView alloc]initWithFrame:self.button.frame];
    [self.contentView addSubview:self.clickView];
    self.clickView.backgroundColor=[UIColor clearColor];
}

- (void)animate:(BOOL)isRevere{
    [UIView animateWithDuration:0.9 animations:^{
        if (isRevere) {
            self.button.alpha=0.6;
            [self.button setTransform:CGAffineTransformScale(self.button.transform, 0.9, 0.9)];
        }
        else{
            self.button.alpha=1;
            [self.button setTransform:CGAffineTransformIdentity];
        }
        
        [self.button setCenter:CGPointMake(kHcdGuideViewBounds.size.width / 2, kHcdGuideViewBounds.size.height - 100)];
        
    }completion:^(BOOL finished) {
        [self animate:!isRevere];
    }];
}

@end
