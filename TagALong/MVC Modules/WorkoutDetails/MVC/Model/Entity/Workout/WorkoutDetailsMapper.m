//
//  WorkoutDetailsMapper.m
//  TagALong
//
//  Created by User on 5/29/18.
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
    model.startTime = [formatter dateFromString:startTimeString];
    
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

@end
