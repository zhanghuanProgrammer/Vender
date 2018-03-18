
#import "Networking.h"
#import "ZHJson.h"

@implementation Networking

+ (void)getWithUrl:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id))success failure:(void (^)(NSError*))failure{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];

    [manager GET:url
        parameters:parameters
        progress:^(NSProgress* _Nonnull downloadProgress) {

        }
        success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
            if (responseObject) {
                [[ZHJson new] saveCompressionJsonDic:responseObject toMac:url];
                success(responseObject);
            }
        }
        failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
            if (error) {
                failure(error);
            }
        }];
}

+ (void)postWithUrl:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id))success failure:(void (^)(NSError*))failure{

    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    [manager POST:url
        parameters:parameters
        progress:^(NSProgress* _Nonnull uploadProgress) {

        }
        success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
            if (responseObject) {
                [[ZHJson new] saveCompressionJsonDic:responseObject toMac:url];
                success(responseObject);
            }
        }
        failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
            if (error) {
                failure(error);
            }
        }];
}

+ (void)getStringWithUrl:(NSString*)url parameters:(NSDictionary*)parameters success:(void (^)(id))success failure:(void (^)(NSError*))failure{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url
        parameters:parameters
        progress:^(NSProgress* _Nonnull downloadProgress) {

        }
        success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
            if (responseObject) {
                [[ZHJson new] saveCompressionJsonDic:responseObject toMac:url];
                success(responseObject);
            }
        }
        failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
            if (error) {
                failure(error);
            }
        }];
}

+ (void)postPhotoUrl:(NSString*)url photoArray:(NSArray<UIImage*>*)photoArray parameters:(NSDictionary*)parameters success:(void (^)(id))success failure:(void (^)(NSError*))failure{

    if (photoArray.count == 0) {
        return;
    }
    // 向服务器提交图片
    //1.创建管理者对象
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    //2.上传文件
    [manager POST:url
        parameters:parameters
        constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
            for (int i = 0; i < photoArray.count; i++) {
                //压缩
                NSData* imageDtata = UIImagePNGRepresentation(photoArray[i]);
                NSDate* currentDate = [NSDate date]; //获取当前时间，日期
                NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:[NSString stringWithFormat:@"yyyyMMddHHmmss%zd", i]];
                NSString* uploadImage = [NSString stringWithFormat:@"%@.png", [dateFormatter stringFromDate:currentDate]];
                //上传文件参数
                [formData appendPartWithFileData:imageDtata name:@"file" fileName:uploadImage mimeType:@"image/jpeg"];
            }
        }
        progress:^(NSProgress* _Nonnull uploadProgress) {
            //打印上传进度
        }
        success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
            if (responseObject) {
                success(responseObject);
            }
        }
        failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
            if (error) {
                failure(error);
            }
        }];
}

@end

