//
//  ProUserSignUpDataModel.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Birthday.h"

@interface ProUserSignUpDataModel : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;

@property (nonatomic, strong) NSString *eMail;
@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *confirmPassword;

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *sport;
@property (nonatomic, assign) NSInteger sportIndex;

@property (nonatomic, strong) NSString *additionalInfo;
@property (nonatomic, strong) NSString *awards;

@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *sportActivity;

@property (nonatomic, strong) NSString *gender;
@property (nonatomic, assign) NSInteger genderIndex;

@property (nonatomic, assign) BOOL isPhoneVisible;
@property (nonatomic, assign) CLLocationCoordinate2D location;

@property (nonatomic, strong) Birthday *birthday;

@end
