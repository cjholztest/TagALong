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
#import <FBSDKCoreKit/FBSDKCoreKit.h>


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
        NSDictionary *params = @{FBSDKAppEventParameterNameSuccess : @(error ? YES : NO),
                                 API_REQ_KEY_USER_EMAIL         :   [Preference getString:PREFCONST_LOGIN_EMAIL default:nil],
                                 API_REQ_KEY_USER_CITY          :   [Preference getString:PREFCONST_LOCATION default:nil],
                                 API_REQ_KEY_USER_PHONE         :   [Preference getString:PREFCONST_PHONE default:nil],
                                 };
        [self logAddedPaymentInfoEvent:params];

        if (error) {
            [weakSelf.output creditCardDidCreateWithError:error];
        } else {
            [PaymentClient sendCardToken:token.tokenId password:weakSelf.userPassword completion:^(id responseObject, NSError *error) {
                [weakSelf.output creditCardDidCreateWithError:error];
            }];
        }
    }];
}

- (void)createCreditCardForProUserWithCardParams:(STPCardParams*)cardParams {
    __weak typeof(self)weakSelf = self;
    STPCardParams *cardparameters = cardParams;
    cardparameters.currency = @"USD";
    [[STPAPIClient sharedClient] createTokenWithCard:cardparameters completion:^(STPToken * _Nullable token, NSError * _Nullable error) {
        NSDictionary *params = @{FBSDKAppEventParameterNameSuccess : @(error ? YES : NO),
                                 API_REQ_KEY_USER_EMAIL         :   [Preference getString:PREFCONST_EXPERT_LOGIN_EMAIL default:nil],
                                 API_REQ_KEY_USER_CITY          :   [Preference getString:PREFCONST_EXPERT_LOCATION default:nil],
                                 API_REQ_KEY_USER_PHONE         :   [Preference getString:PREFCONST_EXPERT_PHONE default:nil],
        };
        [self logAddedPaymentInfoEvent:params];
        if (error) {
            [weakSelf.output creditCardDidCreateWithError:error];
        } else {
            [PaymentClient sendProUserCreditCardToken:token.tokenId password:weakSelf.userPassword completion:^(id responseObject, NSError *error) {
                [weakSelf.output creditCardDidCreateWithError:error];
            }];
        }
    }];
}

- (void)logAddedPaymentInfoEvent:(NSDictionary*)params {
    [FBSDKAppEvents
     logEvent:FBSDKAppEventNameAddedPaymentInfo
     parameters:params];
}

@end
