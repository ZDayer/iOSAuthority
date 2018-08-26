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
   
    
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if( [[UIApplication sharedApplication] canOpenURL:url] ) {
        if (iOS10Later) {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }

}


/**
 
 升到iOS10之后，需要设置权限的有：
 
 麦克风权限：Privacy - Microphone Usage Description 是否允许此App使用你的麦克风？
 
 相机权限： Privacy - Camera Usage Description 是否允许此App使用你的相机？
 
 相册权限： Privacy - Photo Library Usage Description 是否允许此App访问你的媒体资料库？
 
 通讯录权限： Privacy - Contacts Usage Description 是否允许此App访问你的通讯录？
 
 蓝牙权限：Privacy - Bluetooth Peripheral Usage Description 是否许允此App使用蓝牙？
 
 语音转文字权限：Privacy - Speech Recognition Usage Description 是否允许此App使用语音识别？
 
 日历权限：Privacy - Calendars Usage Description
 
 定位权限：Privacy - Location When In Use Usage Description
 
 定位权限: Privacy - Location Always Usage Description
 
 位置权限：Privacy - Location Usage Description
 
 媒体库权限：Privacy - Media Library Usage Description
 
 健康分享权限：Privacy - Health Share Usage Description
 
 健康更新权限：Privacy - Health Update Usage Description
 
 运动使用权限：Privacy - Motion Usage Description
 
 音乐权限：Privacy - Music Usage Description
 
 提醒使用权限：Privacy - Reminders Usage Description
 
 Siri使用权限：Privacy - Siri Usage Description
 
 电视供应商使用权限：Privacy - TV Provider Usage Description
 
 视频用户账号使用权限：Privacy - Video Subscriber Account Usage Description
 
 
 */
@end
