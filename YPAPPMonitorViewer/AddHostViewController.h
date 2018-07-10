//
//  AddHostViewController.h
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/9.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const _Nonnull ksegueIdentifier ;

typedef void(^addHostBlock)(void);

@interface AddHostViewController : NSViewController

@property(nonatomic, strong) addHostBlock didChangeHosts;

@end
