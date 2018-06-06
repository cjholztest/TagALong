//
//  NSDateFormatter+ServerRequest.m
//  TagALong
//
//  Created by Nikita Vintonovich on 6/5/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "NSDateFormatter+ServerRequest.h"

static NSString *const kServerDateFormatString = @"YYYY-MM-dd";
static NSString *const kServerTimeFormatString = @"h:mm a";

@implementation NSDateFormatter (ServerRequest)

+ (NSDate*)workoutDateFromString:(NSString*)dateString {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = kServerDateFormatString;
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

+ (NSDate*)workoutTimeFromString:(NSString*)timeString {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = kServerTimeFormatString;
    NSDate *time = [dateFormatter dateFromString:timeString];
    return time;
}

+ (NSString*)workoutDateStringFromDate:(NSDate*)date {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = kServerDateFormatString;
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

@end
