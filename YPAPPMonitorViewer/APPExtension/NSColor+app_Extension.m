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
    return [NSColor clolorWithHex:0x303F9F];
}

+ (instancetype)primaryColor {
   return [NSColor clolorWithHex:0x3F51B5];
}

+ (instancetype)lightPrimaryColor {
    return [NSColor clolorWithHex:0xC5CAE9];
}

+ (instancetype)text_IconsColor {
    return [NSColor clolorWithHex:0xFFFFFF];
}
    
+ (instancetype)accentColor {
    return [NSColor clolorWithHex:0x536DFE];
}

+ (instancetype)primaryTextColor {
    return [NSColor clolorWithHex:0x212121];
}

+ (instancetype)secondaryTextColor {
    return [NSColor clolorWithHex:0x727272];
}

+ (instancetype)dividerColor {
    return [NSColor clolorWithHex:0xB6B6B6];
}

+ (instancetype)backgroundColor {
    return [NSColor clolorWithHex:0xf8f8f8];
}
    
@end
