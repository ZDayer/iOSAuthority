//
//  CameraAndMicrophoneViewController.m
//  iOSAuthority
//
//  Created by 大洋 on 2018/7/10.
//  Copyright © 2018年 zhaoyang. All rights reserved.
//

#import "CameraAndMicrophoneViewController.h"

#import <AVFoundation/AVFoundation.h>

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
    //相机权限
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    NSString *str = @"";
    switch (status) {
        case AVAuthorizationStatusNotDetermined:
            str = @"AVAuthorizationStatusNotDetermined";
            break;
        case AVAuthorizationStatusRestricted:
            str = @"AVAuthorizationStatusRestricted";
            break;
        case AVAuthorizationStatusDenied:
            str = @"AVAuthorizationStatusDenied";
            break;
        case AVAuthorizationStatusAuthorized:
            str = @"AVAuthorizationStatusAuthorized";
            break;
    }
    self.lab.text = [NSString stringWithFormat:@"相机 - %@", str];
}

- (IBAction)microphone:(id)sender {
    //麦克风权限
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    NSString *str = @"";
    switch (status) {
        case AVAuthorizationStatusNotDetermined:
            str = @"AVAuthorizationStatusNotDetermined";
            break;
        case AVAuthorizationStatusRestricted:
            str = @"AVAuthorizationStatusRestricted";
            break;
        case AVAuthorizationStatusDenied:
            str = @"AVAuthorizationStatusDenied";
            break;
        case AVAuthorizationStatusAuthorized:
            str = @"AVAuthorizationStatusAuthorized";
            break;
    }
    self.lab.text = [NSString stringWithFormat:@"麦克风 - %@", str];
}



- (IBAction)getCameraAuthority:(id)sender {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if (granted) {
            NSLog(@"相机权限获取成功");
        } else {
            NSLog(@"拒绝使用相机");
        }
    }];
}


- (IBAction)getMicrophoneAuthority:(id)sender {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        if (granted) {
            NSLog(@"麦克风权限获取成功");
        } else {
            NSLog(@"拒绝使用麦克风");
        }
    }];
}






- (BOOL)isCameraAvailable{
    /// 是不是有相机
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL)isFrontCameraAvailable{
    /// 前摄像头是否可用
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL)isRearCameraAvailable{
    /// 后摄像头是否可用
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}



/**
 
 @constant AVAuthorizationStatusNotDetermined
 Indicates that the user has not yet made a choice regarding whether the client can access the hardware.
 
 @constant AVAuthorizationStatusRestricted
 The client is not authorized to access the hardware for the media type. The user cannot change the client's status, possibly due to active restrictions such as parental controls being in place.
 
 @constant AVAuthorizationStatusDenied
 The user explicitly denied access to the hardware supporting a media type for the client.
 
 @constant AVAuthorizationStatusAuthorized
 The client is authorized to access the hardware supporting a media type.
 
 */
@end
