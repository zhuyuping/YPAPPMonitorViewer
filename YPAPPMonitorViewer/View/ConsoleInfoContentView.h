//
//  ConsoleInfoContentView.h
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/12.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
@class ConsoleInfoContentView;

@interface ConsoleInfoContentViewWapper : NSView

@property(nonatomic, strong) ConsoleInfoContentView *consoleInfoContentView;

@end

@interface ConsoleInfoContentView : NSView

@property (weak) IBOutlet NSTextField *blankTextLabel;
@property (strong) IBOutlet WebView *webView;

- (void)setUrlString:(NSString *)urlString ;

@end
