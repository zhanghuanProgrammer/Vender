
#import <UIKit/UIKit.h>

@interface LSLHeadlineView : UIView

@property (strong, nonatomic) NSArray *images;

@property (assign, nonatomic, getter=isScrollDirectionPortrait) BOOL scrollDirectionPortrait;

@end
