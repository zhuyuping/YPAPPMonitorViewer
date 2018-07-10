//
//  NSString+app_Extension.m
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/9.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import "NSString+app_Extension.h"

@implementation NSString (app_Extension)

- (BOOL)isVaildHost {
    return self.length > 8;
}

- (BOOL)isVaildCustomedHostName {
    return self.length > 0;
}

@end
