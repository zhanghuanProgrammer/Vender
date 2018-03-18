
#import "LSLHotView.h"

@interface LSLHotView ()

@property (weak, nonatomic) IBOutlet UIImageView *labaImagesView;
@property (weak, nonatomic) IBOutlet UILabel *FirstLabel;

@end

@implementation LSLHotView

+ (instancetype)lslHotView {
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.FirstLabel.numberOfLines=2;
    self.FirstLabel.font=[UIFont systemFontOfSize:12];
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    self.FirstLabel.text=dic[@"content"];
}


@end
