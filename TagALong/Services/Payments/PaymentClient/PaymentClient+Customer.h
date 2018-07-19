//
//  PaymentClient+Customer.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/22/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "PaymentClient.h"

@interface PaymentClient (Customer)

+ (void)createCustomerKeyWithCompletion:(PaymentCompletion)paymentCompletion;
+ (void)registerExpertWithPaymentData:(NSDictionary*)params completion:(PaymentCompletion)paymentCompletion;
+ (void)updateExpertWithPaymentData:(NSDictionary*)params completion:(PaymentCompletion)paymentCompletion;
+ (void)expertPaymentDataWithCompletion:(PaymentCompletion)paymentCompletion;

@end
