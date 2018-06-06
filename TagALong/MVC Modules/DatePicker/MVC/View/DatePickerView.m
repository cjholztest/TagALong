//
//  DatePickerView.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/22/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView

#pragma mark - Actions

- (IBAction)doneButtonAction:(UIButton *)sender {
    if ([self.output respondsToSelector:@selector(doneButtonDidTap)]) {
        [self.output doneButtonDidTap];
    }
}

@end
