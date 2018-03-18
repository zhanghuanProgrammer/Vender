#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CompareArray) {
    CompareArray_Same = 0, //两个数组相等
    CompareArray_Different = -1, //两个数组不相等
    CompareArray_PoriorLarge = 1, //前面的数组包括后面的数组
    CompareArray_NextLarge = 2 //后面的数组包括前面的数组
};

@interface NSArray (ZH)

/**去和另外一个数组(字符串)比较*/
- (CompareArray)compareToTextArr:(NSArray*)otherTextArr;

/**有多少行,通过给的行个数*/
- (NSUInteger)getRowWithRowCount:(NSUInteger)rowCount;

@end
