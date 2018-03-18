
#import <UIKit/UIWindow.h>

@class UIViewController;

/**
 UIWindow hierarchy category.
 */
@interface UIWindow (IQ_UIWindow_Hierarchy)

///----------------------
/// @name viewControllers
///----------------------

/**
 Returns the current Top Most ViewController in hierarchy.
 */
@property (nullable, nonatomic, readonly, strong) UIViewController *topMostController;

/**
 Returns the topViewController in stack of topMostController.
 */
@property (nullable, nonatomic, readonly, strong) UIViewController *currentViewController;

@end
