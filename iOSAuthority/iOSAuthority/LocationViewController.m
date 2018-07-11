//
//  LocationViewController.m
//  iOSAuthority
//
//  Created by zhaoyang on 2018/7/11.
//  Copyright © 2018年 zhaoyang. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface LocationViewController ()<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *authorityLab;
@property (weak, nonatomic) IBOutlet UILabel *locationLab;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"定位权限";
    
    [self.locationManager startUpdatingLocation];
    
}

// 在代理方法中查看权限是否改变
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSString *str = @"";
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            str = @"kCLAuthorizationStatusNotDetermined";
            break;
        case kCLAuthorizationStatusRestricted:
            str = @"kCLAuthorizationStatusRestricted";
            break;
        case kCLAuthorizationStatusDenied:
            str = @"kCLAuthorizationStatusDenied";
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            str = @"kCLAuthorizationStatusAuthorizedAlways";
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            str = @"kCLAuthorizationStatusAuthorizedWhenInUse";
            break;
    }
    NSLog(@"%@", str);
}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    // 获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度:%f, 精度:%f", coordinate.latitude, coordinate.longitude);
    [self reverseGeocode:location];
    [manager stopUpdatingLocation];
}

- (void)reverseGeocode:(CLLocation *)location {
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        // 如果没有数据或者有错误
        if (!placemarks.count || error) { self.locationLab.text = @"定位错误"; return; }
        
        // 取出 CLPlacemark
        CLPlacemark *pm = placemarks.firstObject;
        if (pm.locality == nil) {
            // 城市是自治区的时候
            self.locationLab.text = pm.administrativeArea;
        } else {
            self.locationLab.text = pm.locality;
        }
        
        NSLog(@" name = %@", pm.name);
        NSLog(@" thoroughfare = %@", pm.thoroughfare);
        NSLog(@" subThoroughfare = %@", pm.subThoroughfare);
        NSLog(@" locality = %@", pm.locality);
        NSLog(@" subLocality = %@", pm.subLocality);
        NSLog(@" administrativeArea = %@", pm.administrativeArea);
        NSLog(@" subAdministrativeArea = %@", pm.subAdministrativeArea);
        NSLog(@" postalCode = %@", pm.postalCode);
        NSLog(@" ISOcountryCode = %@", pm.ISOcountryCode);
        NSLog(@" country = %@", pm.country);
        NSLog(@" inlandWater = %@", pm.inlandWater);
        NSLog(@" ocean = %@", pm.ocean);
        
        
    }];
}


- (IBAction)locationAuthority:(id)sender {
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"无法定位");
        return;
    }
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    NSString *str = @"";
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            str = @"kCLAuthorizationStatusNotDetermined";
            break;
        case kCLAuthorizationStatusRestricted:
            str = @"kCLAuthorizationStatusRestricted";
            break;
        case kCLAuthorizationStatusDenied:
            str = @"kCLAuthorizationStatusDenied";
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            str = @"kCLAuthorizationStatusAuthorizedAlways";
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            str = @"kCLAuthorizationStatusAuthorizedWhenInUse";
            break;
    }
    
    self.authorityLab.text = str;
}

- (IBAction)location:(id)sender {
    CLLocationManager *manager = [[CLLocationManager alloc] init];
//    if (@available(iOS 9.0, *)) {
//        [manager requestLocation];
//    } else if (@available(iOS 8.0, *)) {
        [manager requestAlwaysAuthorization];
//    }
}


- (IBAction)locationWhenUse:(id)sender {
    CLLocationManager *manager = [[CLLocationManager alloc] init];
//    if (@available(iOS 9.0, *)) {
//        [manager requestLocation];
//    } else if (@available(iOS 8.0, *)) {
        [manager requestWhenInUseAuthorization];
//    }
}



- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    }
    return _locationManager;
}


- (CLGeocoder *)geocoder {
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

/**
 requestLocation 作用：
 按照定位精确度从低到高进行排序，逐个进行定位。如果获取到的位置不是精确度最高的那个，也会在定位超时后，通过代理告诉外界（必须实现代理的-locationManager:didFailWithError:方法）
 不能与startUpdatingLocation方法同时使用
 */
@end
