//
//  ProUserProfileMapper.m
//  TagALong
//
//  Created by User on 7/18/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserProfileMapper.h"
#import "ProUserProfile.h"
#import "NSString+Validation.h"

@implementation ProUserProfileMapper

+ (ProUserProfile*)proUserProfileFromJSON:(NSDictionary*)json {
    
    ProUserProfile *profile = [ProUserProfile new];
    
    profile.firstName = json[@"export_nck_nm"];
    profile.lastName = json[@"export_last_name"];
    profile.phoneNumber = json[@"export_phone"];
    profile.uid = json[@"export_uid"];
    profile.latitude = json[@"latitude"];
    profile.longitude = json[@"longitude"];
    profile.level = json[@"level"];
    profile.location = json[@"location"];
    profile.profileImageURL = json[@"profile_img"];
    profile.sport = json[@"sport_uid"];
    profile.awards = json[@"awards"];
    
    return profile;
}

+ (NSDictionary*)jsonFromProUserProfile:(ProUserProfile*)profile {
    
    NSMutableDictionary *json = [NSMutableDictionary dictionary];
    
    if (!profile.firstName.isEmpty) {
        [json setObject:profile.firstName forKey:@"export_nck_nm"];
    }
    if (!profile.lastName.isEmpty) {
        [json setObject:profile.lastName forKey:@"export_last_name"];
    }
    if (!profile.phoneNumber.isEmpty) {
        [json setObject:profile.phoneNumber forKey:@"export_phone"];
    }
    if (profile.latitude) {
        [json setObject:profile.latitude forKey:@"latitude"];
    }
    if (profile.longitude) {
        [json setObject:profile.longitude forKey:@"longitude"];
    }
    if (!profile.location.isEmpty) {
        [json setObject:profile.location forKey:@"location"];
    }
    if (!profile.profileImageURL.isEmpty) {
        [json setObject:profile.profileImageURL forKey:@"profile_img"];
    }
    if (!profile.awards.isEmpty) {
        [json setObject:profile.awards forKey:@"awards"];
    }
    
    return json;
}

@end
