//
//  NewPasswordCellAdapter.m
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "NewPasswordCellAdapter.h"
#import "ChangePasswordTableViewCell.h"
#import "UIView+Nib.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"

@interface NewPasswordCellAdapter() <ChangePasswordTableViewCellOutput, UITextFieldDelegate>

@property (nonatomic, weak) id <NewPasswordCellAdapterOutput> output;

@end

@implementation NewPasswordCellAdapter

- (instancetype)initWithOutput:(id<NewPasswordCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProUserEditProfileCellAdapter

- (void)registerCellsInTableView:(UITableView*)tableView {
    [tableView registerNib:ChangePasswordTableViewCell.viewNib forCellReuseIdentifier:ChangePasswordTableViewCell.reuseIdentifier];
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
    ChangePasswordTableViewCell *cell = (ChangePasswordTableViewCell*)[tableView dequeueReusableCellWithIdentifier:ChangePasswordTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    cell.output = self;
    cell.textField.delegate = self;
    
    cell.textField.keyboardType = UIKeyboardTypeDefault;
    cell.textField.keyboardAppearance = UIKeyboardAppearanceDark;
    
    cell.textField.secureTextEntry = YES;
    [cell updateApperance];
    
    [cell.textField setTintColor:[UIColor textColor]];
    [cell.textField setTextColor:[UIColor textColor]];
    
    cell.textField.text = [self.output newPassword];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName : UIColor.placeholderColor, NSFontAttributeName : [UIFont textFont]};
    cell.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"New Password" attributes:attributes];
    
    return cell;
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 44.0f;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 44.0f;
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath*)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
}

#pragma mark - ChangePasswordTableViewCellOutput

- (void)textDidChange:(NSString*)text {
    [self.output newPasswordDidCange:text];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
