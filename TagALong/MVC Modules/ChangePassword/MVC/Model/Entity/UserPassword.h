//
//  UserPassword.h
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserPassword : NSObject

@property (nonatomic, strong) NSString *oldPassword;
@property (nonatomic, strong) NSString *theNewPassword;
@property (nonatomic, strong) NSString *confirmPassword;

@end
