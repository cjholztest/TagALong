//
//  ProUserEditProfileLastNameCellAdapter.m
//  TagALong
//
//  Created by User on 7/16/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserEditProfileLastNameCellAdapter.h"
#import "ProUserEditProfileTableViewCell.h"
#import "UIView+Nib.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"

@interface ProUserEditProfileLastNameCellAdapter() <ProUserEditProfileTableViewCellOutput, UITextFieldDelegate>

@property (nonatomic, weak) id <ProUserEditProfileLastNameCellAdapterOutput> output;

@end

@implementation ProUserEditProfileLastNameCellAdapter

- (instancetype)initWithOutput:(id<ProUserEditProfileLastNameCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProUserSignUpCellAdapter

- (void)registerCellsInTableView:(UITableView*)tableView {
    [tableView registerNib:ProUserEditProfileTableViewCell.viewNib forCellReuseIdentifier:ProUserEditProfileTableViewCell.reuseIdentifier];
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
    ProUserEditProfileTableViewCell *cell = (ProUserEditProfileTableViewCell*)[tableView dequeueReusableCellWithIdentifier:ProUserEditProfileTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    cell.output = self;
    cell.textField.delegate = self;
    
    cell.textField.keyboardType = UIKeyboardTypeDefault;
    cell.textField.keyboardAppearance = UIKeyboardAppearanceDark;
    
    cell.textField.secureTextEntry = NO;
    
    [cell.textField setTintColor:[UIColor textColor]];
    [cell.textField setTextColor:[UIColor textColor]];
    
    cell.textField.text = [self.output lastName];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName : UIColor.placeholderColor, NSFontAttributeName : [UIFont textFont]};
    cell.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Last Name" attributes:attributes];
    
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

#pragma mark - ProUserEditProfileTableViewCellOutput

- (void)textDidChange:(NSString*)text {
    if ([self.output respondsToSelector:@selector(lastNameDidChange:)]) {
        [self.output lastNameDidChange:text];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
