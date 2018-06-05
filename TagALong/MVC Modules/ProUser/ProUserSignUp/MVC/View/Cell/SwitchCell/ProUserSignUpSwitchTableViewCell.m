//
//  ProUserSignUpSwitchTableViewCell.m
//  TagALong
//
//  Created by User on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserSignUpSwitchTableViewCell.h"

@implementation ProUserSignUpSwitchTableViewCell

#pragma mark - Actions

- (IBAction)switcherValueDidChange:(UISwitch *)sender {
    if ([self.output respondsToSelector:@selector(switcherDidChange:)]) {
        [self.output switcherDidChange:sender.isOn];
    }
}

@end
