//
//  StackInfoContentView.m
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/12.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import "StackInfoContentView.h"
#import "Extension.h"
#import "APPExtension.h"


@implementation StackInfoContentViewWapper

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]){
        _stackInfoContentView = [StackInfoContentView instanceFormNib];
        _stackInfoContentView.frame = self.bounds;
        [self addSubview:_stackInfoContentView];
    }
    return self;
}

- (void)setFrame:(NSRect)frame {
    [super setFrame:frame];
    _stackInfoContentView.frame = self.bounds;
}

@end

@interface StackInfoContentView()

@property (unsafe_unretained) IBOutlet NSTextView *textView;

@end

@implementation StackInfoContentView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.textView setBackgroundColor:[NSColor backgroundColor]];
}

- (void)setText:(NSString *)text {
    self.textView.string = text;
}

@end
