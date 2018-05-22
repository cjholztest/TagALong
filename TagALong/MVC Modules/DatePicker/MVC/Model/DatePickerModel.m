//
//  DatePickerModel.m
//  TagALong
//
//  Created by User on 5/22/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "DatePickerModel.h"

@interface DatePickerModel()

@property (nonatomic, weak) id <DatePickerModelOutput> output;
@property (nonatomic, assign) DatePickerType type;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation DatePickerModel

- (instancetype)initWithOutput:(id<DatePickerModelOutput>)output andType:(DatePickerType)type {
    if (self = [super init]) {
        
        self.output = output;
        self.type = type;
        self.selectedIndex = -1;
        
        switch (type) {
            case DateDatePickerType:
//                [self setupDurationComponents];
                break;
            case TimeDatePickerType:
//                [self setupSportComponents];
                break;
            default:
                break;
        }
    }
    return self;
}

#pragma mark - DatePickerModelInput

#pragma mark - Private

- (void)setupDateComponents {
    
}

- (void)setupTimeComponents {
    
}

@end
