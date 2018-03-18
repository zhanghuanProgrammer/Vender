
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataArr;

@property (nonatomic,assign)BOOL isSection;

- (instancetype (^)(Class model,Class cell,CGFloat height))registModelAndCellAndHeight;

@end

NS_ASSUME_NONNULL_END
