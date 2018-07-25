//
//  ChangePasswordTableViewCell.m
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ChangePasswordTableViewCell.h"
#import "UITableViewCell+Styles.h"

@implementation ChangePasswordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self applyClearStyle];
    [self.textField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - Actions

- (void)textDidChange:(UITextField*)textField {
    if ([self.output respondsToSelector:@selector(textDidChange:)]) {
        [self.output textDidChange:textField.text];
    }
}

- (IBAction)showButtonAction:(UIButton*)button {
    [self.textField setSecureTextEntry:!self.textField.isSecureTextEntry];
    [self updateApperance];
}

- (void)updateApperance {
    
    NSString *imageName = self.textField.isSecureTextEntry ? @"show_password" : @"hide_password";
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.showPasswordButton.tintColor = UIColor.whiteColor
    ;
    [self.showPasswordButton setImage:image forState:UIControlStateNormal];
    [self.showPasswordButton setImage:image forState:UIControlStateSelected];
    [self.showPasswordButton setImage:image forState:UIControlStateHighlighted];
}

@end
