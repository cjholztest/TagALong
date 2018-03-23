//
//  PaymentClient+CreditCard.m
//  TagALong
//
//  Created by User on 3/22/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "PaymentClient+CreditCard.h"

static NSString *const kSimpleUserCreditCardURLPath = @"credit_card";
static NSString *const kExpertUserCreditCardURLPath = @"payout_credit_card";

@implementation PaymentClient (CreditCard)

+ (void)sendCardToken:(NSString*)token isExpertUser:(BOOL)isExpertUser completion:(PaymentCompletion)paymentCompletion {
    
    AFHTTPSessionManager *manager = [PaymentClient sessionManager];
    NSString *creditCardUrlPath = isExpertUser ? kExpertUserCreditCardURLPath : kSimpleUserCreditCardURLPath;
    NSString *url = [NSString stringWithFormat:@"%@%@", kBasePaymentURL, creditCardUrlPath];
    NSDictionary *params = @{@"card_token" : token};
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if (paymentCompletion) {
            paymentCompletion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (paymentCompletion) {
            paymentCompletion(nil, error);
        }
    }];
}

+ (void)listOfCrediCardsForUser:(BOOL)isExpertUser completion:(PaymentCompletion)paymentCompletion {
    
    AFHTTPSessionManager *manager = [PaymentClient sessionManager];
    NSString *creditCardUrlPath = isExpertUser ? kExpertUserCreditCardURLPath : kSimpleUserCreditCardURLPath;
    NSString *url = [NSString stringWithFormat:@"%@%@", kBasePaymentURL, creditCardUrlPath];;
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if (paymentCompletion) {
            paymentCompletion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (paymentCompletion) {
            paymentCompletion(nil, error);
        }
    }];
}

@end
