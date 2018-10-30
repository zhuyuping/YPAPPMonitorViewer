//
//  HeaderFooterTableCellView.m
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/9/6.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import "HeaderFooterTableCellView.h"

@implementation HeaderFooterTableCellView


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

- (instancetype)init {
    if (self = [super init]) {
        self.state = HeaderFooterTableCellViewStateNormal;
    }
    return self;
}

- (void)drawSelectionInRect:(NSRect)dirtyRect {}

- (void)configTypeWithTableViewRow:(NSInteger)row {
    self.type = row == 0 ? HeaderFooterTableCellViewType1 : HeaderFooterTableCellViewType2;
    [self.button setTitle:row == 0 ? @"刷 新" : @"更 多"];
}

- (void)setState:(HeaderFooterTableCellViewState)state {
    _state = state;
    if (state == HeaderFooterTableCellViewStateNormal) {
        self.button.enabled = YES;
        [self.indicator stopAnimation:self];
        self.indicator.hidden = YES;
    }
    if (state == HeaderFooterTableCellViewStateLoading) {
        self.button.enabled = NO;
        self.indicator.hidden = NO;
        [self.indicator startAnimation:self];
    }
    if (state == HeaderFooterTableCellViewStateDisable) {
        self.button.enabled = NO;
        [self.indicator stopAnimation:self];
        self.indicator.hidden = YES;
    }
}

- (IBAction)buttonOnclick:(NSButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(HeaderFooterTableCellView:didTouchButtonWithType:)]) {
        [_delegate HeaderFooterTableCellView:self didTouchButtonWithType:self.type];
    }
}

@end
