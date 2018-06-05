//
//  NSDateFormatter+Workout.h
//  TagALong
//
//  Created by User on 6/5/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Workout)

+ (NSString*)workoutDateStringFromDate:(NSDate*)date;
+ (NSString*)workoutTimeStringFromDate:(NSDate*)date;

@end
