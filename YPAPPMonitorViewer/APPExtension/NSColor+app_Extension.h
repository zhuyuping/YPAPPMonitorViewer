//
//  NSColor+app_Extension.h
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/8.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSColor (app_Extension)

+ (instancetype)clolorWithHex:(int)hexValue;

+ (instancetype)darkPrimaryColor ;
+ (instancetype)primaryColor ;
+ (instancetype)lightPrimaryColor ;
+ (instancetype)text_IconsColor ;
+ (instancetype)accentColor ;
+ (instancetype)primaryTextColor ;
+ (instancetype)secondaryTextColor ;
+ (instancetype)dividerColor ;
+ (instancetype)backgroundColor ;

@end
