//
//  PaymentClient.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "PaymentClient.h"
#import <Stripe/Stripe.h>

@implementation PaymentClient

+ (PaymentClient*)shared {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [PaymentClient new];
    });
    return instance;
}

- (void)createCustomerKeyWithApiVersion:(NSString*)apiVersion completion:(void(^)(id object))completion {

    NSString *url = @"http://192.168.10.206:8080/api/payments/get_ephemeral_keys";
    
//    [SharedAppDelegate showLoading];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        //        NSError* error;
        //        NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:respObject
        //                                                                       options:kNilOptions
        //                                                                         error:&error];
//        [SharedAppDelegate closeLoading];
        
        if (completion) {
            completion(responseObject);
        }        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
//        [SharedAppDelegate closeLoading];
        [Commons showToast:@"Failed to communicate with the server"];
    }];
}

- (void)sendCardToken:(NSString*)token completion:(void(^)(id object))completion {
    NSString *url = @"http://192.168.10.206:8080/api/payments/credit_card";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    NSDictionary *params = @{@"card_token" : token};
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        //        [SharedAppDelegate closeLoading];
        [Commons showToast:@"Failed to communicate with the server"];
    }];
}

- (void)listOfCrediCardsWithCompletion:(void(^)(id object, NSError *error))completion {
    NSString *url = @"http://192.168.10.206:8080/api/payments/credit_card";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:Global.access_token forHTTPHeaderField:@"access_token"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        //        [SharedAppDelegate closeLoading];
//        [Commons showToast:@"Failed to communicate with the server"];
        if (completion) {
            completion(nil, error);
        }
    }];
}

@end
