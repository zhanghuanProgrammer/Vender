
#import <UIKit/UIKit.h>
#import "SnailImageLabel.h"

#define _rowCount   3   // 默认每行显示3个

@protocol SnailCurtainViewDelegate;

@interface SnailCurtainView : UIView

@property (nonatomic, weak) id <SnailCurtainViewDelegate> delegate;

@property (nonatomic, strong) NSArray<SnailImageLabelItem *> *items;

@property (nonatomic, strong) NSMutableArray<SnailImageLabel *> *itemViews;

@property (nonatomic, strong) UIButton *close;

@property (nonatomic, assign) CGSize itemSize;

@end

@protocol SnailCurtainViewDelegate <NSObject>
@optional
// 点击了关闭按钮
- (void)curtainViewDidClickClose:(UIButton *)close;

// 点击了每个item
- (void)curtainView:(SnailCurtainView *)curtainView didClickItemAtIndex:(NSInteger)index;

@end
