//
//  PaymentClient+Customer.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/22/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "PaymentClient+Customer.h"

NSString *const kEphemeralKeyURLPath = @"get_ephemeral_keys";
NSString *const kPayoutAccoubtURLPath = @"payout_account";
NSString *const kApiVersion = @"2018-02-28";

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

+ (void)registerExpertWithPaymentData:(NSDictionary*)params completion:(PaymentCompletion)paymentCompletion {
    AFHTTPSessionManager *manager = [PaymentClient sessionManager];
    NSString *url = [NSString stringWithFormat:@"%@%@", kBasePaymentURL, kPayoutAccoubtURLPath];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if (paymentCompletion) {
            paymentCompletion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
//        NSError *jsonError = nil;
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
        
        NSString *errorMessage = nil; //dict[@"error"][@"message"];
        NSError *errorToDisplay = nil;
        if (errorMessage) {
            NSMutableDictionary* customDetails = [NSMutableDictionary dictionary];
            [customDetails setValue:errorMessage forKey:NSLocalizedDescriptionKey];
            errorToDisplay = [NSError errorWithDomain:@"local" code:200 userInfo:customDetails];
        } else {
            errorToDisplay = error;
        }
        if (paymentCompletion) {
            paymentCompletion(nil, errorToDisplay);
        }
    }];
}

+ (void)updateExpertWithPaymentData:(NSDictionary*)params completion:(PaymentCompletion)paymentCompletion {
    AFHTTPSessionManager *manager = [PaymentClient sessionManager];
    NSString *url = [NSString stringWithFormat:@"%@%@", kBasePaymentURL, kPayoutAccoubtURLPath];
    
    [manager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (paymentCompletion) {
            paymentCompletion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
//                NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
//                NSError *jsonError = nil;
//                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
        
        NSString *errorMessage = nil; //dict[@"error"][@"message"];
        NSError *errorToDisplay = nil;
        if (errorMessage) {
            NSMutableDictionary* customDetails = [NSMutableDictionary dictionary];
            [customDetails setValue:errorMessage forKey:NSLocalizedDescriptionKey];
            errorToDisplay = [NSError errorWithDomain:@"local" code:200 userInfo:customDetails];
        } else {
            errorToDisplay = error;
        }
        if (paymentCompletion) {
            paymentCompletion(nil, errorToDisplay);
        }
    }];
}

+ (void)expertPaymentDataWithCompletion:(PaymentCompletion)paymentCompletion {
    AFHTTPSessionManager *manager = [PaymentClient sessionManager];
    NSString *url = [NSString stringWithFormat:@"%@%@", kBasePaymentURL, kPayoutAccoubtURLPath];
    
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
