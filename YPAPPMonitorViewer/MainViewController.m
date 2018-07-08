//
//  ViewController.m
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/6.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import "MainViewController.h"
#import "Extension/Extension.h"
#import "APPExtension/APPExtension.h"
#import "SubTitleTableCellView.h"

@interface MainViewController ()<NSTabViewDelegate,NSTableViewDataSource>
    
@property (weak) IBOutlet NSView *leftBarView;
@property (weak) IBOutlet NSTableView *centerTableview;
@property (weak) IBOutlet NSView *seperatorView;
@property (weak) IBOutlet NSView *horizontalSeperatorView;
@property (weak) IBOutlet NSView *topBarView;
@property (weak) IBOutlet NSView *contentView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

}

    
#pragma mark -- private
    
- (void)setupUI {
    [_leftBarView setBackroundClolor:[NSColor primaryColor]];
    _centerTableview.dataSource = self;
    _centerTableview.delegate = (id<NSTableViewDelegate>)self;
    NSNib *nib = [[NSNib alloc] initWithNibNamed:[SubTitleTableCellView cellIdentifier] bundle:nil];
    [_centerTableview registerNib:nib forIdentifier:[SubTitleTableCellView cellIdentifier]];
    [_seperatorView setBackroundClolor:[NSColor dividerColor]];
    [_horizontalSeperatorView setBackroundClolor:[NSColor dividerColor]];
    [_topBarView setBackroundClolor:[NSColor backgroundColor]];
    [_contentView setBackroundClolor:[NSColor backgroundColor]];
}
    
#pragma mark - NSTableViewDataSource
    
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return 30;
}
    
- (nullable NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row {
    SubTitleTableCellView *cell = [tableView makeViewWithIdentifier:[SubTitleTableCellView cellIdentifier] owner:self];
    
    return cell;
}



@end
