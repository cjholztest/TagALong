//
//  AddCreditCardView.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "AddCreditCardView.h"
#import <Stripe/Stripe.h>

@implementation AddCreditCardView

- (STPPaymentCardTextField*)paymentCardTextField {
    if (!_paymentCardTextField) {
        _paymentCardTextField = [STPPaymentCardTextField new];
        [_paymentCardTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.paymentCardContainerView addSubview:_paymentCardTextField];
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:_paymentCardTextField
                                                                attribute:NSLayoutAttributeLeading
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.paymentCardContainerView
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1
                                                                 constant:0];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:_paymentCardTextField
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.paymentCardContainerView
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1
                                                                constant:0];
        NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:_paymentCardTextField
                                                                    attribute:NSLayoutAttributeTrailing
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.paymentCardContainerView
                                                                    attribute:NSLayoutAttributeTrailing
                                                                   multiplier:1
                                                                     constant:0];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_paymentCardTextField
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.paymentCardContainerView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1
                                                                   constant:0];
        [self.paymentCardContainerView addConstraints:@[leading, top, trailing, bottom]];
    }
    return _paymentCardTextField;
}

@end
