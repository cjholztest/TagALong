//
//  TermsPrivacyTableViewCell.m
//  TagALong
//
//  Created by Nikita Vintonovich on 5/21/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "TermsPrivacyTableViewCell.h"

@implementation TermsPrivacyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *acceptTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iAcceptTermsPrivacyAction)];
    [self.acceptActionView addGestureRecognizer:acceptTap];
    
    self.checkBoxImageView.layer.cornerRadius = self.imageView.bounds.size.width / 2.0f;
    self.checkBoxImageView.layer.borderWidth = 1.0f;
    self.checkBoxImageView.layer.borderColor = UIColor.whiteColor.CGColor;
    
    self.checkBoxImageView.tintColor = UIColor.whiteColor;
}

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

- (void)iAcceptTermsPrivacyAction {
    if ([self.output respondsToSelector:@selector(iAcceptDidTap)]) {
        [self.output iAcceptDidTap];
    }
}

@end
