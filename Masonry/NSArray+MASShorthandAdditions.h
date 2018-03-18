
#import "NSArray+MASAdditions.h"

#ifdef MAS_SHORTHAND

/**
 *	Shorthand array additions without the 'mas_' prefixes,
 *  only enabled if MAS_SHORTHAND is defined
 */
@interface NSArray (MASShorthandAdditions)

- (NSArray *)makeConstraints:(void(^)(MASConstraintMaker *make))block;

- (NSArray *)updateConstraints:(void(^)(MASConstraintMaker *make))block;

- (NSArray *)remakeConstraints:(void(^)(MASConstraintMaker *make))block;

@end

@implementation NSArray (MASShorthandAdditions)

- (NSArray *)makeConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_makeConstraints:block];

}

- (NSArray *)updateConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_updateConstraints:block];

}

- (NSArray *)remakeConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_remakeConstraints:block];

}

@end

#endif
