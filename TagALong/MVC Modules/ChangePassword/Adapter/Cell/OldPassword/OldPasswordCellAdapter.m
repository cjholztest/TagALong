//
//  OldPasswordCellAdapter.m
//  TagALong
//
//  Created by User on 7/25/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "OldPasswordCellAdapter.h"
#import "ChangePasswordTableViewCell.h"
#import "UIView+Nib.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"

@interface OldPasswordCellAdapter() <ChangePasswordTableViewCellOutput, UITextFieldDelegate>

@property (nonatomic, weak) id <OldPasswordCellAdapterOutput> output;

@end

@implementation OldPasswordCellAdapter

- (instancetype)initWithOutput:(id<OldPasswordCellAdapterOutput>)output {
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
    
    cell.textField.text = [self.output oldPassword];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName : UIColor.placeholderColor, NSFontAttributeName : [UIFont textFont]};
    cell.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Old Password" attributes:attributes];
    
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
    [self.output oldPasswordDidChange:text];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
