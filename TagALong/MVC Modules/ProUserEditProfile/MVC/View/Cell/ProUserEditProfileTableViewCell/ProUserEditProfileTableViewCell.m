//
//  ProUserEditProfileTableViewCell.m
//  TagALong
//
//  Created by User on 7/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserEditProfileTableViewCell.h"
#import "UITableViewCell+Styles.h"

@implementation ProUserEditProfileTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self applyClearStyle];
    [self.textField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Actions

- (void)textDidChange:(UITextField*)textField {
    if ([self.output respondsToSelector:@selector(textDidChange:)]) {
        [self.output textDidChange:textField.text];
    }
}

@end
