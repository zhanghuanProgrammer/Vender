
#import <Foundation/NSArray.h>

/**
 UIView.subviews sorting category.
 */
@interface NSArray (IQ_NSArray_Sort)

///--------------
/// @name Sorting
///--------------

/**
 Returns the array by sorting the UIView's by their tag property.
 */
@property (nonatomic, readonly, copy) NSArray * _Nonnull sortedArrayByTag;

/**
 Returns the array by sorting the UIView's by their tag property.
 */
@property (nonatomic, readonly, copy) NSArray * _Nonnull sortedArrayByPosition;

@end
