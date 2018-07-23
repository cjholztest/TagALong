//
//  SimpleUserProfile.h
//  TagALong
//
//  Created by User on 7/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimpleUserProfile : NSObject

@property (nonatomic, strong) NSString *uid;

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *phoneNumber;

@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *location;

@property (nonatomic, strong) NSString *profileImageURL;;

@property (nonatomic, strong) NSString *creditCardData;

@end
