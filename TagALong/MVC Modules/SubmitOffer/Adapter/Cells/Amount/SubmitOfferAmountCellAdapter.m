//
//  SubmitOfferAmountCellAdapter.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferAmountCellAdapter.h"
#import "SubmitOfferAmountTableViewCell.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"
#import "UIView+Nib.h"

@interface SubmitOfferAmountCellAdapter() <SubmitOfferAmountTableViewCellOutput, UITextFieldDelegate>

@property (nonatomic, weak) id <SubmitOfferAmountCellAdapterOutput> output;

@end

@implementation SubmitOfferAmountCellAdapter

- (instancetype)initWithOutput:(id<SubmitOfferAmountCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - SubmitOfferCellAdapter

- (UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    SubmitOfferAmountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SubmitOfferAmountTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    cell.output = self;
    
    NSString *amount = [self.output amount];
    
    if (amount.length > 0) {
        cell.amountTextField.text = [NSString stringWithFormat:@"$ %@", amount];
    }
    
    cell.amountTextField.delegate = self;
    [cell.amountTextField setTintColor:[UIColor textColor]];
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName : UIColor.placeholderColor, NSFontAttributeName : [UIFont textFont]};
    cell.amountTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"$ 0.00" attributes:attributes];
    
    return cell;
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.0f;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54.0f;
}

- (void)registerCellsInTableView:(UITableView *)tableView {
    [tableView registerNib:SubmitOfferAmountTableViewCell.viewNib forCellReuseIdentifier:SubmitOfferAmountTableViewCell.reuseIdentifier];
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    if ([self.output respondsToSelector:@selector(amountCellDidTap)]) {
        [self.output amountCellDidTap];
    }
}

#pragma mark - SubmitOfferAmountTableViewCellOutput

- (void)amountValueDidChange:(NSString *)amount {
    if ([self.output respondsToSelector:@selector(amountDidChange:)]) {
        [self.output amountDidChange:amount];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
