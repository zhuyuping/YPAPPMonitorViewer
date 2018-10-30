//
//  DeviceInfoContentView.m
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/12.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import "DeviceInfoContentView.h"
#import "Extension.h"

@interface DeviceInfoContentViewWapper()

@end

@implementation DeviceInfoContentViewWapper

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]){
        _deviceInfoContentView = [DeviceInfoContentView instanceFormNib];
        _deviceInfoContentView.frame = self.bounds;
        [self addSubview:_deviceInfoContentView];
    }
    return self;
}

- (void)setFrame:(NSRect)frame {
    [super setFrame:frame];
    _deviceInfoContentView.frame = self.bounds;
}

@end

@interface DeviceInfoContentView()

@end

@implementation DeviceInfoContentView

@end





