//
//  ProUserSignUpDataModel.h
//  TagALong
//
//  Created by User on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProUserSignUpDataModel : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;

@property (nonatomic, strong) NSString *eMail;
@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *confirmPassword;

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *sport;
@property (nonatomic) NSInteger *sportIndex;

@property (nonatomic, strong) NSString *additionalInfo;
@property (nonatomic, strong) NSString *awards;

@property (nonatomic, assign) BOOL isPhoneVisible;

@end
