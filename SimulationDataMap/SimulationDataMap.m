
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

#pragma mark -HomeScoreAdvertCellModel
        NSDictionary* HomeScoreAdvertCellModelDic = @{
            @"ad" : @[ @"score_ad1", @"score_ad2" ],
        };
        [self.shortMap setValue:HomeScoreAdvertCellModelDic forKey:@"HomeScoreAdvertCellModel"];

#pragma mark -HomeScoreGameCellModel
        NSDictionary* HomeScoreGameCellModelDic = @{
            @"star" : @[ @"live_star_choosed", @"live_star_common" ],
            @"live" : @[ @"live" ],
            @"countries" : @[ @"中超", @"英美" ],
            @"time" : @[ @"16:00", @"13:00" ],
            @"split" : @[ @"-" ],
            @"status" : @[ @"上90", @"下20" ],
            @"scorePer" : @[ @"3-2", @"1-3" ],
            @"oneSide" : @[ @"上海上港", @"美国", @"英国" ],
            @"otherSide" : @[ @"中国", @"日本", @"俄国" ],
            @"leftSubDes1" : @[ @"1", @"2", @"3" ],
            @"leftSubDes2" : @[ @"1", @"2", @"3" ],
            @"rightSubDes1" : @[ @"1", @"2", @"3" ],
            @"rightSubDes2" : @[ @"1", @"2", @"3" ],
            @"oneSideScore" : @[ @"1", @"2", @"3" ],
            @"otherSideScore" : @[ @"1", @"2", @"3" ],
            @"scoreSplit" : @[ @":" ],
            @"leftSubDes1BgColor" : @[ @(1), @(0) ],
            @"leftSubDes2BgColor" : @[ @(1), @(0) ],
            @"rightSubDes1BgColor" : @[ @(1), @(0) ],
            @"rightSubDes2BgColor" : @[ @(1), @(0) ],
        };
        [self.shortMap setValue:HomeScoreGameCellModelDic forKey:@"HomeScoreGameCellModel"];

#pragma mark -HomeIndexTopCellModel
        NSDictionary* HomeIndexTopCellModelDic = @{
            @"banner" : @[ @[ @"http://www.cjolimg.com/v8/cjolapp/images/uploadimg/app_banner8.png", @"http://www.cjolimg.com/v8/cjolapp/images/uploadimg/app_banner1.png", @"http://www.cjolimg.com/v8/cjolapp/images/uploadimg/app_banner2.png" ] ],
        };
        [self.shortMap setValue:HomeIndexTopCellModelDic forKey:@"HomeIndexTopCellModel"];

#pragma mark -HomeIndexADCellModel
        NSDictionary* HomeIndexADCellModelDic = @{
            @"AD" : @[ @"score_ad1", @"score_ad2" ],
        };
        [self.shortMap setValue:HomeIndexADCellModelDic forKey:@"HomeIndexADCellModel"];

#pragma mark -HomeIndexCareCellModel
        NSDictionary* HomeIndexCareCellModelDic = @{
            @"typeIcon" : @[ @"IndexMoney", @"IndexMoney1", @"IndexScre" ],
            @"typeDes1" : @[ @"为你", @"命中", @"关注" ],
            @"typeDes2" : @[ @"推送", @"最高", @"的人" ],
            @"headIcon" : @[ @"weixi", @"weibo" ],
            @"name" : @[ @"只求一黑", @"小法官", @"扬子江", @"收米" ],
            @"star" : @[ @(3.5), @(2), @(5), @(2) ],
            @"gameTypeStatus" : @[ @"自由杯 5中2", @"自由杯 5中4" ],
            @"coin" : @[ @"8 福币", @"18 福币" ],
            @"per" : @[ @"46%", @"88.13%", @"100%" ],
            @"winDay" : @[ @"7天胜率", @"4天胜率" ],
            @"gameCategiey" : @[ @"重心", @"小型" ],
            @"twoSideDes" : @[ @"西甲-皇家贝蒂 vs 皇家社会", @"西甲-阿拉维斯 vs 莱万特", @"自由杯-利马联盟 vs 博卡青年" ]
        };
        [self.shortMap setValue:HomeIndexCareCellModelDic forKey:@"HomeIndexCareCellModel"];

#pragma mark -HomeIndexItemCellModel
        NSDictionary* HomeIndexItemCellModelDic = @{
            @"recently" : @[ @"最近5场 5全中", @"最近5场 3全中" ],
            @"headIcon" : @[ @"weixi", @"weibo" ],
            @"name" : @[ @"只求一黑", @"小法官", @"扬子江", @"收米" ],
            @"star" : @[ @(3.5), @(2), @(5), @(2) ],
            @"gameTypeStatus" : @[ @"自由杯 5中2", @"自由杯 5中4" ],
            @"coin" : @[ @"8 福币", @"18 福币" ],
            @"per" : @[ @"46%", @"88.13%", @"100%" ],
            @"winDay" : @[ @"7天胜率", @"4天胜率" ],
            @"desText" : @[ @"5连中，冲击6连红，一起杀庄中中中！贝蒂斯 ,贝蒂斯", @"3连中，冲击1连红,中中中！,一起杀庄,贝蒂斯,一起杀庄 " ],
            @"gameCategiey" : @[ @"重心", @"小型" ],
            @"twoSideDes" : @[ @"西甲-皇家贝蒂 vs 皇家社会", @"西甲-阿拉维斯 vs 莱万特", @"自由杯-利马联盟 vs 博卡青年" ]
        };
        [self.shortMap setValue:HomeIndexItemCellModelDic forKey:@"HomeIndexItemCellModel"];

#pragma mark -IndexRecomentCellModel
        NSDictionary* IndexRecomentCellModelDic = @{
            @"headIcon" : @[ @"weixi", @"weibo" ],
            @"gameStatus" : @[ @"5中5", @"5中4", @"5中3", @"5中2", @"5中1" ],
            @"name" : @[ @"只求一黑", @"小法官", @"扬子江", @"收米" ],
            @"gameType" : @[ @"竞彩亚盘", @"单关", @"大小球" ],
        };
        [self.shortMap setValue:IndexRecomentCellModelDic forKey:@"IndexRecomentCellModel"];
        
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

