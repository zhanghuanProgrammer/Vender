#import "StarRatingView.h"

@implementation StarRatingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat imageWidth=frame.size.width/5.0;
        CGFloat imageHeight=frame.size.height;
        for (NSInteger i = 0; i < 5; i++) {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.image = [UIImage imageNamed:@"star1"];
            imageView.tag = 1000+i;
            imageView.frame = CGRectMake(imageWidth*i, 0, imageWidth, imageHeight);
            [self addSubview:imageView];
        }
    }
    return self;
}

- (void)setCurStartValue:(CGFloat)value{
    
    for (NSInteger i = 0; i < (value+1)/2; i++) {
        UIImageView *image = (UIImageView *)[self viewWithTag:1000+i];
        image.image = [UIImage imageNamed:@"star3"];
        
        if ((NSInteger)value%2 == 1) {
            UIImageView *image = (UIImageView *)[self viewWithTag:1000+value/2];
            image.image = [UIImage imageNamed:@"star2"];
        }
    }
    
    for (NSInteger i = (value+1)/2; i < 5; i++) {
        UIImageView *iamge = (UIImageView *)[self viewWithTag:1000+i];
        iamge.image = [UIImage imageNamed:@"star1"];
    }
}
- (void)setStarValue:(CGFloat)starValue{
    starValue *=2;
    [self setCurStartValue:starValue];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //随着手的移动,移动到相应的位置
    //获取触摸对象
    UITouch *touch = [touches anyObject];
    //获取移动之后的坐标变化
    CGPoint newPoint = [touch locationInView:self];
    NSInteger temp = newPoint.x / 12+1;
    [self setCurStartValue:temp];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //获取触摸对象
    UITouch *touch = [touches anyObject];
    //获取移动之后的坐标变化
    CGPoint newPoint = [touch locationInView:self];
    NSInteger temp = newPoint.x / 12+1;
    [self setCurStartValue:temp];
}


@end
