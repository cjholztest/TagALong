//
//  ProUserEditProfileBankCredentialsCellAdapter.m
//  TagALong
//
//  Created by User on 7/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserEditProfileBankCredentialsCellAdapter.h"
#import "ProUserEditProfilePaymentInfoTableViewCell.h"
#import "UIView+Nib.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"
#import "NSString+Validation.h"

@interface ProUserEditProfileBankCredentialsCellAdapter()

@property (nonatomic, weak) id <ProUserEditProfileBankCredentialsCellAdapterOutput> output;

@end

@implementation ProUserEditProfileBankCredentialsCellAdapter

- (instancetype)initWithOutput:(id<ProUserEditProfileBankCredentialsCellAdapterOutput>)output {
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
    
    cell.titleLabel.text = @"Bank Info";
    
    NSString *bankData = self.output.bankCredentialsData;
    
    if (!bankData) {
        [self.output loadBankCredentialsInfoWithComplation:^(NSString *result) {
            cell.valueLabel.text = result;
        }];
    } else {
        cell.valueLabel.text = bankData;
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
    [self.output bankCredentialsDidTap];
}


@end
