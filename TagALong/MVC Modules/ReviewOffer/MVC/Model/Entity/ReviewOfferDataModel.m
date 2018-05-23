//
//  ReviewOfferDataModel.m
//  TagALong
//
//  Created by User on 5/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ReviewOfferDataModel.h"

@implementation ReviewOfferDataModel

- (NSString*)timeString {
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"h:mm a";
    
    return [dateFormatter stringFromDate:self.workoutTime];
}

@end
