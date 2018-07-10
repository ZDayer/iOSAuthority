//
//  CameraAndMicrophoneViewController.m
//  iOSAuthority
//
//  Created by 大洋 on 2018/7/10.
//  Copyright © 2018年 zhaoyang. All rights reserved.
//

#import "CameraAndMicrophoneViewController.h"

@interface CameraAndMicrophoneViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lab;

@end

@implementation CameraAndMicrophoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"相机、麦克风";
}
- (IBAction)camera:(id)sender {
}
- (IBAction)microphone:(id)sender {
}

@end
