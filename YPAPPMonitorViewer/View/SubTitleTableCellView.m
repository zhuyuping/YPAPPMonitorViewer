//
//  SubTitleTableCellView.m
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/8.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import "SubTitleTableCellView.h"

@interface SubTitleTableCellView()
@property (weak) IBOutlet NSImageView *checkImageview;

@end

@implementation SubTitleTableCellView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
}

- (void)setCkeck:(BOOL)check {
    [self.checkImageview setHidden:!check];
}

- (void)drawSelectionInRect:(NSRect)dirtyRect {
    NSRect selectionRect = NSInsetRect(self.bounds, 0, 0);
    [[NSColor colorWithCalibratedWhite:.72 alpha:1.0] setStroke];
    [[NSColor colorWithCalibratedWhite:.82 alpha:1.0] setFill];
    NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRoundedRect:selectionRect xRadius:0 yRadius:0];
    [selectionPath fill];
    [selectionPath stroke];
}



@end
