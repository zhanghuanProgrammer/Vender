
#import "ZFSettingViewController.h"

@interface ZFSettingViewController ()
@end

@implementation ZFSettingViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.第0组：3个
    [self add0SectionItems];
    
    // 2.第1组：6个
    [self add1SectionItems];
}

#pragma mark 添加第0组的模型数据
- (void)add0SectionItems
{
    // 1.1.推送和提醒
    ZFSettingItem *push = //[ZFSettingItem itemWithIcon:@"MorePush" title:@"新消息通知" type:ZFSettingItemTypeArrow];
    [ZFSettingItem itemWithIcon:@"MorePush" title:@"新消息通知" detail:@"新消息通知" type:ZFSettingItemTypeArrow];
    //cell点击事件
    push.operation = ^{
    };
    
    // 1.2.声音提示
    ZFSettingItem *shake =
    //[ZFSettingItem itemWithIcon:@"sound_Effect" title:@"声音提示" type:ZFSettingItemTypeSwitch];
    [ZFSettingItem itemWithIcon:@"sound_Effect" title:@"声音提示" subTitle:@"声音提示" type:ZFSettingItemTypeSwitch];
//    shake.subTitleFontSize = 8;
    //开关事件
    shake.switchBlock = ^(BOOL on) {
        NSLog(@"声音提示%zd",on);
    };
    
    ZFSettingGroup *group = [[ZFSettingGroup alloc] init];
    group.header = @"基本设置";
    group.items = @[push, shake];
    [_allGroups addObject:group];
}

#pragma mark 添加第1组的模型数据
- (void)add1SectionItems
{
    __weak typeof(self) weakSelf = self;
    // 帮助
    ZFSettingItem *help = [ZFSettingItem itemWithIcon:@"MoreHelp" title:@"帮助" type:ZFSettingItemTypeArrow];
    help.operation = ^{
        UIViewController *helpVC = [[UIViewController alloc] init];
        helpVC.view.backgroundColor = [UIColor grayColor];
        helpVC.title = @"帮助";
        [weakSelf.navigationController pushViewController:helpVC animated:YES];
    };
    
    // 分享
    ZFSettingItem *share = [ZFSettingItem itemWithIcon:@"MoreShare" title:@"分享" type:ZFSettingItemTypeArrow];
    share.operation = ^{
        UIViewController *helpVC = [[UIViewController alloc] init];
        helpVC.view.backgroundColor = [UIColor lightGrayColor];
        helpVC.title = @"分享";
        [weakSelf.navigationController pushViewController:helpVC animated:YES];
    };
    
    // 关于
    ZFSettingItem *about = [ZFSettingItem itemWithIcon:@"MoreAbout" title:@"关于" type:ZFSettingItemTypeArrow];
    about.operation = ^{
        UIViewController *helpVC = [[UIViewController alloc] init];
        helpVC.view.backgroundColor = [UIColor brownColor];
        helpVC.title = @"关于";
        [weakSelf.navigationController pushViewController:helpVC animated:YES];
    };
    
    ZFSettingGroup *group = [[ZFSettingGroup alloc] init];
    group.header = @"高级设置";
    group.footer = @"这是footer";
    group.items = @[ help, share , about];
    [_allGroups addObject:group];
}
@end
