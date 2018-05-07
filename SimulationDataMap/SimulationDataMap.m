
#import "SimulationDataMap.h"
#import <objc/runtime.h>

@interface SimulationDataMap : NSObject

@property (nonatomic, strong) NSMutableDictionary* shortMap;

@end

@implementation SimulationDataMap

+ (SimulationDataMap*)sharedObj{
    static dispatch_once_t pred = 0;
    __strong static SimulationDataMap* _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [SimulationDataMap new];
    });
    return _sharedObject;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.shortMap = [NSMutableDictionary dictionary];

#pragma mark -GameEventCellModel
        NSDictionary* GameEventCellModelDic = @{
                                                @"rightCountries" : @[ @"哥伦比亚", @"西班牙",@"帕尔梅拉", @"不伦瑞克"  ],
                                                @"name" : @[ @"德甲", @"欧冠" ,@"联谊赛"],
                                                @"time" : @[ @"03/27 14:00", @"01/8 23:00" ],
                                                @"date" : @[ @"周二001", @"周三005" ],
                                                @"status" : @[ @"下76", @"已结束" ,@"未开始"],
                                                @"isCollect" : @[ @(1), @(0) ],
                                                @"leftCountries" : @[ @"哥伦比亚", @"西班牙",@"帕尔梅拉", @"不伦瑞克" ],
                                                @"statusCode" : @[ @(1), @(0) ,@(2)],
                                                };
        [self.shortMap setValue:GameEventCellModelDic forKey:@"GameEventCellModel"];
        
#pragma mark -HomeCellModel
        NSDictionary* HomeCellModelDic = @{
//                                           @"leftCountries" : @[ @"哥伦比亚", @"西班牙",@"帕尔梅拉", @"不伦瑞克" ],
//                                           @"rightCountries" : @[ @"哥伦比亚", @"西班牙",@"帕尔梅拉", @"不伦瑞克"  ],
                                           @"gameName" : @[ @"德甲", @"欧冠" ,@"联谊赛" ],
                                           @"job" : @[ @"央视名嘴", @"斗鱼主播" ],
                                           @"advantage" : @[ @"最高12场连胜", @"最低100场连胜" ],
                                           @"name" : @[ @"白温婷", @"婷白温",@"白婷温",@"婷白温"  ],
                                           @"shootingPer" : @[ @"100%", @"96%" ,@"71%",@"89%"],
                                           @"shootingHint" : @[@"命中率"],
                                           @"statusCode" : @[ @(1), @(0) ,@(2)],
                                           };
        [self.shortMap setValue:HomeCellModelDic forKey:@"HomeCellModel"];
    }
    return self;
}

@end

@implementation NSObject (SimulationDataMap)

- (instancetype)simulationData{
    unsigned int count;
    Class cls = [self class];
    objc_property_t* properties = class_copyPropertyList(cls, &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString* key = [NSString stringWithUTF8String:property_getName(property)];
        NSString* attributes = [NSString stringWithUTF8String:property_getAttributes(property)];
        if ([attributes hasPrefix:@"T@\"NSString\""]) {
            id data = [SimulationDataMap valueForModel:NSStringFromClass(cls) name:key];
            [self setValue:data ?: @"" forKey:key];
        } else if ([attributes hasPrefix:@"Tq"]) {
            id data = [SimulationDataMap valueForModel:NSStringFromClass(cls) name:key];
            [self setValue:data ?: @(0) forKey:key];
        } else if ([attributes hasPrefix:@"Td"]) {
            id data = [SimulationDataMap valueForModel:NSStringFromClass(cls) name:key];
            [self setValue:data ?: @(0) forKey:key];
        } else if ([attributes hasPrefix:@"T@\"NSArray\""]) {
            id data = [SimulationDataMap valueForModel:NSStringFromClass(cls) name:key];
            [self setValue:data ?: nil forKey:key];
        } else {
            NSLog(@"%@", attributes);
        }
    }
    free(properties);
    return self;
}

- (NSString*)creatCodeForSimulationDataMap{
    NSMutableString* code = [NSMutableString string];
    unsigned int count;
    Class cls = [self class];
    NSString* clsString = NSStringFromClass(cls);
    [code appendFormat:@"#pragma mark -%@\n", clsString];
    [code appendFormat:@"NSDictionary* %@Dic = @{\n", clsString];
    objc_property_t* properties = class_copyPropertyList(cls, &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString* key = [NSString stringWithUTF8String:property_getName(property)];
        [code appendFormat:@"@\"%@\" : @[ @\"value1\", @\"value2\" ],\n", key];
    }
    [code appendFormat:@"};\n[self.shortMap setValue:%@Dic forKey:@\"%@\"];", clsString, clsString];
    free(properties);
    return code;
}

+ (id)valueForModel:(NSString*)model name:(NSString*)name{
    if (model.length > 0 && name.length > 0) {
        NSDictionary* dic = [SimulationDataMap sharedObj].shortMap[model];
        if (dic) {
            NSArray* arr = dic[name];
            if (arr && arr.count) {
                id anyObject = arr[arc4random_uniform((u_int32_t)arr.count)];
                return anyObject;
            }
        }
    }
    return nil;
}

@end

