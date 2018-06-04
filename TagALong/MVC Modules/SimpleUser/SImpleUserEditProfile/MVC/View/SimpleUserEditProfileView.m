//
//  SImpleUserEditProfileView.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SimpleUserEditProfileView.h"

@implementation SimpleUserEditProfileView

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *areaRadiusTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(areaViewTapAction)];
    [self.areaContentView addGestureRecognizer:areaRadiusTap];
}

#pragma mark - Actions

- (IBAction)creditCardButtonAction:(UIButton*)button {
    if ([self.output respondsToSelector:@selector(editCreditButtonDidTap)]) {
        [self.output editCreditButtonDidTap];
    }
}

- (IBAction)limitSwitcherAction:(UISwitch *)sender {
    if ([self.output respondsToSelector:@selector(limitSwitcherDidChange:)]) {
        [self.output limitSwitcherDidChange:sender.isOn];
    }
}

- (void)areaViewTapAction {
    if ([self.output respondsToSelector:@selector(areaRadiusDidTap)]) {
        [self.output areaRadiusDidTap];
    }
}

@end
