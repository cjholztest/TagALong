//
//  SubmitOfferWhatCellAdapter.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferWhatCellAdapter.h"
#import "SubmitOfferWhoTableViewCell.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"
#import "UIView+Nib.h"

@interface SubmitOfferWhatCellAdapter() <SubmitOfferWhoTableViewCellOutput, UITextFieldDelegate>

@property (nonatomic, weak) id <SubmitOfferWhatCellAdapterOutput> output;

@end

@implementation SubmitOfferWhatCellAdapter

- (instancetype)initWithOutput:(id<SubmitOfferWhatCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - SubmitOfferCellAdapter

- (UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    SubmitOfferWhoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SubmitOfferWhoTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    cell.output = self;
    cell.whoTextField.delegate = self;
    [cell.whoTextField setTintColor:[UIColor textColor]];

    cell.whoTextField.text = [self.output what];

    NSDictionary *attributes = @{NSForegroundColorAttributeName : UIColor.placeholderColor, NSFontAttributeName : [UIFont textFont]};
    cell.whoTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Running, Cycling, Yoga ..." attributes:attributes];
    
    return cell;
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.0;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.0;
}

- (void)registerCellsInTableView:(UITableView *)tableView {
    [tableView registerNib:SubmitOfferWhoTableViewCell.viewNib forCellReuseIdentifier:SubmitOfferWhoTableViewCell.reuseIdentifier];
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    if ([self.output respondsToSelector:@selector(whatCellDidTap)]) {
        [self.output whatCellDidTap];
    }
}

#pragma mark - SubmitOfferWhoTableViewCellOutput

- (void)enteredTexDidChange:(NSString *)text {
    if ([self.output respondsToSelector:@selector(whatTextDidChange:)]) {
        [self.output whatTextDidChange:text];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
