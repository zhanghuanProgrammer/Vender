
#import <UIKit/UIToolbar.h>

/**
 IQToolbar for IQKeyboardManager.
 */
@interface IQToolbar : UIToolbar <UIInputViewAudioFeedback>

/**
 Title font for toolbar.
 */
@property(nullable, nonatomic, strong) UIFont *titleFont;

/**
 Toolbar done title
 */
@property(nullable, nonatomic, strong) NSString *doneTitle;

/**
 Toolbar done image
 */
@property(nullable, nonatomic, strong) UIImage *doneImage;

/**
 Toolbar title
 */
@property(nullable, nonatomic, strong) NSString *title;

/**
 Optional target & action to behave toolbar title button as clickable button
 
 @param target Target object.
 @param action Target Selector.
 */
-(void)setTitleTarget:(nullable id)target action:(nullable SEL)action;

/**
 Customized Invocation to be called on title button action. titleInvocation is internally created using setTitleTarget:action: method.
 */
@property (nullable, strong, nonatomic) NSInvocation *titleInvocation;

@end

