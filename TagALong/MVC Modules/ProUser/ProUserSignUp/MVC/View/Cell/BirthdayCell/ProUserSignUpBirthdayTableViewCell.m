//
//  ProUserSignUpBirthdayTableViewCell.m
//  TagALong
//
//  Created by User on 7/12/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserSignUpBirthdayTableViewCell.h"

@implementation ProUserSignUpBirthdayTableViewCell

#pragma mark - Actions

- (IBAction)monthButtonAction:(UIButton*)button {
    if ([self.output respondsToSelector:@selector(monthButtonDidTap)]) {
        [self.output monthButtonDidTap];
    }
}

- (IBAction)yearButtonAction:(UIButton*)button {
    if ([self.output respondsToSelector:@selector(yearButtonDidTap)]) {
        [self.output yearButtonDidTap];
    }
}

@end
