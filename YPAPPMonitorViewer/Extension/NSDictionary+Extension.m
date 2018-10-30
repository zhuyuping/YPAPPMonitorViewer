//
//  NSDictionary+Extension.m
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/10.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (NSString *)jsonString {    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    if (parseError) {
        NSLog(@"NSDictionary+YP_Extension error :%@",parseError);
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
