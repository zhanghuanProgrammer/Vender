
#import <Foundation/Foundation.h>

@interface NSObject (SimulationDataMap)

/**生成随机模型的数据*/
- (instancetype)simulationData;
- (NSString *)creatCodeForSimulationDataMap;
+ (id)valueForModel:(NSString*)model name:(NSString*)name;

@end

