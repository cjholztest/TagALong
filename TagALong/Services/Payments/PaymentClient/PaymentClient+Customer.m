//
//  PaymentClient+Customer.m
//  TagALong
//
//  Created by User on 3/22/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "PaymentClient+Customer.h"

NSString *const kEphemeralKeyURLPath = @"get_ephemeral_keys";
NSString *const kApiVersion = @"2015-10-12";

@implementation PaymentClient (Customer)

+ (void)createCustomerKeyWithCompletion:(PaymentCompletion)paymentCompletion {
    
    AFHTTPSessionManager *manager = [PaymentClient sessionManager];
    NSString *url = [NSString stringWithFormat:@"%@%@", kBasePaymentURL, kEphemeralKeyURLPath];
    
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {        
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
