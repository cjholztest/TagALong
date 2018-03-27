//
//  PaymentClient+Pay.m
//  TagALong
//
//  Created by User on 3/27/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "PaymentClient+Pay.h"

static NSString *const kPayWorkoutURLPath = @"pay_for_workout";

@implementation PaymentClient (Pay)

+ (void)payForWorkoutWithParams:(NSDictionary *)params withCompletion:(PaymentCompletion)paymentCompletion {
    AFHTTPSessionManager *manager = [PaymentClient sessionManager];
    NSString *url = [NSString stringWithFormat:@"%@%@", kBasePaymentURL, kPayWorkoutURLPath];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if (paymentCompletion) {
            paymentCompletion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSError *jsonError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
        NSString *errorMessage = dict[@"message"];
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

@end
