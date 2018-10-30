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
#import "YPReporterNetworkOperation.h"
#import "HostManager.h"
#import "YPReport.h"
#import "YPAppFluencyInfo.h"
#import "YPAppCrashInfo.h"
#import "TopItemView.h"
#import "DeviceInfoContentView.h"
#import "StackInfoContentView.h"
#import "ConsoleInfoContentView.h"
#import "InfoContentView.h"
#import "HeaderFooterTableCellView.h"

typedef enum : NSUInteger {
    MainViewControllerDataModeFluency,
    MainViewControllerDataModeCrash,
} MainViewControllerDataMode;

@interface MainViewController ()<NSTabViewDelegate,NSTableViewDataSource,TopItemViewDelegate,HeaderFooterTableCellViewDelegate>

@property (weak) IBOutlet NSView *leftBarView;
@property (weak) IBOutlet NSTableView *centerTableview;
@property (weak) IBOutlet NSView *seperatorView;
@property (weak) IBOutlet NSView *horizontalSeperatorView;
@property (weak) IBOutlet NSView *topBarView;

@property (weak) IBOutlet NSProgressIndicator *indicator;
@property (weak) IBOutlet NSButton *fluencySectionButton;
@property (weak) IBOutlet NSButton *crashSectionButton;
@property (weak) IBOutlet NSButton *settingSectionButton;
@property (weak) IBOutlet TopItemViewWapper *topItemView;
@property (weak) IBOutlet InfoContentViewWapper *infoContentViewWapper;

@property (nonatomic, assign) NSInteger fluencyCurrentPage;
@property (nonatomic, strong) NSMutableArray <YPAppFluencyInfo *>*fluencyInfos;
@property (nonatomic, assign) NSInteger totalFluencyInfos;
@property (nonatomic, assign) NSInteger totalCrashInfos;
@property (nonatomic, assign) NSInteger crashCurrentPage;
@property (nonatomic, strong) NSMutableArray <YPAppCrashInfo *>*crashInfos;
@property (nonatomic, assign) MainViewControllerDataMode dataMode;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self checkDefaultHost];
    [self loadData];
    _totalFluencyInfos = 0;
}

#pragma mark -- private

- (void)setupUI {
    [_leftBarView setBackroundClolor:[NSColor primaryColor]];
    _centerTableview.dataSource = self;
    _centerTableview.delegate = (id<NSTableViewDelegate>)self;
    NSNib *nib = [[NSNib alloc] initWithNibNamed:[SubTitleTableCellView cellIdentifier] bundle:nil];
    [_centerTableview registerNib:nib forIdentifier:[SubTitleTableCellView cellIdentifier]];
    NSNib *nib2 = [[NSNib alloc] initWithNibNamed:[HeaderFooterTableCellView cellIdentifier] bundle:nil];
    
    NSString *identifier ;
    identifier = [NSString stringWithFormat:@"fluency-%@-0",[HeaderFooterTableCellView cellIdentifier]];
    [_centerTableview registerNib:nib2 forIdentifier:identifier];
    identifier = [NSString stringWithFormat:@"fluency-%@-100",[HeaderFooterTableCellView cellIdentifier]];
    [_centerTableview registerNib:nib2 forIdentifier:identifier];
    identifier = [NSString stringWithFormat:@"crash-%@-0",[HeaderFooterTableCellView cellIdentifier]];
    [_centerTableview registerNib:nib2 forIdentifier:identifier];
    identifier = [NSString stringWithFormat:@"crash-%@-100",[HeaderFooterTableCellView cellIdentifier]];
    [_centerTableview registerNib:nib2 forIdentifier:identifier];
    
    [_seperatorView setBackroundClolor:[NSColor dividerColor]];
    [_horizontalSeperatorView setBackroundClolor:[NSColor dividerColor]];
    [_topBarView setBackroundClolor:[NSColor backgroundColor]];
    [self.crashSectionButton setState:NSControlStateValueOn];
    [self.fluencySectionButton setState:NSControlStateValueOff];
    self.indicator.hidden = YES;
    _centerTableview.target = self;
    _centerTableview.action = @selector(tableviewDidSelected);
    self.topItemView.delegate = self;
}

- (void)checkDefaultHost {
    if (!kHOSTManager.selectedHost) {
        return;
    }
    NSString *baseUrl = [NSString stringWithFormat:@"http://%@:8088/YPAppMonitor/",kHOSTManager.selectedHost.host];
    _YP_reporterNetworkOperation_setBaseUrl(baseUrl);
    
}

- (void)loadData {
    if (self.dataMode == MainViewControllerDataModeFluency) {
        [self loadFluenciesData];
    }
    if (self.dataMode == MainViewControllerDataModeCrash) {
        [self loadCrashesData];
    }
}

- (void)loadFluenciesData {
    if (self.fluencyCurrentPage == 0 && self.dataMode == MainViewControllerDataModeFluency) {
        [self.indicator startAnimation:self];
    }
    NSInteger fluencyRequestPage = self.fluencyCurrentPage+1;
    [YPReporterNetworkOperation fluencyWithPage:fluencyRequestPage
                                         length:100
                               completedHandler:^(NSString *msg, NSError *error) {
                                   if (self.dataMode == MainViewControllerDataModeFluency) {
                                       [self.indicator stopAnimation:self];
                                   }
                                   if(error){
                                       NSAlert *alert = [NSAlert new];
                                       [alert setMessageText:error.localizedDescription];
                                       [alert beginSheetModalForWindow:self.view.window completionHandler:nil];
                                       return ;
                                   }
                                   
                                   if (fluencyRequestPage == (self.fluencyCurrentPage+1)) {
                                       self.fluencyCurrentPage++;
                                       NSString *msgString = msg;
                                       NSDictionary *respondDict = msgString.dictionary;
                                       NSArray *fluencies = respondDict[@"data"][@"list"];
                                       self.totalFluencyInfos = [respondDict[@"data"][@"totalItem"] integerValue];
                                       // NSInteger allPage = [respondDict[@"allPage"] integerValue];
                                       // NSInteger currentPage = [respondDict[@"currentPage"] integerValue];
                                       for (NSDictionary *dict in fluencies) {
                                           YPReport *report = [[YPReport alloc] initWithDict:dict];
                                           NSString *contentString = report.content;
                                           YPAppFluencyInfo *info = [[YPAppFluencyInfo alloc] initWithDict:contentString.dictionary];
                                           [self.fluencyInfos insertObject:info atIndex:0];
                                       }
                                       [self.centerTableview reloadData];
                                   }
                               }];
}

- (void)loadCrashesData {
    if (self.crashCurrentPage == 0 && self.dataMode == MainViewControllerDataModeCrash) {
        self.indicator.hidden = NO;
        [self.indicator startAnimation:self.indicator];
    }
    NSInteger crashRequestPage = self.crashCurrentPage+1;
    [YPReporterNetworkOperation crashWithPage:crashRequestPage
                                       length:100
                             completedHandler:^(NSString *msg, NSError *error) {
                                 if (self.dataMode == MainViewControllerDataModeCrash) {
                                     self.indicator.hidden = YES;
                                     [self.indicator stopAnimation:self.indicator];
                                 }
                                 if(error){
                                     NSAlert *alert = [NSAlert new];
                                     [alert setMessageText:error.localizedDescription];
                                     [alert beginSheetModalForWindow:self.view.window completionHandler:nil];
                                     return ;
                                 }
                                 
                                 if (crashRequestPage == (self.crashCurrentPage+1)) {
                                     self.crashCurrentPage++;
                                     NSString *msgString = msg;
                                     NSDictionary *respondDict = msgString.dictionary;
                                     NSArray *crashs = respondDict[@"data"][@"list"];
                                     self.totalCrashInfos = [respondDict[@"data"][@"totalItem"] integerValue];
                                     for (NSDictionary *dict in crashs) {
                                         YPReport *report = [[YPReport alloc] initWithDict:dict];
                                         NSString *contentString = report.content;
                                         YPAppCrashInfo *info = [[YPAppCrashInfo alloc] initWithDict:contentString.dictionary];
                                         [self.crashInfos addObject:info];
                                     }
                                     if (self.dataMode == MainViewControllerDataModeCrash) {
                                         [self.centerTableview reloadData];
                                     }
                                 }
                             }];
}

- (HeaderFooterTableCellView *)setupHeaderFooterViewCellWithTableView:(NSTableView *)tableview
                                                                  row:(NSInteger)row {
    NSString *identifier ;
    if (self.dataMode == MainViewControllerDataModeFluency) {
        if (row == 0) {
            identifier = [NSString stringWithFormat:@"fluency-%@-%ld",[HeaderFooterTableCellView cellIdentifier],row];
        }
        else {
            identifier = [NSString stringWithFormat:@"fluency-%@-100",[HeaderFooterTableCellView cellIdentifier]];
        }
    }
    else {
        if (row == 0) {
            identifier = [NSString stringWithFormat:@"crash-%@-%ld",[HeaderFooterTableCellView cellIdentifier],row];
        }
        else {
            identifier = [NSString stringWithFormat:@"crash-%@-100",[HeaderFooterTableCellView cellIdentifier]];
        }
    }
    HeaderFooterTableCellView *headViewCell = [tableview makeViewWithIdentifier:identifier owner:self];
    [headViewCell configTypeWithTableViewRow:row];
    headViewCell.delegate = self;
    headViewCell.state = HeaderFooterTableCellViewStateNormal;
    return headViewCell;
}

#pragma mark - set && get

- (NSMutableArray <YPAppFluencyInfo *>*)fluencyInfos {
    if (!_fluencyInfos) {
        _fluencyInfos = @[].mutableCopy;
    }
    return _fluencyInfos;
}

- (NSMutableArray <YPAppCrashInfo *>*)crashInfos {
    if (!_crashInfos) {
        _crashInfos = @[].mutableCopy;
    }
    return _crashInfos;
}

#pragma mark - action

- (IBAction)buttonOnclick:(NSButton *)sender {
    if (sender == self.fluencySectionButton) {
        [sender setState:NSControlStateValueOff];
        [self.crashSectionButton setState:NSControlStateValueOn];
        self.dataMode = MainViewControllerDataModeFluency;
        [self.centerTableview reloadData];
    }
    if (sender == self.crashSectionButton) {
        [sender setState:NSControlStateValueOff];
        [self.fluencySectionButton setState:NSControlStateValueOn];
        self.dataMode = MainViewControllerDataModeCrash;
        [self.centerTableview reloadData];
    }
    
}

#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    if (self.dataMode == MainViewControllerDataModeFluency) {
        return (self.fluencyInfos.count == 0) ? 1 : self.fluencyInfos.count+2;
    }
    else {
        return (self.crashInfos.count == 0) ? 1 : self.crashInfos.count+2;
    }
}

- (nullable NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row {
    
    SubTitleTableCellView *cell = [tableView makeViewWithIdentifier:[SubTitleTableCellView cellIdentifier] owner:self];
    if (self.dataMode == MainViewControllerDataModeFluency) {
        if (row == 0) {
            return [self setupHeaderFooterViewCellWithTableView:tableView row:row];
        }
        if (self.fluencyInfos.count > 0 && row == self.fluencyInfos.count +1 ) {
            HeaderFooterTableCellView *headViewCell = [self setupHeaderFooterViewCellWithTableView:tableView row:row];
            if (self.totalFluencyInfos == self.fluencyInfos.count) {
                headViewCell.state = HeaderFooterTableCellViewStateDisable;
            }
            return headViewCell;
        }
        
        YPAppFluencyInfo *info = self.fluencyInfos[row-1];
        cell.titleLabel.stringValue = info.name;
        cell.subTitleLabel.stringValue = info.time;
    }
    if (self.dataMode == MainViewControllerDataModeCrash) {
        if (row == 0) {
            return [self setupHeaderFooterViewCellWithTableView:tableView row:row];
        }
        if (self.crashInfos.count > 0 && row == self.crashInfos.count +1 ) {
            HeaderFooterTableCellView *headViewCell = [self setupHeaderFooterViewCellWithTableView:tableView row:row];
            if (self.totalCrashInfos == self.crashInfos.count) {
                headViewCell.state = HeaderFooterTableCellViewStateDisable;
            }
            return headViewCell;
        }
        
        YPAppCrashInfo *info = self.crashInfos[row-1];
        cell.titleLabel.stringValue = info.name;
        cell.subTitleLabel.stringValue = info.time;
    }
    return cell;
}

- (void)tableviewDidSelected {
    if (self.dataMode == MainViewControllerDataModeFluency) {
        if (self.centerTableview.selectedRow == 0) {
            return;
        }
        if (self.fluencyInfos.count > 0 && self.centerTableview.selectedRow == self.fluencyInfos.count + 1 ) {
            return;
        }
        YPAppFluencyInfo *report = self.fluencyInfos[self.centerTableview.selectedRow-1];
        [self.infoContentViewWapper setData:report];
    }
    if (self.dataMode == MainViewControllerDataModeCrash) {
        if (self.centerTableview.selectedRow == 0) {
            return;
        }
        if (self.crashInfos.count > 0 && self.centerTableview.selectedRow == self.crashInfos.count + 1 ) {
            return;
        }
        YPAppCrashInfo *report = self.crashInfos[self.centerTableview.selectedRow-1];
        [self.infoContentViewWapper setData:report];
    }
}

#pragma mark - TopItemViewDelegate

- (void)topItemViewDidTapButtonAtIndex:(NSInteger)index {
    [self.infoContentViewWapper selectedAtIndex:index];
}

#pragma mark - HeaderFooterTableCellViewDelegate

- (void)HeaderFooterTableCellView:(HeaderFooterTableCellView *)cell didTouchButtonWithType:(HeaderFooterTableCellViewType)type {
    if (self.dataMode == MainViewControllerDataModeFluency) {
        if (type == HeaderFooterTableCellViewType1) {
            self.fluencyCurrentPage = 0;
            [self.fluencyInfos removeAllObjects];
            [self.centerTableview reloadData];
            cell.state = HeaderFooterTableCellViewStateDisable;
            [self loadFluenciesData];
        }
        if (type == HeaderFooterTableCellViewType2) {
            cell.state = HeaderFooterTableCellViewStateLoading;
            [self loadFluenciesData];
        }
    }
    if (self.dataMode == MainViewControllerDataModeCrash) {
        if (type == HeaderFooterTableCellViewType1) {
            self.crashCurrentPage = 0;
            [self.crashInfos removeAllObjects];
            [self.centerTableview reloadData];
            cell.state = HeaderFooterTableCellViewStateDisable;
            [self loadCrashesData];
        }
        if (type == HeaderFooterTableCellViewType2) {
            cell.state = HeaderFooterTableCellViewStateLoading;
            [self loadCrashesData];
        }
    }
}



@end
