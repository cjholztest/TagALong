//
//  WorkoutDetailsMapper.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "WorkoutDetailsMapper.h"
#import "WorkoutDetailsDataModel.h"

@implementation WorkoutDetailsMapper

+ (WorkoutDetailsDataModel*)workoutDetailsFromJSON:(NSDictionary*)json {
    
    WorkoutDetailsDataModel *model = [WorkoutDetailsDataModel new];
    
    model.amount = json[@"amount"];
    
    NSString *categories = json[@"categories"];
    model.categories = [categories componentsSeparatedByString:@","];
    
    model.duration = json[@"duration"];
    model.location = json[@"location"];
    
    model.latitude = json[@"latitude"];
    model.longitude = json[@"longitude"];
    
    model.postType = json[@"post_type"];
    model.postUID = json[@"post_uid"];
    
    model.isPrivate = json[@"private"];
    model.sportUID = json[@"sport_uids"];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"h:mm a";
    
    NSString *startTimeString = json[@"start_time"];
    
    model.startTimeString = startTimeString.uppercaseString;
    model.startTime = [formatter dateFromString:model.startTimeString];
    
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *workoutDateString = json[@"workout_date"];
    model.workoutDate = [formatter dateFromString:workoutDateString];
    
    model.status = json[@"status"];
    model.repeat = json[@"workout_repeat"];
    
    model.repeatsUID = json[@"workout_repeats_uid"];
    model.uid = json[@"workout_uid"];
    
    model.title = json[@"title"];
    model.additionalInfo = json[@"addition"];
    
    return model;
}

+ (NSDictionary*)jsonFromWorkoutDetails:(WorkoutDetailsDataModel*)workoutDetails {
    
    NSMutableDictionary *json = [NSMutableDictionary dictionary];
    
    [json setObject:Global.g_user.user_login forKey:API_REQ_KEY_LOGIN_TYPE];
    
    if (workoutDetails.sportUID) {
        [json setObject:workoutDetails.sportUID forKey:API_REQ_KEY_SPORT_UID];
    }
    
    if (workoutDetails.categories.count > 0) {
        NSMutableString *categoriesString = [NSMutableString stringWithString:workoutDetails.categories.firstObject];
        for (NSInteger i = 1; i < workoutDetails.categories.count; i++) {
            NSString *category = workoutDetails.categories[i];
            [categoriesString appendString:[NSString stringWithFormat:@",%@", category]];
        }
        [json setObject:categoriesString forKey:API_REQ_KEY_CATEGORIES];
    }
    
    if (workoutDetails.title) {
        [json setObject:workoutDetails.title forKey:API_REQ_KEY_TITLE];
    }
    
    if (workoutDetails.workoutDate) {
        
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:workoutDetails.workoutDate];
        
        if (dateString) {
            [json setObject:dateString forKey:API_REQ_KEY_WORKOUT_DATE];
        }
    }
    
    if (workoutDetails.startTime) {
        
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"h:mm a"];
        NSString *startTimeString = [dateFormatter stringFromDate:workoutDetails.startTime];
        
        [json setObject:startTimeString forKey:API_REQ_KEY_START_TIME];
    }
    
    if (workoutDetails.duration) {
        [json setObject:workoutDetails.duration forKey:API_REQ_KEY_DURATION];
    }
    
    if (workoutDetails.repeatsUID) {
        [json setObject:workoutDetails.repeatsUID forKey:API_REQ_KEY_FREQUENCY];
    }
    
    if (workoutDetails.amount) {
        [json setObject:workoutDetails.amount forKey:API_REQ_KEY_AMOUNT];
    }
    
    if (workoutDetails.additionalInfo) {
        [json setObject:workoutDetails.additionalInfo forKey:API_REQ_KEY_ADDITION];
    }
    
    if (workoutDetails.location) {
        [json setObject:workoutDetails.location forKey:API_REQ_KEY_USER_LOCATION];
    }
    
    if (workoutDetails.latitude) {
        [json setObject:workoutDetails.latitude forKey:API_REQ_KEY_USER_LATITUDE];
    }
    
    if (workoutDetails.longitude) {
        [json setObject:workoutDetails.longitude forKey:API_REQ_KEY_USER_LONGITUDE];
    }
    
    return json;
}

@end
