//
//  HostManager.m
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/9.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import "HostManager.h"

@implementation Host

- (id)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _host = dict[@"host"];
        _name = dict[@"name"];
        _selected = [dict[@"selected"] boolValue];
    }
    return self;
}

- (NSDictionary *)dictionary {
    return @{@"host":_host,
             @"name":_name,
             @"selected":@(_selected)};
}

- (id)copyWithZone:(NSZone *)zone {
    Host *h = [Host allocWithZone:zone];
    h.name = self.name;
    h.host = self.host;
    h.selected = self.selected;
    return h;
}

@end


@interface HostManager()

@property(nonatomic, copy) NSString *path;
@property(nonatomic, strong) NSMutableArray *hosts;

@end

@implementation HostManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static HostManager *ma;
    dispatch_once(&onceToken, ^{
        ma = [HostManager new];
    });
    return ma;
}

- (instancetype)init {
    if (self = [super init]) {
        [self read];
    }
    return self;
}

#pragma mark - public

- (NSMutableArray <Host *>*)allHosts {
    return self.hosts;
}

- (void)insertHost:(Host *)host {
    [self.hosts addObject:host];
    [self save];
    [self read];
}

- (void)removeHost:(Host *)host {
    [self.hosts removeObject:host];
    [self save];
    [self read];
}

- (void)setSelected:(Host *)selectedHost {
    for (Host *host in self.hosts) {
        host.selected = (selectedHost == host);
    }
    [self save];
    [self read];
}

- (Host *)selectedHost {
    if (self.hosts.count == 0) return nil;
    for (Host *host in self.hosts) {
        if (host.selected) {
            return host;
        }
    }
    return self.hosts.firstObject;
}

#pragma mark - private

- (void)save {
    NSMutableArray *hostDicts = @[].mutableCopy;
    for (Host *host in self.hosts) {
        [hostDicts addObject:host.dictionary];
    }
    BOOL ret = [hostDicts writeToFile:self.path atomically:YES];
    if (!ret) { NSLog(@"写入本地失败"); }
}

- (void)read {
    NSMutableArray *hosts = @[].mutableCopy;
    NSArray *hostDicts = [[NSArray alloc] initWithContentsOfFile:self.path];
    for (NSDictionary *hostDict in hostDicts) {
        Host *host = [[Host alloc] initWithDict:hostDict];
        [hosts addObject:host];
    }
    _hosts = hosts.mutableCopy;
}

#pragma mark - set && get

- (NSString *)path {
    if (!_path) {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        _path = [documentPath stringByAppendingPathComponent:@"myHosts.plist"];
        NSLog(@"pa:%@",_path);
        NSFileManager* fm = [NSFileManager defaultManager];
        if (![fm fileExistsAtPath:_path]) {
            BOOL ret = [fm createFileAtPath:_path contents:nil attributes:nil];
            if (ret) {
                NSLog(@"创建文件成功");
            } else {
                NSLog(@"创建文件失败");
            }
        }
    }
    return _path;
}

- (NSMutableArray *)hosts {
    if (!_hosts) {
        [self read];
    }
    return _hosts;
}

@end
