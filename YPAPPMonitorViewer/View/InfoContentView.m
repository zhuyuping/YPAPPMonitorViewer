//
//  InfoContentView.m
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/12.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import "InfoContentView.h"
#import "DeviceInfoContentView.h"
#import "StackInfoContentView.h"
#import "ConsoleInfoContentView.h"
#import "Extension.h"
#import "APPExtension.h"
#import "YPAppFluencyInfo.h"
#import "YPAppCrashInfo.h"
#import "HostManager.h"

@interface InfoContentViewWapper()

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation InfoContentViewWapper

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]){
        _infoContentView = [InfoContentView instanceFormNib];
        _infoContentView.frame = self.bounds;
        [self addSubview:_infoContentView];
        [self setBackroundClolor:[NSColor backgroundColor]];
    }
    return self;
}

- (void)setFrame:(NSRect)frame {
    [super setFrame:frame];
    _infoContentView.frame = self.bounds;
}

- (void)selectedAtIndex:(NSInteger)index {
    _currentIndex = index;
    [self.infoContentView selectedAtIndex:index];
}

- (void)setData:(id)data {
    [self.infoContentView setData:data];
    [self selectedAtIndex:_currentIndex];
}

@end

@interface InfoContentView()

@property (weak) IBOutlet ConsoleInfoContentViewWapper *consoleInfoViewWapper;
@property (weak) IBOutlet StackInfoContentViewWapper *stackInfoViewWapper;
@property (weak) IBOutlet DeviceInfoContentViewWapper *deviceInfoViewWapper;

@end

@implementation InfoContentView

- (void)selectedAtIndex:(NSInteger)index {
    self.deviceInfoViewWapper.hidden = !(index == 0);
    self.stackInfoViewWapper.hidden = !(index == 1);
    self.consoleInfoViewWapper.hidden = !(index == 2);
}

- (void)setData:(id)data {
    if ([data isKindOfClass:YPAppFluencyInfo.class]) {
        YPAppFluencyInfo *info = (YPAppFluencyInfo *)data;
        DeviceInfoContentView *deviceInfoView = self.deviceInfoViewWapper.deviceInfoContentView;
        deviceInfoView.deviceInfoLabel.stringValue = info.deviceInfo;
        deviceInfoView.screenRatioLabel.stringValue = info.screenRatio;
        deviceInfoView.screenPPILabel.stringValue = info.screenPPI;
        deviceInfoView.memoryInfoLabel.stringValue = info.memoryInfo;
        deviceInfoView.diskInfoLabel.stringValue = @"---";
        deviceInfoView.telecomperatorsLabel.stringValue = info.telecomperators;
        deviceInfoView.WifiLabel.stringValue = info.WIFI;
        deviceInfoView.electricityLabel.stringValue = info.electricity;
        deviceInfoView.locationLabel.stringValue = @"---";
        deviceInfoView.appVersionLabel.stringValue = info.appVersion;
        deviceInfoView.timeLabel.stringValue = info.time;
        deviceInfoView.breakoutLabel.stringValue = @"---";
        deviceInfoView.sdkVersionLabel.stringValue = info.sdkVersion;
        deviceInfoView.VCLabel.stringValue = info.topViewController;
        deviceInfoView.reasonLabel.hidden = YES;
        NSString *urlString = [NSString stringWithFormat:@"http://%@:8088/shotimage/%@.png",
                               kHOSTManager.selectedHost.host,
                               info.identifier];
        NSURL *imageUrl = [NSURL URLWithString:urlString];
        deviceInfoView.shotImageView.image = [[NSImage alloc] initWithContentsOfURL:imageUrl];
        StackInfoContentView *stackInfoView = self.stackInfoViewWapper.stackInfoContentView;
        [stackInfoView setText:info.stackInfo];
        ConsoleInfoContentView *consoleInfoView = self.consoleInfoViewWapper.consoleInfoContentView;
        [consoleInfoView setUrlString:nil];
    }
    if ([data isKindOfClass:YPAppCrashInfo.class]) {
        YPAppCrashInfo *info = (YPAppCrashInfo *)data;
        DeviceInfoContentView *deviceInfoView = self.deviceInfoViewWapper.deviceInfoContentView;
        deviceInfoView.deviceInfoLabel.stringValue = info.deviceInfo;
        deviceInfoView.screenRatioLabel.stringValue = info.screenRatio;
        deviceInfoView.screenPPILabel.stringValue = info.screenPPI;
        deviceInfoView.memoryInfoLabel.stringValue = info.memoryInfo;
        deviceInfoView.diskInfoLabel.stringValue = @"---";
        deviceInfoView.telecomperatorsLabel.stringValue = info.telecomperators;
        deviceInfoView.WifiLabel.stringValue = info.WIFI;
        deviceInfoView.electricityLabel.stringValue = info.electricity;
        deviceInfoView.locationLabel.stringValue = @"---";
        deviceInfoView.appVersionLabel.stringValue = info.appVersion;
        deviceInfoView.timeLabel.stringValue = info.time;
        deviceInfoView.breakoutLabel.stringValue = @"---";
        deviceInfoView.sdkVersionLabel.stringValue = info.sdkVersion;
        deviceInfoView.VCLabel.stringValue = info.topViewController;
        deviceInfoView.reasonLabel.hidden = NO;
        deviceInfoView.reasonLabel.stringValue = info.reason;
        NSString *urlString = [NSString stringWithFormat:@"http://%@:8088/shotimage/%@.png",
                               kHOSTManager.selectedHost.host,
                               info.identifier];
        NSURL *imageUrl = [NSURL URLWithString:urlString];
        deviceInfoView.shotImageView.image = [[NSImage alloc] initWithContentsOfURL:imageUrl];
        
        StackInfoContentView *stackInfoView = self.stackInfoViewWapper.stackInfoContentView;
        [stackInfoView setText:info.stackInfo];
        
        NSString *logUrlString = [NSString stringWithFormat:@"http://%@:8088/log/%@.log",
                               kHOSTManager.selectedHost.host,
                               info.identifier];
        ConsoleInfoContentView *consoleInfoView = self.consoleInfoViewWapper.consoleInfoContentView;
        [consoleInfoView setUrlString:logUrlString];
    }
}


@end





