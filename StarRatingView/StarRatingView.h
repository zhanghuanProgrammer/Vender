
/*
 StarRatingView *tempAtar = [[StarRatingView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(starLeftLabel.frame), CGRectGetMaxY(UserTel.frame)+25+(20-starHeight)/2.0, starWidth*5,starHeight)];

 tempAtar.backgroundColor = [UIColor clearColor];

 tempAtar.userInteractionEnabled=NO;

 [view addSubview:tempAtar];

 [tempAtar setStarValue:0];

 */

#import <UIKit/UIKit.h>

@protocol StarRatingDelegate <NSObject>

- (void)sendGrade:(NSString *)grade;

@end

@interface StarRatingView : UIView

// 传递评星分数协议方法
@property(nonatomic, weak)id<StarRatingDelegate>delegate;

- (void)setStarValue:(CGFloat)starValue;

@end
