//
//  TableViewController.m
//  iOSAuthority
//
//  Created by zhaoyang on 2018/7/10.
//  Copyright © 2018年 zhaoyang. All rights reserved.
//

#import "TableViewController.h"


@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoDark];
    button.frame = CGRectMake(0, 0, 50, 50);
    [button addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)clickAction {
    if (iOS10Later) {
        if (@available(iOS 8.0, *)) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];;
            if( [[UIApplication sharedApplication] canOpenURL:url] ) {
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:url options:@{}completionHandler:^(BOOL success) {
                    }];
                } else {
                   [[UIApplication sharedApplication] openURL:url];
                }
            }
        }
    } else {
        NSString *str = @"prefs:root=com.bankcomm.maidanba";
        NSURL *url = [NSURL URLWithString:str];
        if( [[UIApplication sharedApplication] canOpenURL:url] ) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}
@end
