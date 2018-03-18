
#import <UIKit/UIKit.h>

@interface SystemShare : NSObject

+ (void)shareFromVC:(UIViewController *)vc textToShare:(NSString *)textToShare imageToShare:(UIImage *)imageToShare urlToShare:(NSURL *)urlToShare completion:(void (^)(BOOL completed))completion;

@end
