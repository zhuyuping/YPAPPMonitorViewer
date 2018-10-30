//
//  DeviceInfoContentView.h
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/12.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class DeviceInfoContentView;

@interface DeviceInfoContentViewWapper : NSView
@property(nonatomic, strong) DeviceInfoContentView *deviceInfoContentView;
@end

@interface DeviceInfoContentView : NSView

@property (weak) IBOutlet NSTextField *reasonLabel;
@property (weak) IBOutlet NSTextField *VCLabel;
@property (weak) IBOutlet NSTextField *deviceInfoLabel;
@property (weak) IBOutlet NSTextField *screenRatioLabel;
@property (weak) IBOutlet NSTextField *screenPPILabel;
@property (weak) IBOutlet NSTextField *memoryInfoLabel;
@property (weak) IBOutlet NSTextField *diskInfoLabel;
@property (weak) IBOutlet NSTextField *telecomperatorsLabel;
@property (weak) IBOutlet NSTextField *WifiLabel;
@property (weak) IBOutlet NSTextField *electricityLabel;
@property (weak) IBOutlet NSTextField *locationLabel;
@property (weak) IBOutlet NSTextField *appVersionLabel;
@property (weak) IBOutlet NSTextField *timeLabel;
@property (weak) IBOutlet NSTextField *breakoutLabel;
@property (weak) IBOutlet NSTextField *sdkVersionLabel;
@property (weak) IBOutlet NSImageView *shotImageView;

@end
