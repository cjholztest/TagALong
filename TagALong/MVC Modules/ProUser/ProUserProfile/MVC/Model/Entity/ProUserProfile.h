//
//  ProUserProfile.h
//  TagALong
//
//  Created by User on 7/18/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProUserProfile : NSObject

@property (nonatomic, strong) NSString *uid;

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *phoneNumber;

@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *location;

@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *latitude;

@property (nonatomic, strong) NSString *profileImageURL;

@property (nonatomic, strong) NSString *sport;
@property (nonatomic, strong) NSString *awards;

@property (nonatomic, strong) NSString *creditCardData;
@property (nonatomic, strong) NSString *debitCardData;

@property (nonatomic, assign) BOOL bankCredetialsExisted;

@end
