//
//  PhotoViewController.m
//  iOSAuthority
//
//  Created by zhaoyang on 2018/7/10.
//  Copyright © 2018年 zhaoyang. All rights reserved.
//

#import "PhotoViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

typedef NS_ENUM(NSUInteger, PhotoStatus) {
    PhotoStatusNotDetermined,
    PhotoStatusDenied,
    PhotoStatusAuthorized
};


@interface PhotoViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"相册权限";
}



- (IBAction)pickPhoto:(id)sender {
    PhotoStatus status = [self checkPhotoAuthority];
    if (status == PhotoStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"您未给相册权限, 请在设置中打开" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } else if (status == PhotoStatusAuthorized) {
        // 去选择图片
        [self choosePhoto];
    } else {
        if (iOS8Later) { // 提醒
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    // 用户点击了允许, 去相册选取图片
                    [self choosePhoto];
                }
            }];
        }
    }
}




- (PhotoStatus)checkPhotoAuthority {
    
    if (iOS8Later&&!iOS11Later) {
        // 该API在 iOS 8.0 系统 以后使用
        // 在 iOS 11.0 系统以上时, 读取相册中的内容不需要权限, 向相册中写入数据才需要权限
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        switch (status) {
            case PHAuthorizationStatusNotDetermined:    return PhotoStatusNotDetermined; break;
            case PHAuthorizationStatusRestricted:       return PhotoStatusDenied; break;
            case PHAuthorizationStatusDenied:           return PhotoStatusDenied; break;
            case PHAuthorizationStatusAuthorized:       return PhotoStatusAuthorized; break;
        }
    }
    else if (!iOS9Later) {
        // 该 API 在 iOS 9.0 系统一下使用
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        switch (status) {
            case ALAuthorizationStatusNotDetermined:    return PhotoStatusNotDetermined; break;
            case ALAuthorizationStatusRestricted:       return PhotoStatusDenied; break;
            case ALAuthorizationStatusDenied:           return PhotoStatusDenied; break;
            case ALAuthorizationStatusAuthorized:       return PhotoStatusAuthorized; break;
        }
    }
    return PhotoStatusDenied;
}


- (void)choosePhoto {
    UIImagePickerController *imgPickerVC = [[UIImagePickerController alloc] init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        imgPickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imgPickerVC.delegate = self;
    
    [self presentViewController:imgPickerVC animated:YES completion:^{}];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imgView.image = img;
        });
    }];
}


/**
 
 // 用户还没有关于这个应用程序做出了选择
 // User has not yet made a choice with regards to this application
 PHAuthorizationStatusNotDetermined = 0,
 
 // 这个应用程序未被授权访问图片数据。用户不能更改该应用程序的状态,可能是由于活动的限制,如家长控制到位。
 // This application is not authorized to access photo data.
 // The user cannot change this application’s status, possibly due to active restrictions
 //   such as parental controls being in place.
 PHAuthorizationStatusRestricted,
 
 // 用户已经不允许了这个应用程序访问图片数据
 // User has explicitly denied this application access to photos data.
 PHAuthorizationStatusDenied,
 
 // 用户授权此应用程序访问图片数据
 // User has authorized this application to access photos data.
 PHAuthorizationStatusAuthorized
 */

/**

 // 用户还没有关于这个应用程序做出了选择
 // User has not yet made a choice with regards to this application
 ALAuthorizationStatusNotDetermined NS_ENUM_DEPRECATED_IOS(6_0, 9_0) = 0,
 
 // 这个应用程序未被授权访问图片数据。用户不能更改该应用程序的状态,可能是由于活动的限制,如家长控制到位。
 // This application is not authorized to access photo data.
 // The user cannot change this application’s status, possibly due to active restrictions
 //  such as parental controls being in place.
 ALAuthorizationStatusRestricted NS_ENUM_DEPRECATED_IOS(6_0, 9_0),
 
 // 用户已经不允许了这个应用程序访问图片数据
 // User has explicitly denied this application access to photos data.
 ALAuthorizationStatusDenied NS_ENUM_DEPRECATED_IOS(6_0, 9_0),
 
 // 用户授权此应用程序访问图片数据
 // User has authorized this application to access photos data.
 ALAuthorizationStatusAuthorized NS_ENUM_DEPRECATED_IOS(6_0, 9_0)
*/
@end
