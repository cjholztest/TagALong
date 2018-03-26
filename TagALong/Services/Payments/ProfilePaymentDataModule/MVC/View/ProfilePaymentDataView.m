//
//  ProfilePaymentDataView.m
//  TagALong
//
//  Created by User on 3/23/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProfilePaymentDataView.h"

@interface ProfilePaymentDataView ()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *birthdayPickerBottomConatraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *birthdayPickerHeightConatraint;

@end

@implementation ProfilePaymentDataView

- (void)upsateBirthdayPickerAppearanceWithVisibleState:(BOOL)isVisible {
    const CGFloat margin = 5.0;
    if (isVisible) {
        [self.birthdayContainerView setHidden:!isVisible];
        [UIView animateWithDuration:0.5 animations:^{
            self.birthdayMaskView.alpha = 0.8;
            self.birthdayPickerBottomConatraint.constant = margin;
            [self layoutIfNeeded];
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.birthdayMaskView.alpha = 0.0;
            self.birthdayPickerBottomConatraint.constant = - (self.birthdayPickerHeightConatraint.constant + margin);
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (finished) {
                [self.birthdayContainerView setHidden:!isVisible];
            }
        }];
    }
}

#pragma mark - Actions

- (IBAction)birthdayDoneButtonAction:(id)sender {
    if ([self.eventHandler respondsToSelector:@selector(birthdayPickerDoneButtonDidTap)]) {
        [self.eventHandler birthdayPickerDoneButtonDidTap];
    }
}

@end
