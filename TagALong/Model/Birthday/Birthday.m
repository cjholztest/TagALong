//
//  Birthday.m
//  TagALong
//
//  Created by User on 7/12/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "Birthday.h"

@implementation Birthday

- (BOOL)dataExists {
    return self.monthTitle.length > 0 && self.yearTitle.length > 0;
}

- (NSTimeInterval)timeInterval {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[NSDate date]];
    
    [dateComponents setDay:1];
    [dateComponents setMonth:self.monthIndex];
    [dateComponents setYear:self.yearTitle.integerValue];
    
    NSDate *date = [calendar dateFromComponents:dateComponents];

    return date.timeIntervalSince1970;
}

@end
