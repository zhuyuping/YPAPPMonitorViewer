//
//  HeaderFooterTableCellView.h
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/9/6.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSUInteger, HeaderFooterTableCellViewType) {
    HeaderFooterTableCellViewType1, // 显示 "刷新"
    HeaderFooterTableCellViewType2, // 显示 "更多"
};

typedef NS_ENUM(NSUInteger, HeaderFooterTableCellViewState) {
    HeaderFooterTableCellViewStateNormal,
    HeaderFooterTableCellViewStateLoading,
    HeaderFooterTableCellViewStateDisable,
};

@class HeaderFooterTableCellView;

@protocol HeaderFooterTableCellViewDelegate <NSObject>

- (void)HeaderFooterTableCellView:(HeaderFooterTableCellView *)cell didTouchButtonWithType:(HeaderFooterTableCellViewType)type ;

@end

@interface HeaderFooterTableCellView : NSTableRowView
@property (weak) IBOutlet NSProgressIndicator *indicator;
@property (weak) IBOutlet NSButton *button;
@property(nonatomic, assign) HeaderFooterTableCellViewType type;
@property(nonatomic, assign) HeaderFooterTableCellViewState state;    
@property(nonatomic, weak) id <HeaderFooterTableCellViewDelegate> delegate; 

- (void)configTypeWithTableViewRow:(NSInteger)row ;

@end
