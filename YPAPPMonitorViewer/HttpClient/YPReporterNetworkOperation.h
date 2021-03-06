//
//  YPReporterNetworkOperation.h
//  YPAppMonitorDemo
//
//  Created by ZYP on 2018/6/14.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPHttpClient.h"

@interface YPReporterNetworkOperation : NSObject

extern void _YP_reporterNetworkOperation_setBaseUrl(NSString *url) ;

+ (void)fluencyWithPage:(NSInteger)page
                 length:(NSInteger)length
       completedHandler:(YPHttpClientRequestResultBlock)handle ;
+ (void)crashWithPage:(NSInteger)page
               length:(NSInteger)length
     completedHandler:(YPHttpClientRequestResultBlock)handle ;

@end
