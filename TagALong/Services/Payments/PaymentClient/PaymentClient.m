//
//  PaymentClient.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "PaymentClient.h"
#import <Stripe/Stripe.h>

NSString *const kBasePaymentURL = @"http://54.202.234.120:8080/api/payments/"; // <-- Live
//NSString *const kBasePaymentURL = @"http://18.218.218.141:8080/api/payments/"; // <-- Test
//@"http://192.168.10.206:8080/api/payments/";

@implementation PaymentClient

+ (AFHTTPSessionManager*)sessionManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    return manager;
}

@end
