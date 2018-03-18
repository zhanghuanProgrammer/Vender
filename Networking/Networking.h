
#import "AFNetworking.h"
#import <Foundation/Foundation.h>

@interface Networking : NSObject

+ (void)getWithUrl:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id json))success failure:(void (^)(NSError* error))failure;

+ (void)postWithUrl:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id json))success failure:(void (^)(NSError* error))failure;

/**System Get方法 不进行解析 可以获取html元素*/
+ (void)getStringWithUrl:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id json))success failure:(void (^)(NSError* error))failure;

+ (void)postPhotoUrl:(NSString*)url photoArray:(NSArray<UIImage*>*)photoArray parameters:(NSDictionary*)parameters success:(void (^)(id json))success failure:(void (^)(NSError* error))failure;

@end
