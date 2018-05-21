//
//  ProUserSignUpView.m
//  TagALong
//
//  Created by User on 5/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProUserSignUpView.h"

@interface ProUserSignUpView()

@end

@implementation ProUserSignUpView

#pragma mark - Actions

- (IBAction)registerButtonAction:(UIButton*)button {
    if ([self.output respondsToSelector:@selector(signUpButtonDidTap)]) {
        [self.output signUpButtonDidTap];
    }
}

@end
