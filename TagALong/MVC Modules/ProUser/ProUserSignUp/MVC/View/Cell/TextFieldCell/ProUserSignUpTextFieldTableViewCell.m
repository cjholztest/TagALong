//
//  ProUserSignUpTextFieldTableViewCell.m
//  TagALong
//
//  Created by User on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserSignUpTextFieldTableViewCell.h"

@implementation ProUserSignUpTextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.textField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - Actions

- (void)textDidChange:(UITextField*)textField {
    if ([self.output respondsToSelector:@selector(textDidChange:)]) {
        [self.output textDidChange:textField.text];
    }
}

@end
