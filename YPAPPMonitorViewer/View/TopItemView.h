//
//  TopItemView.h
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/10.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class TopItemView;

@protocol TopItemViewDelegate <NSObject>

- (void)topItemViewDidTapButtonAtIndex:(NSInteger)index ;

@end

@interface TopItemViewWapper : NSView

@property (nonatomic, strong) TopItemView *topItemView;
@property (nonatomic, weak) id<TopItemViewDelegate> delegate;

@end



@interface TopItemView : NSView

@property (weak) IBOutlet NSButton *button1;
@property (weak) IBOutlet NSButton *button2;
@property (weak) IBOutlet NSButton *button3;

@property (nonatomic, weak) id<TopItemViewDelegate> delegate;

@end
