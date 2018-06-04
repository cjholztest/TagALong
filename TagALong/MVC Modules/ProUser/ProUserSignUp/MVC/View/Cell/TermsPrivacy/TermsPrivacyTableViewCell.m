//
//  TermsPrivacyTableViewCell.m
//  TagALong
//
//  Created by User on 5/21/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "TermsPrivacyTableViewCell.h"

@implementation TermsPrivacyTableViewCell

#pragma mark - Actions

- (IBAction)termsButtonAction:(UIButton*)button {
    if ([self.output respondsToSelector:@selector(termsDidTap)]) {
        [self.output termsDidTap];
    }
}

- (IBAction)privacyButtonAction:(UIButton*)button {
    if ([self.output respondsToSelector:@selector(privacyDidTap)]) {
        [self.output privacyDidTap];
    }
}

@end
