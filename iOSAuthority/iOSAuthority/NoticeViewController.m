//
//  NoticeViewController.m
//  iOSAuthority
//
//  Created by zhaoyang on 2018/7/11.
//  Copyright © 2018年 zhaoyang. All rights reserved.
//

#import "NoticeViewController.h"

@interface NoticeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *notiLab;

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"通知权限";
}

- (IBAction)noticationAuthority:(id)sender {
    UIUserNotificationSettings *settings = [UIApplication sharedApplication].currentUserNotificationSettings;
    NSString *str = @"";
    NSLog(@"%lu", (unsigned long)settings.types);
    switch (settings.types) {
        case UIUserNotificationTypeNone:
            str = @"UIUserNotificationTypeNone";
            break;
        case UIUserNotificationTypeBadge:
            str = @"UIUserNotificationTypeBadge";
            break;
        case UIUserNotificationTypeSound:
            str = @"UIUserNotificationTypeSound";
            break;
        case UIUserNotificationTypeAlert:
            str = @"UIUserNotificationTypeAlert";
            break;
        case UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert:
            str = @"all";
            break;
    }
    self.notiLab.text = str;
}

/**
UIUserNotificationTypeNone    = 0,      // the application may not present any UI upon a notification being received
UIUserNotificationTypeBadge   = 1 << 0, // the application may badge its icon upon a notification being received
UIUserNotificationTypeSound   = 1 << 1, // the application may play a sound upon a notification being received
UIUserNotificationTypeAlert   = 1 << 2, // the application may display an alert upon a notification being received
*/


- (IBAction)getAuthority:(id)sender {
    
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
}

@end
