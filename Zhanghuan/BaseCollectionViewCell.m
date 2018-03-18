//
//  BaseCollectionViewCell.m
//  猎球者界面
//
//  Created by mac on 2018/3/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import <objc/runtime.h>

@implementation BaseCollectionViewCell

- (id)dataModel:(id)dataModel valueForKey:(NSString *)key type:(NSString *)type{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL sel = NSSelectorFromString(key);
    if ([dataModel respondsToSelector:sel]) {
        return [dataModel performSelector:sel];
    }
    if ([key hasSuffix:type]) {
        sel = NSSelectorFromString([key substringToIndex:key.length - type.length]);
        if ([dataModel respondsToSelector:sel]) {
            return [dataModel performSelector:sel];
        }
    }
#pragma clang diagnostic pop
    return [NSNumber numberWithInteger:-9999];
}
- (BOOL)isExsit:(id)obj{
    if ([obj isKindOfClass:[NSNumber class]] && [obj integerValue] == -9999) return NO;
    return YES;
}
- (void)refreshUI:(id)dataModel{
    unsigned int count;
    Class cls = [self class];
    objc_property_t* properties = class_copyPropertyList(cls, &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString* key = [NSString stringWithUTF8String:property_getName(property)];
        id value = [self valueForKey:key];
        if (value) {
            if ([value isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView *)value;
                id image = [self dataModel:dataModel valueForKey:key type:@"ImageView"];
                if ([self isExsit:image]) imageView.mImage(image);
            }else if ([value isKindOfClass:[UILabel class]]) {
                UILabel *label = (UILabel *)value;
                id text = [self dataModel:dataModel valueForKey:key type:@"Label"];
                if ([self isExsit:text]) label.mText(text);
            }else if ([value isKindOfClass:[UITextView class]]) {
                UITextView *textView = (UITextView *)value;
                id text = [self dataModel:dataModel valueForKey:key type:@"TextView"];
                if ([self isExsit:text]) textView.mText(text);
            }else if ([value isKindOfClass:[UILabel class]]) {
                UITextField *textField = (UITextField *)value;
                id text = [self dataModel:dataModel valueForKey:key type:@"TextField"];
                if ([self isExsit:text]) textField.mText(text);
            }
        }
    }
    free(properties);
}

@end
