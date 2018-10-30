//
//  HostManager.h
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/9.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Host : NSObject<NSCopying>

@property(nonatomic, copy) NSString *host;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) BOOL selected; 

- (id)initWithDict:(NSDictionary *)dict ;
- (NSDictionary *)dictionary ;

@end

#define kHOSTManager [HostManager shareInstance]

@interface HostManager : NSObject

+ (instancetype)shareInstance ;
- (NSMutableArray <Host *>*)allHosts ;
- (void)insertHost:(Host *)host ;
- (void)removeHost:(Host *)host ;
- (void)setSelected:(Host *)selectedHost ;
- (Host *)selectedHost ;

@end
