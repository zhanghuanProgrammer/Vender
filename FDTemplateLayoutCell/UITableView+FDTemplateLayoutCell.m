
#import "UITableView+FDTemplateLayoutCell.h"
#import <objc/runtime.h>

@implementation UITableView (FDTemplateLayoutCell)

/**使用系统自动计算得到的高度*/
- (CGFloat)fd_systemFittingHeightForConfiguratedCell:(UITableViewCell *)cell {
    
    CGFloat contentViewWidth = CGRectGetWidth(self.frame);//拿到UITableView的宽度
    
    //先设置cell.bounds的宽度,这一招很好,提前设置cell.bounds的宽度,免得通过layout来设置
    CGRect cellBounds = cell.bounds;
    cellBounds.size.width = contentViewWidth;
    cell.bounds = cellBounds;
    
    //计算accessroyWidth,防止有些人用到accessoryView
    CGFloat accessroyWidth = 0;
    if (cell.accessoryView) {//如果是自定义的
        accessroyWidth = 16 + CGRectGetWidth(cell.accessoryView.frame);
    } else {//如果是系统的
        static const CGFloat systemAccessoryWidths[] = {
            [UITableViewCellAccessoryNone] = 0,
            [UITableViewCellAccessoryDisclosureIndicator] = 34,
            [UITableViewCellAccessoryDetailDisclosureButton] = 68,
            [UITableViewCellAccessoryCheckmark] = 40,
            [UITableViewCellAccessoryDetailButton] = 48
        };
        accessroyWidth = systemAccessoryWidths[cell.accessoryType];
    }
    contentViewWidth -= accessroyWidth;
    
    CGFloat fittingHeight = 0;
    
    //如果不是Frame布局
    if (!cell.isFrameLayout && contentViewWidth > 0) {
        
        NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];

        //判断系统的版本是否大于10.2
        static BOOL isSystemVersionEqualOrGreaterThen10_2 = NO;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            isSystemVersionEqualOrGreaterThen10_2 = [UIDevice.currentDevice.systemVersion compare:@"10.2" options:NSNumericSearch] != NSOrderedAscending;
        });
        
        //拿取到edgeConstraints
        NSArray<NSLayoutConstraint *> *edgeConstraints;
        if (isSystemVersionEqualOrGreaterThen10_2) {
            
            widthFenceConstraint.priority = UILayoutPriorityDefaultHigh - 1;
            
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeRight multiplier:1.0 constant:accessroyWidth];
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
            NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
            edgeConstraints = @[leftConstraint, rightConstraint, topConstraint, bottomConstraint];
            [cell addConstraints:edgeConstraints];
        }else{
            [cell.contentView addConstraint:widthFenceConstraint];
        }

        fittingHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
        //需要把临时加进来的约束全部清除掉,原来这里很会搞,相当于提前让cell Layout一下,然后计算高度,就是走系统需要走的步骤,然后又清除掉,因为系统会自己又再加一遍
        if (isSystemVersionEqualOrGreaterThen10_2) {
            [cell removeConstraints:edgeConstraints];
        }else{
            [cell.contentView removeConstraint:widthFenceConstraint];
        }
        
        [self fd_debugLog:[NSString stringWithFormat:@"使用系统自动计算得到的高度为 (AutoLayout) - %@", @(fittingHeight)]];
    }
    
    if (fittingHeight == 0) {
#if DEBUG
        if (cell.contentView.constraints.count > 0) {
            if (!objc_getAssociatedObject(self, _cmd)) {
                NSLog(@"你的约束可能有问题,请检查一下(最低端bottom约束是必须要添加的)");
                objc_setAssociatedObject(self, _cmd, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
#endif
        fittingHeight = [cell sizeThatFits:CGSizeMake(contentViewWidth, 0)].height;
        [self fd_debugLog:[NSString stringWithFormat:@"没办法,使用sizeThatFits来算下高度 - %@", @(fittingHeight)]];
    }
    
    if (fittingHeight == 0) {
        fittingHeight = 44;
    }
    
    if (self.separatorStyle != UITableViewCellSeparatorStyleNone) {
        fittingHeight += 1.0 / [UIScreen mainScreen].scale;
    }
    
    return fittingHeight;
}

/**根据Identifier拿到复用cell*/
- (__kindof UITableViewCell *)fd_templateCellForReuseIdentifier:(NSString *)identifier {
    NSAssert(identifier.length > 0, @"Expect a valid identifier - %@", identifier);
    
    NSMutableDictionary<NSString *, UITableViewCell *> *templateCellsByIdentifiers = objc_getAssociatedObject(self, _cmd);
    if (!templateCellsByIdentifiers) {
        templateCellsByIdentifiers = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, templateCellsByIdentifiers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    UITableViewCell *templateCell = templateCellsByIdentifiers[identifier];
    
    if (!templateCell) {
        templateCell = [self dequeueReusableCellWithIdentifier:identifier];
        NSAssert(templateCell != nil, @"Cell must be registered to table view for identifier - %@", identifier);
        templateCell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        templateCellsByIdentifiers[identifier] = templateCell;
        [self fd_debugLog:[NSString stringWithFormat:@"layout cell created - %@", identifier]];
    }
    
    return templateCell;
}

/**计算cell高度,但是不会保存计算结果,每次都计算*/
- (CGFloat)fd_heightForCellWithIdentifier:(NSString *)identifier configuration:(void (^)(id cell))configuration {
    if (!identifier) {
        return 0;
    }
    
    UITableViewCell *templateLayoutCell = [self fd_templateCellForReuseIdentifier:identifier];
    [templateLayoutCell prepareForReuse];
    
    if (configuration) {
        configuration(templateLayoutCell);
    }
    
    return [self fd_systemFittingHeightForConfiguratedCell:templateLayoutCell];
}

/**计算cell高度,会保存计算结果,根据IndexPath来记录高度*/
- (CGFloat)fd_heightForCellWithIdentifier:(NSString *)identifier cacheByIndexPath:(NSIndexPath *)indexPath configuration:(void (^)(id cell))configuration {
    if (!identifier || !indexPath) {
        return 0;
    }
    
    if ([self.fd_indexPathHeightCache existsHeightAtIndexPath:indexPath]) {
        [self fd_debugLog:[NSString stringWithFormat:@"hit cache by index path[%@:%@] - %@", @(indexPath.section), @(indexPath.row), @([self.fd_indexPathHeightCache heightForIndexPath:indexPath])]];
        return [self.fd_indexPathHeightCache heightForIndexPath:indexPath];
    }
    
    CGFloat height = [self fd_heightForCellWithIdentifier:identifier configuration:configuration];
    [self.fd_indexPathHeightCache cacheHeight:height byIndexPath:indexPath];
    [self fd_debugLog:[NSString stringWithFormat: @"cached by index path[%@:%@] - %@", @(indexPath.section), @(indexPath.row), @(height)]];
    
    return height;
}

/**计算cell高度,会保存计算结果,根据自定义的Key(一定是独一无二的)来记录高度*/
- (CGFloat)fd_heightForCellWithIdentifier:(NSString *)identifier cacheByKey:(id<NSCopying>)key configuration:(void (^)(id cell))configuration {
    if (!identifier || !key) {
        return 0;
    }
    
    if ([self.fd_keyedHeightCache existsHeightForKey:key]) {
        CGFloat cachedHeight = [self.fd_keyedHeightCache heightForKey:key];
        [self fd_debugLog:[NSString stringWithFormat:@"hit cache by key[%@] - %@", key, @(cachedHeight)]];
        return cachedHeight;
    }
    
    CGFloat height = [self fd_heightForCellWithIdentifier:identifier configuration:configuration];
    [self.fd_keyedHeightCache cacheHeight:height byKey:key];
    [self fd_debugLog:[NSString stringWithFormat:@"cached by key[%@] - %@", key, @(height)]];
    
    return height;
}

- (CGFloat)zh_heightForCellWithIdentifier:(NSString *)identifier configuration:(void (^)(id cell))configuration{
    if (!identifier) {
        return 0;
    }
    UITableViewCell *templateLayoutCell = [self fd_templateCellForReuseIdentifier:identifier];
    [templateLayoutCell prepareForReuse];
    
    if (configuration) {
        configuration(templateLayoutCell);
    }
    
    return [templateLayoutCell heightForCalculate];
}

- (CGFloat)zh_heightForCellWithIdentifier:(NSString *)identifier cacheByIndexPath:(NSIndexPath *)indexPath configuration:(void (^)(id cell))configuration{
    if (!identifier || !indexPath) {
        return 0;
    }
    
    if ([self.fd_indexPathHeightCache existsHeightAtIndexPath:indexPath]) {
        [self fd_debugLog:[NSString stringWithFormat:@"hit cache by index path[%@:%@] - %@", @(indexPath.section), @(indexPath.row), @([self.fd_indexPathHeightCache heightForIndexPath:indexPath])]];
        return [self.fd_indexPathHeightCache heightForIndexPath:indexPath];
    }
    
    CGFloat height = [self zh_heightForCellWithIdentifier:identifier configuration:configuration];
    [self.fd_indexPathHeightCache cacheHeight:height byIndexPath:indexPath];
    [self fd_debugLog:[NSString stringWithFormat: @"cached by index path[%@:%@] - %@", @(indexPath.section), @(indexPath.row), @(height)]];
    
    return height;
}

- (CGFloat)zh_heightForCellWithIdentifier:(NSString *)identifier cacheByKey:(id<NSCopying>)key configuration:(void (^)(id cell))configuration{
    if (!identifier || !key) {
        return 0;
    }
    
    if ([self.fd_keyedHeightCache existsHeightForKey:key]) {
        CGFloat cachedHeight = [self.fd_keyedHeightCache heightForKey:key];
        [self fd_debugLog:[NSString stringWithFormat:@"hit cache by key[%@] - %@", key, @(cachedHeight)]];
        return cachedHeight;
    }
    
    CGFloat height = [self zh_heightForCellWithIdentifier:identifier configuration:configuration];
    [self.fd_keyedHeightCache cacheHeight:height byKey:key];
    [self fd_debugLog:[NSString stringWithFormat:@"cached by key[%@] - %@", key, @(height)]];
    
    return height;
}

@end

@implementation UITableView (FDTemplateLayoutHeaderFooterView)

/**根据Identifier拿到复用HeaderFooterView*/
- (__kindof UITableViewHeaderFooterView *)fd_templateHeaderFooterViewForReuseIdentifier:(NSString *)identifier {
    NSAssert(identifier.length > 0, @"Expect a valid identifier - %@", identifier);
    
    NSMutableDictionary<NSString *, UITableViewHeaderFooterView *> *templateHeaderFooterViews = objc_getAssociatedObject(self, _cmd);
    if (!templateHeaderFooterViews) {
        templateHeaderFooterViews = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, templateHeaderFooterViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    UITableViewHeaderFooterView *templateHeaderFooterView = templateHeaderFooterViews[identifier];
    
    if (!templateHeaderFooterView) {
        templateHeaderFooterView = [self dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        NSAssert(templateHeaderFooterView != nil, @"HeaderFooterView must be registered to table view for identifier - %@", identifier);
        templateHeaderFooterView.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        templateHeaderFooterViews[identifier] = templateHeaderFooterView;
        [self fd_debugLog:[NSString stringWithFormat:@"layout header footer view created - %@", identifier]];
    }
    
    return templateHeaderFooterView;
}

/**计算HeaderFooterView高度*/
- (CGFloat)fd_heightForHeaderFooterViewWithIdentifier:(NSString *)identifier{
    UITableViewHeaderFooterView *templateHeaderFooterView = [self fd_templateHeaderFooterViewForReuseIdentifier:identifier];
    
    NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:templateHeaderFooterView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:CGRectGetWidth(self.frame)];
    [templateHeaderFooterView addConstraint:widthFenceConstraint];
    CGFloat fittingHeight = [templateHeaderFooterView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    [templateHeaderFooterView removeConstraint:widthFenceConstraint];
    
    if (fittingHeight == 0) {
        fittingHeight = [templateHeaderFooterView sizeThatFits:CGSizeMake(CGRectGetWidth(self.frame), 0)].height;
    }
    
    return fittingHeight;
}

@end

@implementation UITableViewCell (FDTemplateLayoutCell)

- (BOOL)recalculate{
    NSNumber *valueObject =objc_getAssociatedObject(self, @selector(recalculate));
    if ([valueObject respondsToSelector:@selector(boolValue)]) return valueObject.boolValue;
    return NO;
}

- (void)setRecalculate:(BOOL)recalculate {
    objc_setAssociatedObject(self, @selector(recalculate), @(recalculate), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isFrameLayout {
    NSNumber *valueObject =objc_getAssociatedObject(self, @selector(isFrameLayout));
    if ([valueObject respondsToSelector:@selector(boolValue)]) return valueObject.boolValue;
    return NO;
}

- (void)setIsFrameLayout:(BOOL)isFrameLayout {
    objc_setAssociatedObject(self, @selector(isFrameLayout), @(isFrameLayout), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)bottomOffset{
    NSNumber *valueObject =objc_getAssociatedObject(self, @selector(bottomOffset));
    if ([valueObject respondsToSelector:@selector(floatValue)]) return valueObject.floatValue;
    return 0.0;
}

- (void)setBottomOffset:(CGFloat)bottomOffset{
    objc_setAssociatedObject(self, @selector(bottomOffset), @(bottomOffset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)autoBottomOffset{
    NSNumber *valueObject =objc_getAssociatedObject(self, @selector(autoBottomOffset));
    if ([valueObject respondsToSelector:@selector(floatValue)]) return valueObject.floatValue;
    return 0.0;
}

- (void)setAutoBottomOffset:(CGFloat)autoBottomOffset{
    objc_setAssociatedObject(self, @selector(autoBottomOffset), @(autoBottomOffset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**遍历里面的控件,对其进行高度计算*/
- (CGFloat)heightForCalculate{
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGFloat rowHeight = 0.0;
    for (UIView *bottomView in self.contentView.subviews) {
        if (rowHeight < CGRectGetMaxY(bottomView.frame)) {
            rowHeight = CGRectGetMaxY(bottomView.frame);
        }
    }
    rowHeight += self.bottomOffset;
    
    if(self.autoBottomOffset){
        CGFloat topOffset=rowHeight;
        for (UIView *bottomView in self.contentView.subviews) {
            if (topOffset > CGRectGetMinY(bottomView.frame)) {
                topOffset = CGRectGetMinY(bottomView.frame);
            }
        }
        rowHeight += topOffset;
    }
    
    return rowHeight;
}

@end
