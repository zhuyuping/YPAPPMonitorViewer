//
//  YPAppFluencyInfo.m
//  YPAppMonitorDemo
//
//  Created by ZYP on 2018/7/10.
//  Copyright © 2018年 ZYP. All rights reserved.
//


#import "YPAppFluencyInfo.h"
#import "NSDate+YP_Extension.h"
#import "NSString+YP_Extension.h"

@interface YPAppFluencyInfo()

@property (nonatomic, copy) NSString * deviceInfo;          // iOS 11.4 ，iPhone 7
@property (nonatomic, copy) NSString * screenRatio;         // 750x1334
@property (nonatomic, copy) NSString * screenPPI;           // 326 PPI
@property (nonatomic, copy) NSString * memoryInfo;          // 可用：164.86MB，已用：1416.19MB
@property (nonatomic, copy) NSString * telecomperators;     // 中国移动 (LTE)
@property (nonatomic, copy) NSString * WIFI;                // N/A
@property (nonatomic, copy) NSString * electricity;         // 67%，Unplugged
@property (nonatomic, copy) NSString * appVersion;          // 3.1.1 (build 2)
@property (nonatomic, copy) NSString * sdkVersion;          // 3.1.1
@property (nonatomic, copy) NSString * screenShotImageUrl;  // 截图URL

@property (nonatomic, copy) NSString * identifier;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * stackInfo;
@property (nonatomic, copy) NSString * time;
@property (nonatomic, copy) NSString * topViewController;

@end

@implementation YPAppFluencyInfo
NSString * __convert_time(NSDate * date) {
    static NSDateFormatter * lxd_date_formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lxd_date_formatter = [NSDateFormatter new];
        lxd_date_formatter.dateFormat = @"yyyy-HH-dd HH:mm:ss";
    });
    return [lxd_date_formatter stringFromDate: date];
}

+ (instancetype)fluencyInfoWithStackInfo:(NSString *)stackInfo
                       topViewController:(NSString *)topViewController {
    YPAppFluencyInfo *info = [YPAppFluencyInfo new];
    
    info.stackInfo = stackInfo ?: @"";
    info.topViewController = topViewController ?: @"";
    info.name = info.topViewController;
    
    info.time = __convert_time([NSDate date]);
    info.identifier = [YPAppFluencyInfo createIdentifier];
//    info.deviceInfo = [NSString stringWithFormat:@"%@ %@ , %@ %@",
//                       [UIDevice currentDevice].systemName,
//                       [UIDevice currentDevice].systemVersion,
//                       [UIDevice currentDevice].model,
//                       [UIDevice currentDevice].localizedModel];
    info.screenRatio = @"750x1334";
    info.screenPPI = @"326 PPI";
    info.memoryInfo = @"可用：164.86MB，已用：1416.19MB";
    info.telecomperators = @"中国移动 (LTE)";
    info.WIFI = @"N/A";
    info.electricity = @"67%，Unplugged";
    info.appVersion = @"1.0.1";
    info.sdkVersion = @"0.1";
    info.screenShotImageUrl = @"";
    return info;
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    NSAssert(self.name != nil, @"XX");
    return self;
}

- (NSDictionary *)dictionary {
    return @{
             @"identifier" : _identifier,
             @"name" : _name,
             @"stackInfo" : _stackInfo,
             @"time" : _time,
             @"topViewController" : _topViewController,
             @"deviceInfo":_deviceInfo,
             @"screenRatio":_screenRatio,
             @"screenPPI":_screenPPI,
             @"memoryInfo":_memoryInfo,
             @"telecomperators":_telecomperators,
             @"WIFI":_WIFI,
             @"electricity":_electricity,
             @"appVersion":_appVersion,
             @"sdkVersion":_sdkVersion,
             @"screenShotImageUrl":_screenShotImageUrl
             };
}

+ (NSString *)createIdentifier {
    NSMutableString *str = @"".mutableCopy;
    [str appendString:[NSDate currentTimeStampMS]];
    [str appendString:@"-"];
    [str appendString:[NSString random32String]];
    return str.copy;
}

@end
