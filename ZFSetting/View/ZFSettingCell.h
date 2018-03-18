
#import <UIKit/UIKit.h>
@class ZFSettingItem;

@interface ZFSettingCell : UITableViewCell

@property (nonatomic, strong) ZFSettingItem* item;

/** switch状态改变的block*/
@property (copy, nonatomic) void (^switchChangeBlock)(BOOL on);

+ (id)settingCellWithTableView:(UITableView*)tableView item:(ZFSettingItem *)item;

@end
