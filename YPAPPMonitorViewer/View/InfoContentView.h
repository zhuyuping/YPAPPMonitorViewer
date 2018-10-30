//
//  InfoContentView.h
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/12.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class InfoContentView;

@interface InfoContentViewWapper : NSView
@property(nonatomic, strong) InfoContentView *infoContentView;

- (void)selectedAtIndex:(NSInteger)index ;
- (void)setData:(id)data ;

@end

@interface InfoContentView : NSView

- (void)selectedAtIndex:(NSInteger)index ;
- (void)setData:(id)data ;

@end
