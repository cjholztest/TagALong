//
//  WorkoutDetailsDataModel.m
//  TagALong
//
//  Created by User on 5/29/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "WorkoutDetailsDataModel.h"

@implementation WorkoutDetailsDataModel

- (NSString*)amountText {
    
    if ([self.amount floatValue] > 0.0f) {
        return [NSString stringWithFormat:@"$ %.2f", self.amount.floatValue];
    }
    return @"FREE";
}

@end
