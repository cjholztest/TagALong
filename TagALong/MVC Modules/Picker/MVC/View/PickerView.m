//
//  PickerView.m
//  TagALong
//
//  Created by User on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "PickerView.h"

@interface PickerView()

@end

@implementation PickerView

#pragma mark - PickerViewInput

#pragma mark - Actions

- (IBAction)doneButtonAction:(UIButton*)doneButton {
    if ([self.output respondsToSelector:@selector(doneButtonDidTap)]) {
        [self.output doneButtonDidTap];
    }
}

@end
