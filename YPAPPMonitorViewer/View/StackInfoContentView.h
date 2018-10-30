//
//  StackInfoContentView.h
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/12.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class StackInfoContentView;

@interface StackInfoContentViewWapper : NSView

@property(nonatomic, strong) StackInfoContentView *stackInfoContentView;

@end

@interface StackInfoContentView : NSView

- (void)setText:(NSString *)text ;

@end
