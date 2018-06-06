//
//  NSDateFormatter+Workout.m
//  TagALong
//
//  Created by Nikita Vintonovich on 6/5/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "NSDateFormatter+Workout.h"

static NSString *const kDisplayWorkoutDateFormat = @"MM/dd/yyyy";
static NSString *const kDisplayWorkoutTimeFormat = @"h:mm a";

@implementation NSDateFormatter (Workout)

+ (NSString*)workoutDateStringFromDate:(NSDate*)date {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = kDisplayWorkoutDateFormat;
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSString*)workoutTimeStringFromDate:(NSDate*)date {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = kDisplayWorkoutTimeFormat;
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

@end
