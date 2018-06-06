//
//  ProfilePaymentRegistrationFooter.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/26/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProfilePaymentRegistrationFooter.h"

@implementation ProfilePaymentRegistrationFooter

- (IBAction)skipButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(skipButtonDidTap)]) {
        [self.delegate skipButtonDidTap];
    }
}

- (IBAction)sendCredentialsButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sendCredentialsButtonDidTap)]) {
        [self.delegate sendCredentialsButtonDidTap];
    }
}

@end
