//
//  HealthViewController.m
//  iOSAuthority
//
//  Created by zhaoyang on 2018/7/12.
//  Copyright © 2018年 zhaoyang. All rights reserved.
//

#import "HealthViewController.h"
#import <HealthKit/HealthKit.h>

/**
 需要开发者账号支持 Health
 */

@interface HealthViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lab;

@end

@implementation HealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)healthAuthority:(id)sender {
    
}
- (IBAction)writeAuthority:(id)sender {

    if (![HKHealthStore isHealthDataAvailable]) {
        return;
    }
    HKHealthStore *store = [[HKHealthStore alloc] init];
    NSSet *set = [self typesToWrite];
    [store requestAuthorizationToShareTypes:set readTypes:set completion:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            NSLog(@"健康数据权限获取成功");
        } else {
            NSLog(@"error = %@" , [error localizedDescription]);
        }
    }];
    
}
- (IBAction)readAuthority:(id)sender {
}



//设置写入/共享的健康数据类型
- (NSSet *)typesToWrite {
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *distanceType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    return [NSSet setWithObjects:stepType,distanceType, nil];
}
//
////设置读写以下为设置的权限类型：
//- (NSSet *)typesToRead {
//    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
//    HKQuantityType *distanceType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
//    return [NSSet setWithObjects:stepType,distanceType, nil];
//}
//
//
//- (NSSet *)dataTypesToWrite {
//    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
//    HKQuantityType *distanceType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
//    return [NSSet setWithObjects:stepType,distanceType, nil];
//}
//
//#pragma mark - 设置读取权限
//- (NSSet *)dataTypesToRead {
//    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
//    HKQuantityType *distanceType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
//
//    return [NSSet setWithObjects:stepType,distanceType, nil];
//}

@end
