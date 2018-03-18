
#import <UIKit/UIKit.h>
#import "TLCityPickerDelegate.h"

@interface TLCityPickerSearchResultController : UITableViewController <UISearchResultsUpdating>

@property (nonatomic, assign) id<TLSearchResultControllerDelegate>searchResultDelegate;

@property (nonatomic, strong) NSArray *cityData;

@end
