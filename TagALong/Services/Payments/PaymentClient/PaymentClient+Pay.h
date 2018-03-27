//
//  PaymentClient+Pay.h
//  TagALong
//
//  Created by User on 3/27/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "PaymentClient.h"

@interface PaymentClient (Pay)

+ (void)payForWorkoutWithParams:(NSDictionary*)params withCompletion:(PaymentCompletion)paymentCompletion;

@end
