
#import <Foundation/Foundation.h>

@class RACSequence<__covariant ValueType>;

NS_ASSUME_NONNULL_BEGIN

@interface NSIndexSet (RACSequenceAdditions)

/// Creates and returns a sequence of indexes (as `NSNumber`s) corresponding to
/// the receiver.
///
/// Mutating the receiver will not affect the sequence after it's been created.
@property (nonatomic, copy, readonly) RACSequence<NSNumber *> *rac_sequence;

@end

NS_ASSUME_NONNULL_END
