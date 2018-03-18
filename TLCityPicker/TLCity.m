
#import "TLCity.h"

@implementation TLCity

@end

#pragma mark - TLCityGroup
@implementation TLCityGroup

- (NSMutableArray *) arrayCitys
{
    if (_arrayCitys == nil) {
        _arrayCitys = [[NSMutableArray alloc] init];
    }
    return _arrayCitys;
}

@end
