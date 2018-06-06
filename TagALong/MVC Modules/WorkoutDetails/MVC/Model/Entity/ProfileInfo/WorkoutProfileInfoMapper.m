//
//  WorkoutProfileInfoMapper.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/30/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "WorkoutProfileInfoMapper.h"
#import "WorkoutProfileInfoDataModel.h"

@implementation WorkoutProfileInfoMapper

+ (WorkoutProfileInfoDataModel*)profileInfoFromJSON:(NSDictionary*)json {
    
    WorkoutProfileInfoDataModel *model = [WorkoutProfileInfoDataModel new];
    
    model.email = json[@"email"];
    model.firstName = json[@"nickname"];
    model.lastName = json[@"lastname"];
    model.level = json[@"level"];
    model.location = json[@"location"];
    model.phoneNumber = json[@"phonenum"];
    model.profileIconURL = json[@"profile_img"];
    
    return model;
}

@end
