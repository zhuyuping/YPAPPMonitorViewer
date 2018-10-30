//
//  ConsoleInfoContentView.m
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/12.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import "ConsoleInfoContentView.h"
#import "Extension.h"

@implementation ConsoleInfoContentViewWapper

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]){
        _consoleInfoContentView = [ConsoleInfoContentView instanceFormNib];
        _consoleInfoContentView.frame = self.bounds;
        [self addSubview:_consoleInfoContentView];
    }
    return self;
}

- (void)setFrame:(NSRect)frame {
    [super setFrame:frame];
    _consoleInfoContentView.frame = self.bounds;
}

@end

@implementation ConsoleInfoContentView

- (void)setUrlString:(NSString *)urlString {
    if (!urlString) {
        self.webView.hidden = YES;
        self.blankTextLabel.hidden = NO;
        return;
    }
    [self.webView setDrawsBackground:NO];
    [self.webView setBackroundClolor:[NSColor backgroundColor]];
    self.webView.hidden = NO;
    self.blankTextLabel.hidden = YES;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.webView.mainFrame loadRequest:req];
}

@end
