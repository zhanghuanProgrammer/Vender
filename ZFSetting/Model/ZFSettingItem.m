
#import "ZFSettingItem.h"

@implementation ZFSettingItem

+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title type:(ZFSettingItemType)type{
    ZFSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.type = type;
    return item;
}

+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle type:(ZFSettingItemType)type{
    ZFSettingItem *item = [self itemWithIcon:icon title:title type:type];
    item.subTitle = subTitle;
    return item;
}

+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title detail:(NSString *)detail type:(ZFSettingItemType)type{
    ZFSettingItem *item = [self itemWithIcon:icon title:title type:type];
    item.detail = detail;
    return item;
}

@end
