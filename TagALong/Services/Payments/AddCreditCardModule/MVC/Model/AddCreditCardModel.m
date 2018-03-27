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
    STPCardParams *cardparameters = cardParams;
    cardparameters.currency = @"USD";
    [[STPAPIClient sharedClient] createTokenWithCard:cardparameters completion:^(STPToken * _Nullable token, NSError * _Nullable error) {
        if (error) {
            [weakSelf.output creditCardDidCreateWithError:error];
        } else {
            [PaymentClient sendCardToken:token.tokenId password:weakSelf.userPassword completion:^(id responseObject, NSError *error) {
                [weakSelf.output creditCardDidCreateWithError:error];
            }];
        }
    }];
}



@end
