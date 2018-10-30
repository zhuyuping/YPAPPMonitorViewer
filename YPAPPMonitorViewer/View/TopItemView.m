//
//  TopItemView.m
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/10.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import "TopItemView.h"
#import "Extension.h"
#import "APPExtension.h"

@implementation TopItemViewWapper

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]){
        _topItemView = [TopItemView instanceFormNib];
        _topItemView.frame = self.bounds;
        [self addSubview:_topItemView];
    }
    return self;
}

- (void)setDelegate:(id<TopItemViewDelegate>)delegate {
    _topItemView.delegate = delegate;
}

@end

@implementation TopItemView


- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]){
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
}

- (IBAction)buttonOnclick:(NSButton *)sender {
    [_button1 setState:(sender == _button1) ? NSControlStateValueOn : NSControlStateValueOff];
    [_button2 setState:(sender == _button2) ? NSControlStateValueOn : NSControlStateValueOff];
    [_button3 setState:(sender == _button3) ? NSControlStateValueOn : NSControlStateValueOff];
    
    if(_delegate && [_delegate respondsToSelector:@selector(topItemViewDidTapButtonAtIndex:)]){
        [_delegate topItemViewDidTapButtonAtIndex:sender.tag];
    }
}


@end
