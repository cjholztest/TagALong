//
//  PaymentClient.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/19/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PaymentCompletion)(id responseObject, NSError *error);

extern NSString *const kBasePaymentURL;

@interface PaymentClient : NSObject

+ (AFHTTPSessionManager*)sessionManager;

@end
