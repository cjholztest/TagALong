//
//  ProUserSignUpSportActivityCellAdapter.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/31/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserSignUpSportActivityCellAdapter.h"
#import "ProUserSignUpTextFieldTableViewCell.h"
#import "UIView+Nib.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"

@interface ProUserSignUpSportActivityCellAdapter() <ProUserSignUpTextFieldTableViewCellOutput, UITextFieldDelegate>

@property (nonatomic, weak) id <ProUserSignUpSportActivityCellAdapterOutput> output;

@end

@implementation ProUserSignUpSportActivityCellAdapter

- (instancetype)initWithOutput:(id<ProUserSignUpSportActivityCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProUserSignUpCellAdapter

- (void)registerCellsInTableView:(UITableView*)tableView {
    [tableView registerNib:ProUserSignUpTextFieldTableViewCell.viewNib forCellReuseIdentifier:ProUserSignUpTextFieldTableViewCell.reuseIdentifier];
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
    ProUserSignUpTextFieldTableViewCell *cell = (ProUserSignUpTextFieldTableViewCell*)[tableView dequeueReusableCellWithIdentifier:ProUserSignUpTextFieldTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    cell.textField.keyboardType = UIKeyboardTypeDefault;
    cell.textField.keyboardAppearance = UIKeyboardAppearanceDark;
    
    cell.textField.secureTextEntry = NO;
    
    [cell.textField setTintColor:[UIColor textColor]];
    
    cell.textField.text = [self.output sportActivity];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName : UIColor.placeholderColor, NSFontAttributeName : [UIFont textFont]};
    cell.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Sport" attributes:attributes];
    
    cell.textField.delegate = self;
    cell.output = self;
    
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

#pragma mark - ProUserSignUpTextFieldTableViewCellOutput

- (void)textDidChange:(NSString*)text {
    if ([self.output respondsToSelector:@selector(sportActivityDidChange:)]) {
        [self.output sportActivityDidChange:text];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
