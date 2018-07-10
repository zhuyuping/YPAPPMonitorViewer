//
//  SubTitleTableCellView.h
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/8.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SubTitleTableCellView : NSTableRowView

@property (weak) IBOutlet NSTextField *titleLabel;
@property (weak) IBOutlet NSTextField *subTitleLabel;

- (void)setCkeck:(BOOL)check ;

@end
