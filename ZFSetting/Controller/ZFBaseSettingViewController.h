
#import <UIKit/UIKit.h>
#import "ZFSettingGroup.h"
#import "ZFSettingItem.h"

@interface ZFBaseSettingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_allGroups; // 所有的组模型
}
@end
