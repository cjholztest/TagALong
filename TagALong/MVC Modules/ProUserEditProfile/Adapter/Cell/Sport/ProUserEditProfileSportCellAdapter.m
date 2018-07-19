//
//  ProUserEditProfileSportCellAdapter.m
//  TagALong
//
//  Created by User on 7/18/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserEditProfileSportCellAdapter.h"
#import "ProUserEditProfileTableViewCell.h"
#import "UIView+Nib.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"

@interface ProUserEditProfileSportCellAdapter() <ProUserEditProfileTableViewCellOutput, UITextFieldDelegate>

@property (nonatomic, weak) id <ProUserEditProfileSportCellAdapterOutput> output;

@end

@implementation ProUserEditProfileSportCellAdapter

- (instancetype)initWithOutput:(id<ProUserEditProfileSportCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProUserEditProfileCellAdapter

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
    
    cell.textField.text = [self.output sport];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName : UIColor.placeholderColor, NSFontAttributeName : [UIFont textFont]};
    cell.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Sport" attributes:attributes];
    
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
    [self.output sportDidChange:text];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
