//
//  ProUserSignUpTermsPrivacyCellAdapter.m
//  TagALong
//
//  Created by User on 5/21/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserSignUpTermsPrivacyCellAdapter.h"
#import "TermsPrivacyTableViewCell.h"
#import "UIView+Nib.h"
#import "UIColor+AppColors.h"
#import "UIFont+HelveticaNeue.h"

@interface ProUserSignUpTermsPrivacyCellAdapter() <TermsPrivacyTableViewCellOutput>

@property (nonatomic, weak) id <ProUserSignUpTermsPrivacyCellAdapterOutput> output;

@end

@implementation ProUserSignUpTermsPrivacyCellAdapter

- (instancetype)initWithOutput:(id<ProUserSignUpTermsPrivacyCellAdapterOutput>)output {
    if (self = [super init]) {
        self.output = output;
    }
    return self;
}

#pragma mark - ProUserSignUpCellAdapter

- (void)registerCellsInTableView:(UITableView*)tableView {
    [tableView registerNib:TermsPrivacyTableViewCell.viewNib forCellReuseIdentifier:TermsPrivacyTableViewCell.reuseIdentifier];
}

- (UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
    TermsPrivacyTableViewCell *cell = (TermsPrivacyTableViewCell*)[tableView dequeueReusableCellWithIdentifier:TermsPrivacyTableViewCell.reuseIdentifier forIndexPath:indexPath];
    
    cell.output = self;
    
    return cell;
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 88.0f;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 88.0f;
}

- (BOOL)shouldHighightRowAtIndexPath:(NSIndexPath*)indexPath {
    return YES;
}

- (void)didSelectRowInTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath {
    
}

#pragma mark - TermsPrivacyTableViewCellOutput

- (void)termsDidTap {
    if ([self.output respondsToSelector:@selector(termsDidTap)]) {
        [self.output termsDidTap];
    }
}

- (void)privacyDidTap {
    if ([self.output respondsToSelector:@selector(privacyDidTap)]) {
        [self.output privacyDidTap];
    }
}

@end
