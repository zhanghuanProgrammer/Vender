
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

typedef void (^CurrentLocationCompletion)(CLLocationCoordinate2D coordinate);

typedef void (^CurrentCityCompletion)(NSString *city);

@interface ZHGetLocation : NSObject <CLLocationManagerDelegate>

+ (instancetype)sharedInstance;

@property (nonatomic, copy) NSString* cityName;

@property (nonatomic) CLLocationCoordinate2D locationCorrrdinate;

@property (nonatomic, copy) CurrentLocationCompletion didLocation;

@property (nonatomic, copy) CurrentCityCompletion cityLocation;

//启动位置信息获取
+ (void)start;

//停止位置信息获取
+ (void)stop;

@end
