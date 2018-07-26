//
//  PickerView.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/17/18.
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

- (IBAction)cancelButtonAction:(UIButton*)cancelButton {
    if ([self.output respondsToSelector:@selector(cancelButtonDidTap)]) {
        [self.output cancelButtonDidTap];
    }
}

@end
