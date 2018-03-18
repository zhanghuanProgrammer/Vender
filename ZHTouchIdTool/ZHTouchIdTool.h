#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

@interface ZHTouchIdTool : NSObject

/**
 *  TouchIdValidationFailureBack
 *
 *  @param result LAError枚举
 */
typedef void(^TouchIdValidationFailureBack)(LAError result);

+ (instancetype) sharedInstance;

/**
 *  TouchId 验证
 *
 *  @param localizedReason TouchId信息
 *  @param title           验证错误按钮title
 *  @param backSucces      成功返回Block
 *  @param backFailure     失败返回Block
 */
- (void)evaluatePolicy:(NSString *)localizedReason
         fallbackTitle:(NSString *)title
          SuccesResult:(void(^)(void))backSucces
         FailureResult:(TouchIdValidationFailureBack)backFailure;

@end
