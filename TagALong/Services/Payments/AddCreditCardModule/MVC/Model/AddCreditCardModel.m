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

@end

@implementation AddCreditCardModel

- (void)createCreditCardWithCardParams:(STPCardParams*)cardParams {
    __weak typeof(self)weakSelf = self;
    [[STPAPIClient sharedClient] createTokenWithCard:cardParams completion:^(STPToken * _Nullable token, NSError * _Nullable error) {
        if (error) {
            [weakSelf.output creditCardDidCreateWithError:error];
        } else {
            [PaymentClient sendCardToken:token.tokenId completion:^(id responseObject, NSError *error) {
                [weakSelf.output creditCardDidCreateWithError:error];
            }];
        }
    }];
}

@end
