
#import "ZFSettingCell.h"
#import "ZFSettingItem.h"

@interface ZFSettingCell () {
    UISwitch* _switch;
}
@end

@implementation ZFSettingCell

+ (id)settingCellWithTableView:(UITableView*)tableView item:(ZFSettingItem *)item{
    // 0.用static修饰的局部变量，只会初始化一次
    static NSString* ID_Default = @"Cell_Default";
    static NSString* ID_Value1 = @"Cell_Value1";
    static NSString* ID_Subtitle = @"Cell_Subtitle";

    // 1.拿到一个标识先去缓存池中查找对应的Cell
    // 2.如果缓存池中没有，才需要传入一个标识创建新的Cell
    ZFSettingCell* cell = nil;
    if (item.subTitle && item.subTitle.length > 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:ID_Value1];
        if (cell == nil) {
            cell = [[ZFSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID_Value1];
        }
    }else if (item.detail && item.detail.length > 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:ID_Subtitle];
        if (cell == nil) {
            cell = [[ZFSettingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID_Subtitle];
        }
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:ID_Default];
        if (cell == nil) {
            cell = [[ZFSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID_Default];
        }
    }
    cell.item = item;
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (_item.subTitleFontSize > 0) {
        self.detailTextLabel.center = CGPointMake(self.detailTextLabel.center.x, self.textLabel.center.y);
    }
}

- (void)setItem:(ZFSettingItem*)item{
    _item = item;

    // 设置数据
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    if (item.titleFontSize > 0) {
        self.textLabel.font = [UIFont fontWithName:self.detailTextLabel.font.fontName size:item.titleFontSize];
    }
    if (item.titleColor) {
        self.textLabel.textColor = item.titleColor;
    }else{
        self.textLabel.textColor = [UIColor darkTextColor];
    }
    if (item.subTitle && item.subTitle.length > 0) {
        self.detailTextLabel.text = item.subTitle;
        if (item.subTitleFontSize > 0) {
            self.detailTextLabel.font = [UIFont fontWithName:self.detailTextLabel.font.fontName size:item.subTitleFontSize];
        }
        if (item.subTitleColor) {
            self.detailTextLabel.textColor = item.subTitleColor;
        }else{
            self.detailTextLabel.textColor = [UIColor grayColor];
        }
    }
    if (item.detail && item.detail.length > 0) {
        self.detailTextLabel.text = item.detail;
        if (item.detailFontSize > 0) {
            self.detailTextLabel.font = [UIFont fontWithName:self.detailTextLabel.font.fontName size:item.detailFontSize];
        }
        if (item.detailColor) {
            self.detailTextLabel.textColor = item.detailColor;
        }else{
            self.detailTextLabel.textColor = [UIColor grayColor];
        }
    }

    if (item.type == ZFSettingItemTypeArrow) {

        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleBlue;

    } else if (item.type == ZFSettingItemTypeSwitch) {

        if (_switch == nil) {
            _switch = [[UISwitch alloc] init];
            [_switch addTarget:self action:@selector(switchStatusChanged:) forControlEvents:UIControlEventValueChanged];
        }

        // 右边显示开关
        self.accessoryView = _switch;
        // 禁止选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    } else {

        // 什么也没有，清空右边显示的view
        self.accessoryView = nil;
        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
}

#pragma mark - SwitchValueChanged

- (void)switchStatusChanged:(UISwitch*)sender{
    if (self.switchChangeBlock) {
        self.switchChangeBlock(sender.on);
    }
}

@end
