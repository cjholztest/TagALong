//
//  NSDateFormatter+ServerRequest.h
//  TagALong
//
//  Created by User on 6/5/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (ServerRequest)

+ (NSDate*)workoutDateFromString:(NSString*)dateString;
+ (NSDate*)workoutTimeFromString:(NSString*)timeString;

+ (NSString*)workoutDateStringFromDate:(NSDate*)date;

@end
