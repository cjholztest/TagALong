//
//  RegularUserInfoMapper.m
//  TagALong
//
//  Created by Nikita Vintonovich on 6/5/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "RegularUserInfoMapper.h"
#import "RegularUserInfoDataModel.h"

@implementation RegularUserInfoMapper

+ (RegularUserInfoDataModel*)regularUserInfoFromJSON:(NSDictionary*)json {
    
    RegularUserInfoDataModel *user = [RegularUserInfoDataModel new];
    
    user.userUID = json[@"usr_uid"];
    
    user.firstName = json[@"usr_nck_nm"];
    user.lastName = json[@"usr_last_name"];
    user.location = json[@"location"];
    user.profileIconURL = json[@"profile_img"];
    user.phoneNumber = json[@"usr_phone"];
    
    id level = json[@"level"];
    user.level = level ? level : @(0);
    
    user.hidePhone = [json[@"hide_phone"] boolValue];
    
    return user;
}

+ (RegularUserInfoDataModel*)proUserInfoFromJSON:(NSDictionary*)json {
    
    RegularUserInfoDataModel *user = [RegularUserInfoDataModel new];
    
    user.userUID = json[@"export_uid"];
    
    user.firstName = json[@"export_nck_nm"];
    user.lastName = json[@"export_last_name"];
    user.location = json[@"location"];
    user.profileIconURL = json[@"profile_img"];
    user.phoneNumber = json[@"export_phone"];
    
    id level = json[@"level"];
    user.level = level ? level : @(0);
    
    NSNumber *phoneHide = json[@"hide_phone"];
    user.hidePhone = phoneHide.boolValue;
    
    return user;
}

@end
