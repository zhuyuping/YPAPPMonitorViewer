//
//  SettingViewController.m
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/9.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import "SettingViewController.h"
#import "AddHostViewController.h"
#import "HostManager.h"
#import "Extension.h"
#import "SubTitleTableCellView.h"

@interface SettingViewController ()<NSTabViewDelegate,NSTableViewDataSource>

@property (weak) IBOutlet NSSegmentedControl *segmentedControl;
@property (weak) IBOutlet NSTableView *tableview;

@property (nonatomic, copy) NSArray *hosts;
@property (nonatomic, assign)NSInteger selectedIndex;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear {
    [super viewWillAppear];
    
}

- (void)setupUI {
    _tableview.dataSource = self;
    _tableview.delegate = (id<NSTableViewDelegate>)self;
    _tableview.target = self;
    _tableview.action = @selector(tableviewDidSelected);
    NSNib *nib = [[NSNib alloc] initWithNibNamed:[SubTitleTableCellView cellIdentifier] bundle:nil];
    [_tableview registerNib:nib forIdentifier:[SubTitleTableCellView cellIdentifier]];
}

- (NSArray <NSString *>*)displayTitles {
    NSMutableArray *titles = @[].mutableCopy;
    for (Host *h in kHOSTManager.allHosts) {
        [titles addObject:h.name];
    }
    return titles.copy;
}

- (void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:ksegueIdentifier]) {
        AddHostViewController *addHostViewController = segue.destinationController;
        addHostViewController.didChangeHosts = ^{
            [self.tableview reloadData];
        };
    }
}

- (IBAction)buttonOnclick:(NSSegmentedControl *)sender {
    if (sender.selectedSegment == 0) {
        [self performSegueWithIdentifier:ksegueIdentifier sender:nil];
    }
    if (sender.selectedSegment == 1) {
        [self.segmentedControl setEnabled:NO forSegment:1];
        [self.segmentedControl setEnabled:NO forSegment:2];
        [kHOSTManager removeHost:kHOSTManager.allHosts[self.selectedIndex]];
        [self.tableview reloadData];
    }
    if (sender.selectedSegment == 2) {
        [self.segmentedControl setEnabled:NO forSegment:1];
        [self.segmentedControl setEnabled:NO forSegment:2];
        [kHOSTManager setSelected:kHOSTManager.allHosts[self.selectedIndex]];
        [self.tableview reloadData];
    }
}

#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return kHOSTManager.allHosts.count;
}

- (nullable NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row {
    SubTitleTableCellView *cell = [tableView makeViewWithIdentifier:[SubTitleTableCellView cellIdentifier] owner:self];
    cell.titleLabel.font = [NSFont systemFontOfSize:14];
    Host *host = kHOSTManager.allHosts[row];
    cell.titleLabel.stringValue = host.name;
    cell.subTitleLabel.stringValue = host.host;
    [cell setCkeck:host.selected];
    return cell;
}


- (void)tableviewDidSelected {
    if (self.tableview.selectedRow > -1 && self.tableview.selectedRow < kHOSTManager.allHosts.count) {
        [self.segmentedControl setEnabled:YES forSegment:1];
        [self.segmentedControl setEnabled:YES forSegment:2];
        self.selectedIndex = self.tableview.selectedRow;
    }
    else {
        [self.segmentedControl setEnabled:NO forSegment:1];
        [self.segmentedControl setEnabled:NO forSegment:2];
    }
}

@end
