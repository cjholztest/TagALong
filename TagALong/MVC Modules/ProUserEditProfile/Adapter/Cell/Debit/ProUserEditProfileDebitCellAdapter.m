//
//  ProUserEditProfileDebitCellAdapter.m
//  TagALong
//
//  Created by User on 7/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserEditProfileDebitCellAdapter.h"
#import "ProUserEditProfilePaymentInfoTableViewCell.h"
#import "UIView+Nib.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"
#import "NSString+Validation.h"

@interface ProUserEditProfileDebitCellAdapter()

@property (nonatomic, weak) id <ProUserEditProfileDebitCellAdapterOutput> output;

@end

@implementation ProUserEditProfileDebitCellAdapter

- (instancetype)initWithOutput:(id<ProUserEditProfileDebitCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProUserSignUpCellAdapter

- (void)registerCellsInTableView:(UITableView*)tableView {
    [tableView registerNib:ProUserEditProfilePaymentInfoTableViewCell.viewNib forCellReuseIdentifier:ProUserEditProfilePaymentInfoTableViewCell.reuseIdentifier];
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
    ProUserEditProfilePaymentInfoTableViewCell *cell = (ProUserEditProfilePaymentInfoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:ProUserEditProfilePaymentInfoTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    cell.titleLabel.text = @"Debit Card";
    
    NSString *debitCardData = self.output.debitData;
    
    if (!debitCardData) {
        [self.output loadDebitInfoWithCompletion:^(NSString *result) {
            cell.valueLabel.text = result;
        }];
    } else {
        cell.valueLabel.text = debitCardData;
    }
    
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
    [self.output debitDidTap];
}

@end
