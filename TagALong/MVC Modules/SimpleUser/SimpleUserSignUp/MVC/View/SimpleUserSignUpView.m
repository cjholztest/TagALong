//
//  SimpleUserSignUpView.m
//  TagALong
//
//  Created by Nikita Vintonovich on 6/1/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SimpleUserSignUpView.h"

@implementation SimpleUserSignUpView

- (IBAction)signUpButtonAction:(UIButton*)button {
    if ([self.output respondsToSelector:@selector(signUpButtonDidTap)]) {
        [self.output signUpButtonDidTap];
    }
}

@end
