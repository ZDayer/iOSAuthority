//
//  AddressBookViewController.m
//  iOSAuthority
//
//  Created by zhaoyang on 2018/7/11.
//  Copyright © 2018年 zhaoyang. All rights reserved.
//

#import "AddressBookViewController.h"
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
@interface AddressBookViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lab;

@end

@implementation AddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)authority:(id)sender {
    NSString *str = @"通讯录权限";
    if (iOS9Later) {
        if (@available(iOS 9.0, *)) {
            CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
            
            switch (status) {
                case CNAuthorizationStatusNotDetermined:
                    str = @"CNAuthorizationStatusNotDetermined";
                    break;
                case CNAuthorizationStatusRestricted:
                    str = @"CNAuthorizationStatusRestricted";
                    break;
                case CNAuthorizationStatusDenied:
                    str = @"CNAuthorizationStatusDenied";
                    break;
                case CNAuthorizationStatusAuthorized:
                    str = @"CNAuthorizationStatusAuthorized";
                    break;
            }
            
        }
    } else {
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        switch (status) {
            case kABAuthorizationStatusNotDetermined:
                str = @"kABAuthorizationStatusNotDetermined";
                break;
            case kABAuthorizationStatusRestricted:
                str = @"kABAuthorizationStatusRestricted";
                break;
            case kABAuthorizationStatusDenied:
                str = @"kABAuthorizationStatusDenied";
                break;
            case kABAuthorizationStatusAuthorized:
                str = @"kABAuthorizationStatusAuthorized";
                break;
        }
    }
    self.lab.text = str;
}

/**
kABAuthorizationStatusNotDetermined = 0,    // deprecated, use CNAuthorizationStatusNotDetermined
kABAuthorizationStatusRestricted,           // deprecated, use CNAuthorizationStatusRestricted
kABAuthorizationStatusDenied,               // deprecated, use CNAuthorizationStatusDenied
kABAuthorizationStatusAuthorized            // deprecated, use CNAuthorizationStatusAuthorized
*/

- (IBAction)getAuthority:(id)sender {
    if (iOS9Later) {
        if (@available(iOS 9.0, *)) {
            CNContactStore *contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    NSLog(@"Authorized");
                }else{
                    NSLog(@"Denied or Restricted");
                }
            }];
        } 
    } else {
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if (granted) {
                NSLog(@"Authorized");
                CFRelease(addressBook);
            } else {
                NSLog(@"Denied or Restricted");
                CFRelease(addressBook);
            }
        });
        
    }
}

@end
