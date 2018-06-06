//
//  ProfilePaymentCredentials.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/26/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfilePaymentCredentials : NSObject

@property (nonatomic, assign) NSInteger birtdayDay;
@property (nonatomic, assign) NSInteger birtdayMonth;
@property (nonatomic, assign) NSInteger birtdayYear;

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSDate *birthdayDate;;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) NSInteger postalCode;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;

@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *ssnLast;

- (NSDictionary*)paramsCredentials;
- (void)updateBirthdayByDate:(NSDate*)date;
- (NSString*)checkedCredentialsMessage;

@end
