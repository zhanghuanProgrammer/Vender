#import "ZHTouchIdTool.h"

@implementation ZHTouchIdTool

+ (instancetype)sharedInstance
{
    static ZHTouchIdTool* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZHTouchIdTool alloc] init];
    });
    return instance;
}

- (void)evaluatePolicy:(NSString *)localizedReason
         fallbackTitle:(NSString *)title
          SuccesResult:(void(^)(void))backSucces
         FailureResult:(TouchIdValidationFailureBack)backFailure
{
    //初始化上下文对象
    LAContext* context = [[LAContext alloc] init];
    //错误对象
    NSError* error = nil;
    
    //首先使用canEvaluatePolicy 判断设备支持状态
   if ([context canEvaluatePolicy: LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]){
       //支持指纹验证
       [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication
               localizedReason:localizedReason
                         reply:
        ^(BOOL succes, NSError *error) {
            if (succes) {
                //验证成功，返回主线程处理
                NSLog(@"验证成功");
                dispatch_async(dispatch_get_main_queue(), ^{
                    backSucces();
                });
            } else {
                NSLog(@"验证失败");
                NSLog(@"%@",error.localizedDescription);
                dispatch_async(dispatch_get_main_queue(), ^{
                    backFailure(error.code);
                });
            }
        }];
   }else{
       NSLog(@"不支持指纹识别，LOG出错误详情");
       NSLog(@"%@",error.localizedDescription);
       dispatch_async(dispatch_get_main_queue(), ^{
           backFailure(error.code);
       });
   }
}

@end
