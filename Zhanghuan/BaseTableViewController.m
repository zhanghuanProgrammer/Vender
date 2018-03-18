
#import "BaseTableViewController.h"

@interface BaseTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableDictionary *modelCells;
@property (nonatomic,strong)NSMutableDictionary *cellHeights;
@end

@implementation BaseTableViewController

- (NSMutableDictionary *)modelCells{
    return LazyLoadDictionaryM(_modelCells);
}
- (NSMutableDictionary *)cellHeights{
    return LazyLoadDictionaryM(_cellHeights);
}
- (NSMutableArray *)dataArr{
    return LazyLoadArrayM(_dataArr);
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (instancetype (^)(Class model,Class cell,CGFloat height))registModelAndCellAndHeight {
    return ^id(Class model,Class cell,CGFloat height) {
        [self.modelCells setValue:NSStringFromClass(cell) forKey:NSStringFromClass(model)];
        [self.cellHeights setValue:@(height) forKey:NSStringFromClass(model)];
        return self;
    };
}

#pragma mark - TableViewDelegate实现的方法:

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.isSection ? self.dataArr.count : 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.isSection ? [self.dataArr[section] count] : self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id modelObjct = self.dataArr[indexPath.row];
    for (NSString *cls in self.modelCells) {
        if ([modelObjct isKindOfClass:NSClassFromString(cls)]){
            NSString *cellCls = self.modelCells[cls];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellCls];
            //注意:这里不知道可能会被认为认为是热更新
            if ([cell respondsToSelector:NSSelectorFromString(@"refreshUI:")]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [cell performSelector:NSSelectorFromString(@"refreshUI:") withObject:modelObjct];
#pragma clang diagnostic pop
            }
            return cell;
        }
    }
    
    //随便给一个cell
    UITableViewCell *cell=[UITableViewCell new];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id modelObjct=self.dataArr[indexPath.row];
    for (NSString *cls in self.modelCells) {
        if ([modelObjct isKindOfClass:NSClassFromString(cls)]){
            CGFloat height = [self.cellHeights[cls] floatValue];
            return height;
        }
    }
    return 44.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

