#import "NSArray+ZH.h"

@implementation NSArray (ZH)

/**移除相同的字符串*/
- (NSArray*)removeSameString:(NSArray*)arr{
    NSMutableArray* arrM = [NSMutableArray array];
    for (NSString* str in arr) {
        if ([arrM containsObject:str] == NO) {
            [arrM addObject:str];
        }
    }
    return arrM;
}

- (BOOL)haveSameString:(NSArray*)arr targetStr:(NSString*)targrtStr{
    NSInteger count = 0;
    for (NSString* tempStr in arr) {
        if ([tempStr isEqualToString:targrtStr]) {
            count++;
            if (count > 1) {
                return YES;
            }
        }
    }
    return NO;
}

/**去和另外一个数组(字符串)比较*/
- (CompareArray)compareToTextArr:(NSArray*)otherTextArr{

    NSArray* selfUniqueArr = [self removeSameString:self];
    NSArray* otherUniqueArr = [self removeSameString:otherTextArr];
    NSArray* maxLenArr = selfUniqueArr.count > otherUniqueArr.count ? selfUniqueArr : otherUniqueArr;
    NSArray* minLenArr;
    if (maxLenArr == selfUniqueArr)
        minLenArr = otherUniqueArr;
    else
        minLenArr = selfUniqueArr;
    NSArray* targetArr;
    NSMutableString* text = [NSMutableString stringWithString:@"-"];
    [text appendString:[maxLenArr componentsJoinedByString:@"-"]];
    [text appendString:@"-"];

    for (NSString* tempStr in minLenArr) {
        if ([text rangeOfString:[NSString stringWithFormat:@"-%@-", tempStr]].location == NSNotFound) {
            targetArr = minLenArr;
            break;
        }
    }
    if (targetArr == nil) {
        if (maxLenArr.count == minLenArr.count)
            return CompareArray_Same;
        else if (maxLenArr == selfUniqueArr)
            return CompareArray_PoriorLarge;
        return CompareArray_NextLarge;
    }
    return CompareArray_Different;
}

/**有多少行,通过给的行个数*/
- (NSUInteger)getRowWithRowCount:(NSUInteger)rowCount{
    NSInteger div = self.count / rowCount;
    NSInteger mod = self.count % rowCount;
    NSUInteger row = div + (mod > 0 ? 1 : 0);
    return row;
}

@end

