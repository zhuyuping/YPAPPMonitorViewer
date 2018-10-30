//
//  YPReporterNetworkOperation.m
//  YPAppMonitorDemo
//
//  Created by ZYP on 2018/6/14.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import "YPReporterNetworkOperation.h"
#import "Extension.h"


NSString * const __YP_Reporter_path_fluency = @"fluencies";
NSString * const __YP_Reporter_path_crash = @"crashs";

NSString *__YP_reporterNetworkOperation_baseUrl;
inline void _YP_reporterNetworkOperation_setBaseUrl(NSString *url){
    __YP_reporterNetworkOperation_baseUrl = url.copy;
}

static inline NSString *_YP_reporterNetworkOperation_getBaseUrl(){
    return __YP_reporterNetworkOperation_baseUrl;
}

@implementation YPReporterNetworkOperation

+ (void)fluencyWithPage:(NSInteger)page
                 length:(NSInteger)length
       completedHandler:(YPHttpClientRequestResultBlock)handle {
    NSDictionary *param = @{@"page":@(page),
                            @"length":@(length)
                            };
    [YPHttpClient GetWithBaseUrl:_YP_reporterNetworkOperation_getBaseUrl()
                            path:__YP_Reporter_path_fluency
                      parameters:param
                completedHandler:handle];
}

+ (void)crashWithPage:(NSInteger)page
                 length:(NSInteger)length
       completedHandler:(YPHttpClientRequestResultBlock)handle {
    NSDictionary *param = @{@"page":@(page),
                            @"length":@(length)
                            };
    [YPHttpClient GetWithBaseUrl:_YP_reporterNetworkOperation_getBaseUrl()
                            path:__YP_Reporter_path_crash
                      parameters:param
                completedHandler:handle];
}

@end
