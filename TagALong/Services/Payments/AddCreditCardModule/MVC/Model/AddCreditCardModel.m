//
//  AddCreditCardModel.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "AddCreditCardModel.h"
#import <Stripe/Stripe.h>
#import "PaymentClient+CreditCard.h"

@interface AddCreditCardModel ()

@property (nonatomic, strong) NSString *userPassword;

@end

@implementation AddCreditCardModel

- (void)passwordDidEnter:(NSString*)password {
    self.userPassword = password;
}

- (BOOL)isUserPasswordEntered {
    return self.userPassword.length > 0;
}

- (void)createCreditCardWithCardParams:(STPCardParams*)cardParams {
    __weak typeof(self)weakSelf = self;
    [[STPAPIClient sharedClient] createTokenWithCard:cardParams completion:^(STPToken * _Nullable token, NSError * _Nullable error) {
        if (error) {
            [weakSelf.output creditCardDidCreateWithError:error];
        } else {
            BOOL isExpert = [Global.g_user.user_login isEqualToString:@"2"];
            [PaymentClient sendCardToken:token.tokenId isExpertUser:isExpert completion:^(id responseObject, NSError *error) {
                [weakSelf.output creditCardDidCreateWithError:error];
            }];
        }
    }];
}

@end
