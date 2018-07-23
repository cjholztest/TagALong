//
//  SimpleUserProfileMapper.m
//  TagALong
//
//  Created by User on 7/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SimpleUserProfileMapper.h"
#import "SimpleUserProfile.h"
#import "NSString+Validation.h"

@implementation SimpleUserProfileMapper

+ (SimpleUserProfile*)simpleUserProfileFromJSON:(NSDictionary*)json {
    
    SimpleUserProfile *profile = [SimpleUserProfile new];
    
    profile.firstName = json[@"usr_nck_nm"];
    profile.lastName = json[@"usr_last_name"];
    profile.phoneNumber = json[@"usr_phone"];
    profile.uid = json[@"usr_uid"];
    profile.location = json[@"location"];
    profile.profileImageURL = json[@"profile_img"];
    
    return profile;
}

+ (NSDictionary*)jsonFromSimpleUserProfile:(SimpleUserProfile*)profile {
    
    NSMutableDictionary *json = [NSMutableDictionary dictionary];
    
    if (!profile.firstName.isEmpty) {
        [json setObject:profile.firstName forKey:@"usr_nck_nm"];
    }
    if (!profile.lastName.isEmpty) {
        [json setObject:profile.lastName forKey:@"usr_last_name"];
    }
    if (!profile.phoneNumber.isEmpty) {
        [json setObject:profile.phoneNumber forKey:@"usr_phone"];
    }
    if (!profile.profileImageURL.isEmpty) {
        [json setObject:profile.profileImageURL forKey:@"profile_img"];
    }
    
    return json;
}

@end
