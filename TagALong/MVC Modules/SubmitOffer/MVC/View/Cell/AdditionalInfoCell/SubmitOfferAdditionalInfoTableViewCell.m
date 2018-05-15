//
//  SubmitOfferAdditionalInfoTableViewCell.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferAdditionalInfoTableViewCell.h"
#import "UITextView+TextSize.h"

@interface SubmitOfferAdditionalInfoTableViewCell()

@end

@implementation SubmitOfferAdditionalInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.additionalInfoTextView setTextContainerInset:UIEdgeInsetsZero];
    self.additionalInfoTextView.textContainer.lineFragmentPadding = 0;
}

- (void)layoutIfNeeded {
    [super layoutIfNeeded];
    [self updateTextViewAppearance];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateTextViewAppearance];
}

#pragma mark - Help Methods

- (void)updateTextViewAppearance {
    self.additionalTextViewLayoutConstraint.constant = [self.additionalInfoTextView textHeight];
}

@end
