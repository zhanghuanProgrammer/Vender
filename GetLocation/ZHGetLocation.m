
#import "ZHGetLocation.h"

static ZHGetLocation *sharedObject=nil;

@interface ZHGetLocation ()

@property (nonatomic, strong) CLLocationManager* locationManager;

@end

@implementation ZHGetLocation

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharedObject) {
            sharedObject = [ZHGetLocation new];
        }
    });
    return sharedObject;
}

- (CLLocationManager *)locationManager{
    if(!_locationManager){
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locationManager;
}

+ (void)start {
    [[ZHGetLocation sharedInstance] getLocationCoordinate];
}

+ (void)stop {
    [[ZHGetLocation sharedInstance].locationManager stopUpdatingLocation];
    [ZHGetLocation sharedInstance].locationManager = nil;
}

+ (BOOL)isEnabledLocation{
    if (IS_IOS(8)) {
        if(![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
            return NO;
        }
    }
    return YES;
}

- (void)getLocationCoordinate {
    
    if ([ZHGetLocation isEnabledLocation]) {
        
        _locationManager=[[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        if (IS_IOS(8)) {
            [_locationManager requestAlwaysAuthorization];
        }
        _locationManager.distanceFilter = 1000;
        [_locationManager startUpdatingLocation];
    }else{
        self.cityName = @"";
        if (self.cityLocation) {
            self.cityLocation(self.cityName);
        }
    }
}

#pragma mark - CoreLocation Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (locations.count>0) {
        CLLocation *newLocation = [locations lastObject];
        _locationCorrrdinate.latitude = newLocation.coordinate.latitude;
        _locationCorrrdinate.longitude = newLocation.coordinate.longitude;
        
        if(self.didLocation){
            self.didLocation(_locationCorrrdinate);
        }
        // 获取当前所在的城市名
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        //根据经纬度反向地理编译出地址信息
        [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
            if (array.count > 0){
                CLPlacemark *placemark = [array objectAtIndex:0];
                //获取城市
                NSString *city = placemark.locality;
                if (!city) {
                    //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                    city = placemark.administrativeArea;
                }
                self.cityName = city;
                if (self.cityName.length > 0 && [self.cityName hasSuffix:@"市"]) {
                    self.cityName = [self.cityName substringToIndex:city.length - 1];
                }
            }else if (error == nil && [array count] == 0){
                NSLog(@"经纬度反向地理编译 没有返回结果");
                self.cityName = @"";
            }else if (error != nil){
                NSLog(@"经纬度反向地理编译失败 = %@", error);
                self.cityName = @"";
            }
            if (self.cityLocation) {
                self.cityLocation(self.cityName);
            }
        }];
        
        //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
        [manager stopUpdatingLocation];
    }
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}

@end
