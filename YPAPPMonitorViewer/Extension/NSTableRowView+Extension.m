//
//  NSTableCellView+Extension.m
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/8.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import "NSTableRowView+Extension.h"

@implementation NSTableRowView (Extension)

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

@end
