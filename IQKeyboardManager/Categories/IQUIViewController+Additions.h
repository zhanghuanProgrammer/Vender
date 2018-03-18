
#import <UIKit/UIKit.h>

@interface UIViewController (Additions)

/**
 Top/Bottom Layout constraint which help library to manage keyboardTextField distance
 */
@property(nullable, nonatomic, strong) IBOutlet NSLayoutConstraint *IQLayoutGuideConstraint;

@end
