//
//  BluethoothViewController.m
//  iOSAuthority
//
//  Created by zhaoyang on 2018/7/12.
//  Copyright © 2018年 zhaoyang. All rights reserved.
//

#import "BluethoothViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface BluethoothViewController ()<CBCentralManagerDelegate>
@property(strong,nonatomic)CBCentralManager* CM;
@end

@implementation BluethoothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self checkBluetoothAccess];
    self.CM = [[CBCentralManager alloc] initWithDelegate:self queue:nil];

    
}



- (IBAction)checkBluetoothAccess {
//    CBCentralManager *cbManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}


/// 初始化后会自动调用代理方法
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    NSLog(@"%ld", (long)central.state);
    if(central.state == CBManagerStateUnknown) {
        NSLog(@"Unknown!");
    }
    else if(central.state == CBManagerStateUnauthorized) {
        NSLog(@"Unauthorized!");
    }
    else {
        NSLog(@"Granted!");
    }
}



- (IBAction)requestBluetoothAccess {
//    CBCentralManager *cbManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
//    //该方法会显示用户同意的弹窗
    [self.CM scanForPeripheralsWithServices:nil options:nil];
}

@end
