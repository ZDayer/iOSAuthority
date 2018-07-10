//
//  NetAuthorityViewController.m
//  iOSAuthority
//
//  Created by zhaoyang on 2018/7/10.
//  Copyright © 2018年 zhaoyang. All rights reserved.
//

#import "NetAuthorityViewController.h"
// 网络权限
#import <CoreTelephony/CTCellularData.h> // 网络权限

@interface NetAuthorityViewController ()

@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation NetAuthorityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"网络权限";
}

- (IBAction)networkAuthority:(id)sender {
    if (iOS9Later) {
        // 网络权限判断在 9.0 系统以后使用
        if (@available(iOS 9.0, *)) {
            __weak __typeof(self)weakSelf = self;
            CTCellularData *ctCellularData = [[CTCellularData alloc] init];
            ctCellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
                NSString *stateStr = @"";
                switch (state) {
                    case kCTCellularDataRestrictedStateUnknown:
                        //未知情况
                        stateStr = @"kCTCellularDataRestrictedStateUnknown";
                        break;
                    case kCTCellularDataRestricted:
                        //权限关闭的情况下 再次请求网络数据会弹出设置网络提示
                        stateStr = @"kCTCellularDataRestricted";
                        break;
                    case kCTCellularDataNotRestricted:
                        //已经开启网络权限
                        stateStr = @"kCTCellularDataNotRestricted";
                        break;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.stateLab.text = stateStr;
                });
            };
        }
    }
}





- (IBAction)networkRequest:(id)sender {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531210676225&di=7858e63deea225742188bee4fba16633&imgtype=0&src=http%3A%2F%2Fwww.usnook.com%2Fuploads%2F140924%2F79-140924163T9557.jpg"]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imgView.image = img;
        });
    });
}


/**
 kCTCellularDataRestrictedStateUnknown,//权限未知
 kCTCellularDataRestricted,//权限被关闭，
 kCTCellularDataNotRestricted//权限开启
 
 CTCellularData  只能检测蜂窝权限，不能检测WiFi权限。
 当用户在设置里更改了app的权限时，cellularDataRestrictionDidUpdateNotifier会收到回调
 
 在用户没有权限的时候APP会自动弹出重新选择网络权限以及说明的弹窗，进入设置修改过APP联网权限以后选择回到APP就会触发
 cellularDataRestrictionDidUpdateNotifier，在回调里处理相关内容
 
 如果要停止监听，必须将cellularDataRestrictionDidUpdateNotifier设置为nil。
 
 /// 待确认
 赋值给cellularDataRestrictionDidUpdateNotifier的block并不会自动释放，
 即便你给一个局部变量的CTCellularData实例设置监听，当权限更改时，还是会收到回调，所以记得将block置nil。

 */


@end
