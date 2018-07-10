//
//  AddHostViewController.m
//  YPAPPMonitorViewer
//
//  Created by ZYP on 2018/7/9.
//  Copyright © 2018年 ZYP. All rights reserved.
//

#import "AddHostViewController.h"
#import "HostManager.h"
#import "APPExtension.h"

@interface AddHostViewController ()

@property (weak) IBOutlet NSTextField *hostTextField;
@property (weak) IBOutlet NSTextField *nameTextFiled;
@property (weak) IBOutlet NSButton *cancleButton;
@property (weak) IBOutlet NSButton *submitButton;

@end

NSString * const ksegueIdentifier = @"AddHostViewController";

@implementation AddHostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - private

- (void)saveTask {
    Host *h = [Host new];
    h.host = self.hostTextField.stringValue;
    h.name = self.nameTextFiled.stringValue;
    [kHOSTManager insertHost:h];
    [self dismissViewController:self];
    if (self.didChangeHosts) { self.didChangeHosts();}
}

#pragma mark - action

- (IBAction)buttonOnclick:(NSButton *)sender {
    if (sender == self.cancleButton) {
        [self dismissViewController:self];
        return;
    }
    if (sender == self.submitButton) {
        if (!self.hostTextField.stringValue.isVaildHost || !self.nameTextFiled.stringValue.isVaildCustomedHostName) {
            NSAlert *alert = [NSAlert new];
            [alert setMessageText:@"host string length must more than 8,and name string length must more than 1"];
            [alert beginSheetModalForWindow:self.view.window completionHandler:nil];
            return;
        }
        [self saveTask];
        return;
    }
}

@end
