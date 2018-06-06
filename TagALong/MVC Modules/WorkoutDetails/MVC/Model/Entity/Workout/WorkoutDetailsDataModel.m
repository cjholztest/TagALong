//
//  WorkoutDetailsDataModel.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/29/18.
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

- (BOOL)isAmountEmpty {
    BOOL isEmpty = (self.amount.integerValue == 0 ||
                    self.amount.floatValue == 0.0f ||
                    self.amount.integerValue == -1 ||
                    [self.amount.stringValue isEqualToString:@""] || !self.amount);
    return isEmpty;
}

@end
