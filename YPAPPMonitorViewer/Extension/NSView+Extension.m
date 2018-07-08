//
//  NSView+Extension.m
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/8.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import "NSView+Extension.h"

@implementation NSView (Extension)

- (void)setBackroundClolor:(NSColor *)color {
    self.wantsLayer = YES;
    self.layer.backgroundColor = color.CGColor;
    [self setNeedsDisplay:YES];
}
    
@end
