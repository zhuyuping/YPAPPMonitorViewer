//
//  NSPopUpButton+Extension.m
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/10.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import "NSPopUpButton+Extension.h"

@implementation NSPopUpButton (Extension)

- (void)setItems:(NSArray <NSString *>*)items {
    [self removeAllItems];
    [self addItemsWithTitles:items];
}

@end
