//
//  NSColor+app_Extension.m
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/8.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import "NSColor+app_Extension.h"

@implementation NSColor (app_Extension)
    
+ (instancetype)clolorWithHex:(int)hexValue {
    return [NSColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:1.0f];
}

+ (instancetype)darkPrimaryColor {
    return [NSColor clolorWithHex:0x98A6F5];
}

+ (instancetype)primaryColor {
   return [NSColor clolorWithHex:0xE8EAF6];
}

+ (instancetype)lightPrimaryColor {
    return [NSColor clolorWithHex:0xF0F1F5];
}
    
+ (instancetype)secondaryColor {
    return [NSColor clolorWithHex:0x3F51B5];
}
    
+ (instancetype)accentColor {
    return [NSColor clolorWithHex:0x8C9EFF];
}

+ (instancetype)primaryTextColor {
    return [NSColor clolorWithHex:0x212121];
}

+ (instancetype)secondaryTextColor {
    return [NSColor clolorWithHex:0x727272];
}

+ (instancetype)dividerColor {
    return [NSColor clolorWithHex:0xE8EAF6];
}

+ (instancetype)backgroundColor {
    return [NSColor clolorWithHex:0xf8f8f8];
}
    
@end
